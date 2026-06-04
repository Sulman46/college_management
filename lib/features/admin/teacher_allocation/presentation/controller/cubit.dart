import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/teacher_allocation_model.dart';
import 'state.dart';

class TeacherAllocationCubit extends Cubit<TeacherAllocationState> {
  final TeacherAllocationUseCase _useCase;
  TeacherAllocationCubit(this._useCase) : super(TeacherAllocationInit());

  TextEditingController searchController=TextEditingController();

  TeacherAllocationModel teacherAllocationModel=TeacherAllocationModel();
  String status="Active";

  List<TeacherAllocationModel> _teacherAllocationList=[];
  List<TeacherAllocationModel> get teacherAllocationList=>_teacherAllocationList;

  List<TeacherAllocationModel> _filterTeacherAllocation=[];
  List<TeacherAllocationModel> get filterTeacherAllocation=>_filterTeacherAllocation;
  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;
  void getButtonPosition({required double topVal,required double rightVal}){
    emit(TeacherAllocationLoading());
    top+=topVal;
    right-=rightVal;
    emit(TeacherAllocationLoaded());
  }

  void getTeacherAllocationModel(TeacherAllocationModel model,{String? statusVal}){
    emit(TeacherAllocationLoading());
    status=statusVal??status;
    teacherAllocationModel=model.copyWith(status: statusVal??status);
    emit(TeacherAllocationLoaded());
  }

  Future<bool> post(TeacherAllocationModel value)async{

    if(value.combinedPrograms!.length==1){
      var temp=value;
      value=temp.copyWith(isCombinedClass: false,programName: temp.combinedPrograms!.first,combinedPrograms: []);
    }else{
      var temp=value;
      value=temp.copyWith(isCombinedClass: true,programName: "",combinedPrograms: temp.combinedPrograms);
    }
    showLoadingDialog();
    emit(TeacherAllocationLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TeacherAllocationLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      var data=response.asRight();
      _teacherAllocationList.add(data);
      _filterTeacherAllocation=List.from(teacherAllocationList);
      _filterTeacherAllocation.toSet();
      emit(TeacherAllocationLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<bool> delete(TeacherAllocationModel value)async{
    showLoadingDialog();
    emit(TeacherAllocationLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TeacherAllocationLoaded());
      closeLoadingDialog();
      return false;
    }else{
      searchController.clear();
      _teacherAllocationList.removeWhere((element) => element.id==value.id,);
      _filterTeacherAllocation=List.from(teacherAllocationList);
      emit(TeacherAllocationLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<bool> update(TeacherAllocationModel value)async{
    if(value.combinedPrograms!.length==1){
      var temp=value;
      value=temp.copyWith(isCombinedClass: false,programName: temp.combinedPrograms!.first,combinedPrograms: []);
    }else{
      var temp=value;
      value=temp.copyWith(isCombinedClass: true,programName: "",combinedPrograms: temp.combinedPrograms);
    }
    showLoadingDialog();
    emit(TeacherAllocationLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TeacherAllocationLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      int index= teacherAllocationList.indexWhere((element) => element.id==value.id,);
      searchController.clear();
      _teacherAllocationList[index]=value;
      _filterTeacherAllocation=List.from(teacherAllocationList);
      emit(TeacherAllocationLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<void> get()async{
    showLoadingDialog();
    emit(TeacherAllocationLoading());
    searchController.clear();
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft());
      emit(TeacherAllocationLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _teacherAllocationList=data;
      _filterTeacherAllocation=List.from(teacherAllocationList);
      emit(TeacherAllocationLoaded());
      closeLoadingDialog();
    }
  }


  void filterData(String val){
    emit(TeacherAllocationLoading());
    List<TeacherAllocationModel> temp=[];
    for(var i in teacherAllocationList){
      if(i.programName!.toLowerCase().toString().contains(val)||i.teacherName!.toLowerCase().toString().contains(val)|| i.department!.toLowerCase().toString().contains(val)|| i.degree!.toLowerCase().toString().contains(val)|| i.affiliation!.toLowerCase().toString().contains(val)|| i.status!.toLowerCase().toString().contains(val)){
        temp.add(i);
      }
    }

    _filterTeacherAllocation=temp;
    emit(TeacherAllocationLoaded());
  }


}
