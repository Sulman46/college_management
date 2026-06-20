import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/controllers/screen_resizing/screen_resize_cubit.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class CourseMappingCubit extends Cubit<CourseMappingState> {
  final CourseMappingUseCase _useCase;
  CourseMappingCubit(this._useCase) : super(CourseMappingInit());

  TextEditingController searchController=TextEditingController();

  CourseMappingModel updateMappingModel=CourseMappingModel();
  CourseMappingModel courseMappingModel=CourseMappingModel();

  List<CourseMappingModel> _courseMappingList=[];
  List<CourseMappingModel>  get courseMappingList=>_courseMappingList;
  List<CourseMappingModel>  get activeCourseMappingList=>_courseMappingList.where((element) => element.status=="Active",).toList();

  List<CourseMappingModel> _filterMapping=[];
  List<CourseMappingModel>  get filterMapping=>_filterMapping;

  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;

  void getButtonPosition({required double topVal,required double rightVal}){
    emit(CourseMappingLoading());
    top+=topVal;
    right-=rightVal;
    emit(CourseMappingLoaded());
  }

  void updateModel(CourseMappingModel value){
    emit(CourseMappingLoading());
    updateMappingModel=value;
    courseMappingModel=value;
    emit(CourseMappingLoaded());
  }

  void getCourseMappingModel(CourseMappingModel value){
    emit(CourseMappingLoading());
    courseMappingModel=value;
    emit(CourseMappingLoaded());
  }

  Future<bool> addMapping(CourseMappingModel value)async{
    showLoadingDialog();
    emit(CourseMappingLoading());
    var response=await _useCase.addMapping(value: value);
    if(response.isRight()){
      courseMappingModel=CourseMappingModel();
      searchController.clear();
      _courseMappingList.add(response.asRight());
      _filterMapping=List.from(courseMappingList);
      emit(CourseMappingLoaded());
      closeLoadingDialog();
      return true;
    }else{
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(CourseMappingLoaded());
      return false;
    }
  }

  Future<bool> update(CourseMappingModel value)async{
    showLoadingDialog();
    emit(CourseMappingLoading());
    value=value.copyWith(id: updateMappingModel.id);
    var response=await _useCase.update(value: value);
    if(response.isRight()){
      courseMappingModel=CourseMappingModel();
      searchController.clear();
      int index=courseMappingList.indexWhere((element) => element.id==value.id,);
      _courseMappingList[index]=response.asRight();
      _filterMapping=List.from(courseMappingList);
      emit(CourseMappingLoaded());
      closeLoadingDialog();
      return true;
    }else{
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(CourseMappingLoaded());
      return false;
    }
  }

  Future<bool> delete(CourseMappingModel value)async{
    showLoadingDialog();
    emit(CourseMappingLoading());
    var response=await _useCase.delete(value: value);
    if(response.isRight()){
      courseMappingModel=CourseMappingModel();
      searchController.clear();
      _courseMappingList.removeWhere((element) => element.id==value.id,);
      _filterMapping=List.from(courseMappingList);
      emit(CourseMappingLoaded());
      closeLoadingDialog();
      return true;
    }else{
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(CourseMappingLoaded());
      return false;
    }
  }

  Future<void> getMappingData()async{
    searchController.clear();
    showLoadingDialog();
    emit(CourseMappingLoading());
    var response=await _useCase.getMappingData();
    if(response.isRight()){
      _courseMappingList=response.asRight();
      _filterMapping=courseMappingList;
      emit(CourseMappingLoaded());
      closeLoadingDialog();
    }else{
      showMessage(response.asLeft(),isError: true);
      closeLoadingDialog();
      emit(CourseMappingLoaded());
    }
  }

  void filterData(String val){
    emit(CourseMappingLoading());
    List<CourseMappingModel> temp=[];
    for(var i in courseMappingList){
      if(i.semesterName!.toLowerCase().toString().contains(val)||i.program!.toLowerCase().toString().contains(val)|| i.department!.toLowerCase().toString().contains(val)|| i.degree!.toLowerCase().toString().contains(val)|| i.affiliation!.toLowerCase().toString().contains(val)|| i.status!.toLowerCase().toString().contains(val)||i.courseCode!.toLowerCase().toString().contains(val) || i.courseTitle!.toLowerCase().toString().contains(val)){
        temp.add(i);
      }
    }

    _filterMapping=temp;
    emit(CourseMappingLoaded());
  }



}

