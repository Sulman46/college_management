import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../models/teacher_model.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class TeacherRecordsCubit extends Cubit<TeacherRecordsState> {
  final TeacherRecordsUseCase _useCase;
  TeacherRecordsCubit(this._useCase) : super(TeacherRecordsInit());

  TextEditingController searchController=TextEditingController();

  List<TeacherModel> _teacherList=[];
  List<TeacherModel> get teacherList=>_teacherList;
  List<TeacherModel> get activeTeacherList=>_teacherList.where((element) => element.status=="Active",).toList();

  List<TeacherModel> _filterTeacher=[];
  List<TeacherModel> get filterTeacher=>_filterTeacher;


  TeacherModel teacherModel=TeacherModel();
  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;

  void getButtonPosition({required double topVal,required double rightVal}){
    emit(TeacherRecordsLoading());
    top+=topVal;
    right-=rightVal;
    emit(TeacherRecordsLoaded());
  }

  void getTeacherModel(TeacherModel model){
    emit(TeacherRecordsLoading());
    teacherModel=model;
    emit(TeacherRecordsLoaded());
  }

  Future<bool> addTeacher(TeacherModel value)async{
    showLoadingDialog();
    emit(TeacherRecordsLoading());
    var response=await _useCase.addTeacher(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TeacherRecordsLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      var data=response.asRight();
      _teacherList.add(data);
      _filterTeacher=List.from(teacherList);
      emit(TeacherRecordsLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<bool> delete(TeacherModel value)async{
    showLoadingDialog();
    emit(TeacherRecordsLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TeacherRecordsLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      _teacherList.removeWhere((element) => element.id==value.id,);
      _filterTeacher=List.from(teacherList);
      emit(TeacherRecordsLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<bool> update(TeacherModel value)async{
    showLoadingDialog();
    emit(TeacherRecordsLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TeacherRecordsLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      int index= teacherList.indexWhere((element) => element.id==value.id,);
      searchController.clear();
      _teacherList[index]=data;
      _filterTeacher=List.from(teacherList);
      emit(TeacherRecordsLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<void> getTeachers()async{
    showLoadingDialog();
    emit(TeacherRecordsLoading());
    searchController.clear();
    var response=await _useCase.getTeachers();
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TeacherRecordsLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _teacherList=data;
      _filterTeacher=List.from(teacherList);
      emit(TeacherRecordsLoaded());
      closeLoadingDialog();
    }
  }


  void filterData(String val){
    emit(TeacherRecordsLoading());
    List<TeacherModel> temp=[];
    for(var i in teacherList){
      if(i.teacherName!.toLowerCase().toString().contains(val)||i.qualification!.toLowerCase().toString().contains(val)|| i.designation!.toLowerCase().toString().contains(val)|| i.allocationType!.toLowerCase().toString().contains(val)|| i.ratePerLecture!.toString().toLowerCase().contains(val)|| i.status!.toLowerCase().toString().contains(val)||i.specialization!.toLowerCase().toString().contains(val) ){
        temp.add(i);
      }
    }

    _filterTeacher=temp;
    emit(TeacherRecordsLoaded());
  }
  
  
}
