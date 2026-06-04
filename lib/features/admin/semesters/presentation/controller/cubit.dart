import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class SemesterAdminCubit extends Cubit<SemesterAdminState> {
  final SemesterAdminUseCase _useCase;
  SemesterAdminCubit(this._useCase) : super(SemesterAdminInit());

  List<SemesterLevelsModel> filterSemesterList=[];
  List<SemesterLevelsModel> _semesterList=[];
  List<SemesterLevelsModel> get semesterList=>_semesterList;

  TextEditingController searchController = TextEditingController();

  SemesterLevelsModel _pickSemesterLevel=SemesterLevelsModel();
  SemesterLevelsModel get pickSemesterLevel=>_pickSemesterLevel;
  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;

  void getButtonPosition({required double topVal,required double rightVal}){
    emit(SemesterAdminLoading());
    top+=topVal;
    right-=rightVal;
    emit(SemesterAdminLoaded());
  }
  void getSemesterLevel(SemesterLevelsModel value){
    emit(SemesterAdminLoading());
    _pickSemesterLevel=value;
    emit(SemesterAdminLoaded());
  }



  Future<void> getSemesterList()async{
    showLoadingDialog();
    emit(SemesterAdminLoading());
    var response=await _useCase.getSemester();

    if(response.isRight()){
      _semesterList=response.asRight();
      filterSemesterList=semesterList;
    }else{
      showMessage(response.asLeft());
    }
    emit(SemesterAdminLoaded());
    closeLoadingDialog();
  }

  Future<bool> addSemester(SemesterLevelsModel value)async{
    showLoadingDialog();
    emit(SemesterAdminLoading());
    var respo=await _useCase.addSemester(semesterModel: value);
    if(respo.isRight()){
      _semesterList.add(respo.asRight());
      filterSemesterList=semesterList;
      searchController.clear();
      closeLoadingDialog();
      emit(SemesterAdminLoaded());
      return true;
    }else{
      showMessage(respo.asLeft());
      closeLoadingDialog();
      emit(SemesterAdminLoaded());
      return false;
    }
  }

  Future<bool> editSemester(SemesterLevelsModel value)async{
    showLoadingDialog();
    emit(SemesterAdminLoading());
    var respo=await _useCase.updateSemester(semesterModel: value);
    if(respo.isRight()){
      int index=semesterList.indexWhere((element) => element.id==value.id,);
      _semesterList[index]=respo.asRight();
      filterSemesterList=semesterList;
      searchController.clear();
      closeLoadingDialog();
      emit(SemesterAdminLoaded());
      return true;
    }else{
      showMessage(respo.asLeft());
      closeLoadingDialog();
      emit(SemesterAdminLoaded());
      return false;
    }
  }

  Future<bool> deleteSemester(SemesterLevelsModel value)async{
    showLoadingDialog();
    emit(SemesterAdminLoading());
    var respo=await _useCase.deleteSemester(semesterModel: value);
    if(respo.isRight()){
      _semesterList.removeWhere((element) => element.id==value.id,);
      filterSemesterList=semesterList;
      searchController.clear();
      closeLoadingDialog();
      emit(SemesterAdminLoaded());
      return true;
    }else{
      showMessage(respo.asLeft());
      closeLoadingDialog();
      emit(SemesterAdminLoaded());
      return false;
    }
  }

  void filterData(String val){
    emit(SemesterAdminLoading());
    List<SemesterLevelsModel> temp=[];
      for(var i in semesterList){
        if(i.programName!.toLowerCase().toString().contains(val)|| i.department!.toLowerCase().toString().contains(val)|| i.degree!.toLowerCase().toString().contains(val)|| i.affiliation!.toLowerCase().toString().contains(val)|| i.status!.toLowerCase().toString().contains(val)){
          temp.add(i);
        }
      }

    filterSemesterList=temp;
    emit(SemesterAdminLoaded());
  }




}
