import 'dart:math';

import 'package:college_management/features/admin/marking_student/models/bulk_save_marking_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../../course_mapping/model/course_mapping_model.dart';
import '../../../course_mapping/presentation/controller/cubit.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/marking_student_filter_model.dart';
import '../../models/marks_student_model.dart';
import 'state.dart';

class MarkingStudentCubit extends Cubit<MarkingStudentState> {
  final MarkingStudentUseCase _useCase;
  MarkingStudentCubit(this._useCase) : super(MarkingStudentInit());
  
  MarkingStudentFilterModel filterModel=MarkingStudentFilterModel();

  MarkingStudentFilterModel submittedData=MarkingStudentFilterModel();
  TextEditingController searchController=TextEditingController();

  MarksResponseModel _marksResponseModel=MarksResponseModel(dataList: [], isLocked: false);
  MarksResponseModel get marksResponseModel=>_marksResponseModel;

  List<MarksStudentModel> get dataList=>marksResponseModel.dataList;

  String filterName="";

  void dataInit(){
    emit(MarkingStudentLoading());
    searchController.clear();
    filterModel=MarkingStudentFilterModel();
    filterName="";
    submittedData=MarkingStudentFilterModel();
    _marksResponseModel=MarksResponseModel(dataList: [], isLocked: false);
    emit(MarkingStudentLoaded());
  }

  void getSearchText(String val){
    emit(MarkingStudentLoading());
    filterName=val;
    emit(MarkingStudentLoaded());
  }

  void getMarksStudentModel(MarksStudentModel model){
    emit(MarkingStudentLoading());
    List<MarksStudentModel> tempList=List.from(dataList);
    int index=tempList.indexWhere((element) => element.studentId==model.studentId,);
    tempList[index]=model;
    _marksResponseModel=marksResponseModel.copyWith(dataList: tempList);
    emit(MarkingStudentLoaded());
  }


  void getMarkingStudentFilter(MarkingStudentFilterModel val){
    emit(MarkingStudentLoading());
    filterModel=val;
    emit(MarkingStudentLoaded());
  }

  void initFunction(MarkingStudentFilterModel val){
    emit(MarkingStudentLoading());
    submittedData=val;
    emit(MarkingStudentLoaded());
  }

  Future<bool> getMarksStudent()async{
    filterName="";
    searchController.clear();

    _marksResponseModel=MarksResponseModel(dataList: [], isLocked: false);
    showLoadingDialog();
    emit(MarkingStudentLoading());
    var response=await _useCase.get(model: submittedData);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(MarkingStudentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      _marksResponseModel=data;
      emit(MarkingStudentLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<bool> saveBulk({bool? lockVal}) async {
    final courseMappingCubit = DiContainer().sl<CourseMappingCubit>();
    emit(MarkingStudentLoading());

    CourseMappingModel mapping = courseMappingCubit.courseMappingList.where(
          (element) => element.id == submittedData.mappingId,
    ).first;
    if(mapping.courseType==null){
      return false;
    }


    final request = BulkSaveMarksRequest(
      courseType: mapping.courseType ?? "Theory",
      marks: dataList.where((element) => element.marks!=null,).map((item) {
        final m = item.marks;
        return BulkSaveMarkingModel(
          studentId: item.studentId,
          semesterId: submittedData.semesterId,
          srNo: item.srNo,
          rollNo: item.rollNo,
          studentName: item.name,
          courseMappingId: submittedData.mappingId,
          semesterName: submittedData.semester,
          department: submittedData.department,
          program: submittedData.program,
          session: submittedData.session,
          section: submittedData.section,

          mids: m?.mids,
          sessional: m?.sessional,
          finalMarks: m?.finalMarks,
          practical: m?.practical,

          totalMarks: m?.totalMarks,
          grandMax: m?.grandMax,

          grade: m?.grade,
          gpa: m?.gpa,

          gradeOverride: null,
          gpaOverride: null,

          passed: m?.passed ?? false,
          isLocked:lockVal?? m?.isLocked ?? false,
        );
      }).toList(),
    );

    if(request.marks.isEmpty){
      showMessage("Please add Students marks");
      return false;
    }

    showLoadingDialog();


    var response=await _useCase.bulkSaveData(model: request);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(MarkingStudentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      showMessage(data);

      emit(MarkingStudentLoaded());
      closeLoadingDialog();
      return true;
    }

  }

  Future<bool> lockStatus({bool? lockVal}) async {
    final courseMappingCubit = DiContainer().sl<CourseMappingCubit>();
    emit(MarkingStudentLoading());

    CourseMappingModel mapping = courseMappingCubit.courseMappingList.where(
          (element) => element.id == submittedData.mappingId,
    ).first;
    if(mapping.courseType==null){
      return false;
    }


    final request = BulkSaveMarksRequest(
      courseType: mapping.courseType ?? "Theory",
      marks: dataList.where((element) => element.marks!=null,).map((item) {
        final m = item.marks;
        return BulkSaveMarkingModel(
          studentId: item.studentId,
          semesterId: submittedData.semesterId,
          srNo: item.srNo,
          rollNo: item.rollNo,
          studentName: item.name,
          courseMappingId: submittedData.mappingId,
          semesterName: submittedData.semester,
          department: submittedData.department,
          program: submittedData.program,
          session: submittedData.session,
          section: submittedData.section,

          mids: m?.mids,
          sessional: m?.sessional,
          finalMarks: m?.finalMarks,
          practical: m?.practical,

          totalMarks: m?.totalMarks,
          grandMax: m?.grandMax,

          grade: m?.grade,
          gpa: m?.gpa,

          gradeOverride: null,
          gpaOverride: null,

          passed: m?.passed ?? false,
          isLocked:lockVal?? m?.isLocked ?? false,
        );
      }).toList(),
    );

    if(request.marks.isEmpty){
      showMessage("Please add Students marks");
      return false;
    }

    showLoadingDialog();


    var response=await _useCase.lockStatus(model: request);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(MarkingStudentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      showMessage(data);

      emit(MarkingStudentLoaded());
      closeLoadingDialog();
      return true;
    }

  }

  
}
