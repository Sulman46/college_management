import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/hod_assign_model.dart';
import 'state.dart';

class HODAssignmentCubit extends Cubit<HODAssignmentState> {
  final HODAssignmentUseCase _useCase;
  HODAssignmentCubit(this._useCase) : super(HODAssignmentInit());



  TextEditingController searchController=TextEditingController();

  List<HodAssignModel> _dataList=[];
  List<HodAssignModel> get dataList=>_dataList;

  List<HodAssignModel> _filterList=[];
  List<HodAssignModel> get filterList=>_filterList;

  String selectedCategory="";
  int isArchive=0;

  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;
  void getButtonPosition({required double topVal,required double rightVal}){
    emit(HODAssignmentLoading());
    top+=topVal;
    right-=rightVal;
    emit(HODAssignmentLoaded());
  }

  HodAssignModel addHodAssignModel=HodAssignModel();



  void getHodAssignModel(HodAssignModel model){
    emit(HODAssignmentLoading());
    addHodAssignModel=model;
    emit(HODAssignmentLoaded());
  }

  Future<bool> post(HodAssignModel value)async{
    showLoadingDialog();
    emit(HODAssignmentLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(HODAssignmentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      var data=response.asRight();
      // _dataList.add(data);
      // _filterList=List.from(dataList);
      // _filterList.toSet();

      _dataList=[];
      _filterList=[];

      emit(HODAssignmentLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<void> get()async{
    showLoadingDialog();
    emit(HODAssignmentLoading());
    searchController.clear();
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(HODAssignmentLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _dataList=data;
      _filterList=List.from(_dataList);
      emit(HODAssignmentLoaded());
      closeLoadingDialog();
    }
  }

  Future<bool> delete(HodAssignModel value)async{
    showLoadingDialog();
    emit(HODAssignmentLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(HODAssignmentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      _dataList.removeWhere((element) => element.id==value.id,);
      _filterList=List.from(dataList);
      emit(HODAssignmentLoaded());
      closeLoadingDialog();
      return true;
    }
  }


  Future<bool> update(HodAssignModel value)async{

    showLoadingDialog();
    emit(HODAssignmentLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(HODAssignmentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      int index= dataList.indexWhere((element) => element.id==value.id,);
      searchController.clear();
      _dataList[index]=value;
      _filterList=List.from(dataList);
      emit(HODAssignmentLoaded());
      closeLoadingDialog();
      return true;
    }
  }



  void filterData(String val){
    emit(HODAssignmentLoading());
    List<HodAssignModel> temp=[];
    for(var i in dataList){
      if(i.teacherName!.toLowerCase().toString().contains(val) || i.departmentName!.toLowerCase().toString().contains(val) || i.status!.toLowerCase().toString().contains(val) ){
        temp.add(i);
      }
    }
    _filterList=temp;
    emit(HODAssignmentLoaded());
  }

  
}
