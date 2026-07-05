import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/helper/data_extractor.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/add_semester_model.dart';
import 'state.dart';

class SemesterAdminCubit extends Cubit<SemesterAdminState> {
  final SemesterAdminUseCase _useCase;
  SemesterAdminCubit(this._useCase) : super(SemesterAdminInit());

  bool isEdit=false;


  List<SemesterLevelsModel> get filterSemesterList=>semesterList.where((i) => i.programModel!.name.toLowerCase().toString().contains(searchVal)|| i.programModel!.departmentName.toLowerCase().toString().contains(searchVal)|| i.programModel!.degree.toLowerCase().toString().contains(searchVal)|| i.programModel!.affiliationName.toLowerCase().toString().contains(searchVal)|| i.status!.toLowerCase().toString().contains(searchVal),).toList();

  List<List<SemesterLevelsModel>> get groupedSemesterList {
    final Map<String, List<SemesterLevelsModel>> grouped = {};

    for (final semester in filterSemesterList) {
      final programId = semester.programModel?.id ?? "";

      grouped.putIfAbsent(programId, () => []);
      grouped[programId]!.add(semester);
    }

    // Sort semesters inside each program by semester number
    for (final semesters in grouped.values) {
      semesters.sort(
            (a, b) => DataExtractor.extractInt(a.semesterName)
            .compareTo(DataExtractor.extractInt(b.semesterName)),
      );
    }

    return grouped.values.toList();
  }
  List<SemesterLevelsModel> _semesterList=[];
  List<SemesterLevelsModel> get semesterList=>_semesterList;
  List<SemesterLevelsModel> get activeSemesterList=>List.from(semesterList.where((element) => element.status=="Active",));

  TextEditingController searchController = TextEditingController();

  AddSemesterModel _pickSemesterLevel=AddSemesterModel();
  AddSemesterModel get pickSemesterLevel=>_pickSemesterLevel;
  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double right=30;

  String searchVal="";

  void getSearchVal(String val){
    emit(SemesterAdminLoading());
    searchVal=val;
    emit(SemesterAdminLoaded());
  }

  void canEdit(bool val){
    emit(SemesterAdminLoading());
    isEdit=val;
    emit(SemesterAdminLoaded());
  }

  void getButtonPosition({required double topVal,required double rightVal}){
    emit(SemesterAdminLoading());
    top+=topVal;
    right-=rightVal;
    emit(SemesterAdminLoaded());
  }


  void getSemesterLevel(AddSemesterModel value){
    emit(SemesterAdminLoading());
    _pickSemesterLevel=value;
    emit(SemesterAdminLoaded());
  }

  SemesterLevelsModel nextSemesterModel=SemesterLevelsModel();

  void getNextSemesterModel(SemesterLevelsModel model){
    emit(SemesterAdminLoading());
    nextSemesterModel=model;
    emit(SemesterAdminLoaded());
  }

  Future<void> getSemesterList()async{
    canEdit(false);
    getSearchVal("");
    showLoadingDialog();
    _semesterList=[];
    searchController.clear();
    emit(SemesterAdminLoading());
    var response=await _useCase.getSemester();
    if(response.isRight()){
      _semesterList=response.asRight();
    }else{
      showMessage(response.asLeft(),isError: true);
    }
    emit(SemesterAdminLoaded());
    closeLoadingDialog();
  }

  Future<bool> addSemester(SemesterLevelsModel value)async{
    showLoadingDialog();
    emit(SemesterAdminLoading());
    var respo=await _useCase.addSemester(semesterModel: value);
    if(respo.isRight()){
      showMessage(respo.asRight());
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
      showMessage(respo.asRight());
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
      showMessage(respo.asRight());
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

  Future<bool> inactivePreSemester(List<SemesterLevelsModel> list)async{
    bool isSuccess=true;
    for(var i in list){
      if(i.status=="Active"){
        var respo=await _useCase.updateSemester(semesterModel: i.copyWith(status: "Inactive"));
        if(respo.isLeft()){
          showMessage(respo.asLeft(),isError:true );
          isSuccess=false;
          break;
        }
      }
    }
    return isSuccess;
  }

  Future<bool> moveNextSemester(List<SemesterLevelsModel> list)async{

    showLoadingDialog();
    emit(SemesterAdminLoading());
   var updateSem= await inactivePreSemester(list);
   if(!updateSem){
     emit(SemesterAdminLoaded());
     closeLoadingDialog();
     return false;
   }


    var respo=await _useCase.addSemester(semesterModel: nextSemesterModel.copyWith(status: "Active",semesterName: "${DataExtractor.extractInt(nextSemesterModel.semesterName)}"));

    if(respo.isRight()){
      showMessage(respo.asRight());
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





}
