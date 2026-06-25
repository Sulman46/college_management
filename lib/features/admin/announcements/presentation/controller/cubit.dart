import 'package:college_management/features/admin/announcements/models/announcement_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  final AnnouncementsUseCase _useCase;
  AnnouncementsCubit(this._useCase) : super(AnnouncementsInit());
  
  TextEditingController searchController=TextEditingController();

  List<AnnouncementModel> _dataList=[];
  List<AnnouncementModel> get dataList=>_dataList;


  List<AnnouncementModel> _filterList=[];
  List<AnnouncementModel> get filterList=>_filterList;

  String selectedCategory="";
  int isArchive=0;

  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;
  void getButtonPosition({required double topVal,required double rightVal}){
    emit(AnnouncementsLoading());
    top+=topVal;
    right-=rightVal;
    emit(AnnouncementsLoaded());
  }

  AnnouncementModel addAnnouncementModel=AnnouncementModel();

  void filterCategory(String val)async{
    emit(AnnouncementsLoading());
    selectedCategory=val;
    emit(AnnouncementsLoaded());
  }

  void filterArchive(int val)async{
    emit(AnnouncementsLoading());
    isArchive=val;
    emit(AnnouncementsLoaded());
  }

  void getAnnouncementModel(AnnouncementModel model){
    emit(AnnouncementsLoading());
    addAnnouncementModel=model;
    emit(AnnouncementsLoaded());
  }
  
  Future<bool> post(AnnouncementModel value)async{
    showLoadingDialog();
    emit(AnnouncementsLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(AnnouncementsLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      var data=response.asRight();
      _dataList.add(data);
      _filterList=List.from(dataList);
      _filterList.toSet();
      emit(AnnouncementsLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<void> get()async{
    showLoadingDialog();
    emit(AnnouncementsLoading());
    searchController.clear();
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(AnnouncementsLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _dataList=data;
      _filterList=List.from(_dataList);
      emit(AnnouncementsLoaded());
      closeLoadingDialog();
    }
  }

  Future<bool> delete(AnnouncementModel value)async{
    showLoadingDialog();
    emit(AnnouncementsLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(AnnouncementsLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      _dataList.removeWhere((element) => element.id==value.id,);
      _filterList=List.from(dataList);
      emit(AnnouncementsLoaded());
      closeLoadingDialog();
      return true;
    }
  }


  Future<bool> update(AnnouncementModel value)async{

    showLoadingDialog();
    emit(AnnouncementsLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(AnnouncementsLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      int index= dataList.indexWhere((element) => element.id==value.id,);
      searchController.clear();
      _dataList[index]=value;
      _filterList=List.from(dataList);
      emit(AnnouncementsLoaded());
      closeLoadingDialog();
      return true;
    }
  }
  
  

  void filterData(String val){
    emit(AnnouncementsLoading());
    List<AnnouncementModel> temp=[];
    for(var i in dataList){
      if(i.title!.toLowerCase().toString().contains(val)){
        temp.add(i);
      }
    }

    _filterList=temp;
    emit(AnnouncementsLoaded());
  }

   void initFilter(){
    emit(AnnouncementsLoading());
    selectedCategory="";
    isArchive=0;
     top=mdHeight(navigatorKey.currentContext!)*.9;
     right=30;
    emit(AnnouncementsLoaded());
  }

}
