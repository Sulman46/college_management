import 'dart:math';

import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_filter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../../semesters/models/semester_levels_model.dart';
import '../../../semesters/presentation/controller/cubit.dart';
import '../../../student_registrations/models/student_model.dart';
import '../../data/models/student_enrollment_model.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class StudentEnrollmentCubit extends Cubit<StudentEnrollmentState> {
  final StudentEnrollmentUseCase _useCase;
  StudentEnrollmentCubit(this._useCase) : super(StudentEnrollmentInit());

  StudentEnrollmentFilterModel filterModel=StudentEnrollmentFilterModel();
  StudentEnrollmentFilterModel submittedData=StudentEnrollmentFilterModel();
  List<StudentEnrollmentModel> _dataList=[];
  List<StudentEnrollmentModel> get dataList=>_dataList;
  List<StudentEnrollmentModel> get filterDataList=>dataList.where((element) => element.status!="Promoted",).toList();

  List<StudentEnrollmentModel> _dataHistoryList=[];
  List<StudentEnrollmentModel> get dataHistoryList=>_dataHistoryList;
  List<StudentEnrollmentModel> get filterDataHistoryList=>dataHistoryList.where((element) => element.status!="Promoted",).toList();

  List<StudentEnrollmentModel> _selectedEnrollment=[];
  List<StudentEnrollmentModel> get selectedEnrollment=>_selectedEnrollment;

  List<StudentEnrollmentModel> _selectedEnrollmentHistory=[];
  List<StudentEnrollmentModel> get selectedEnrollmentHistory=>_selectedEnrollmentHistory;

  bool isNewTab=true;
  
  List<StudentModel> _selectNewStudentForEnroll=[];
  List<StudentModel> get selectNewStudentForEnroll=>_selectNewStudentForEnroll;


  int newStudentLength=0;

  void getTabIndex(bool val){
    emit(StudentEnrollmentLoading());
    isNewTab=val;
    selectAllNewStudent([],selectAll: false);
    selectAllEnrollment([],selectAll: false);
    selectAllEnrollmentHistory([],selectAll: false);
    emit(StudentEnrollmentLoaded());
  }


  void getStudentEnrollmentFilter(StudentEnrollmentFilterModel val){
    emit(StudentEnrollmentLoading());
    filterModel=val;
    emit(StudentEnrollmentLoaded());
  }

  void initDataList(){
    emit(StudentEnrollmentLoading());
    _dataList=[];
    _dataHistoryList=[];
    emit(StudentEnrollmentLoaded());
  }

  void initFunction(StudentEnrollmentFilterModel val){
    emit(StudentEnrollmentLoading());
    submittedData=val;

    selectAllNewStudent([],selectAll: false);
    selectAllEnrollment([],selectAll: false);
    selectAllEnrollmentHistory([],selectAll: false);
    emit(StudentEnrollmentLoaded());
  }

  void selectAllNewStudent(List<StudentModel>  allStudents,{required bool selectAll,}){
    emit(StudentEnrollmentLoading());
    if(selectAll){
      _selectNewStudentForEnroll=List.from(allStudents);
    }else{
      _selectNewStudentForEnroll=[];
    }
    emit(StudentEnrollmentLoaded());
  }

  void selectAllEnrollment(List<StudentEnrollmentModel>  allStudents,{required bool selectAll,}){
    emit(StudentEnrollmentLoading());
    if(selectAll){
      _selectedEnrollment=List.from(allStudents);
    }else{
      _selectedEnrollment=[];
    }
    emit(StudentEnrollmentLoaded());
  }

  void selectAllEnrollmentHistory(List<StudentEnrollmentModel>  allStudents,{required bool selectAll,}){
    emit(StudentEnrollmentLoading());
    if(selectAll){
      _selectedEnrollmentHistory=List.from(allStudents);
    }else{
      _selectedEnrollmentHistory=[];
    }
    emit(StudentEnrollmentLoaded());
  }

  void selectNewStudent(StudentModel value){
    emit(StudentEnrollmentLoading());
    if(selectNewStudentForEnroll.any((element) => element.id==value.id,)){
      _selectNewStudentForEnroll.removeWhere((element) => element.id==value.id,);
    }else{
      _selectNewStudentForEnroll.add(value);
    }
    emit(StudentEnrollmentLoaded());
  }

  void selectEnrollmentStudent(StudentEnrollmentModel value){
    emit(StudentEnrollmentLoading());
    if(_selectedEnrollment.any((element) => element.id==value.id,)){
      _selectedEnrollment.removeWhere((element) => element.id==value.id,);
    }else{
      _selectedEnrollment.add(value);
    }
    emit(StudentEnrollmentLoaded());
  }

  void selectEnrollmentHistoryStudent(StudentEnrollmentModel value){
    emit(StudentEnrollmentLoading());
    if(_selectedEnrollmentHistory.any((element) => element.id==value.id,)){
      _selectedEnrollmentHistory.removeWhere((element) => element.id==value.id,);
    }else{
      _selectedEnrollmentHistory.add(value);
    }
    emit(StudentEnrollmentLoaded());
  }


  Future<bool> get()async{
    _dataList=[];
    selectAllNewStudent([],selectAll: false);
    selectAllEnrollment([],selectAll: false);
    selectAllEnrollmentHistory([],selectAll: false);
    showLoadingDialog();
    isNewTab=false;
    emit(StudentEnrollmentLoading());
    var response=await _useCase.get(value: submittedData);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      _dataList=data;
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<bool> getHistory(StudentEnrollmentFilterModel val)async{
    _dataHistoryList=[];
    selectAllNewStudent([],selectAll: false);
    selectAllEnrollment([],selectAll: false);
    selectAllEnrollmentHistory([],selectAll: false);
    showLoadingDialog();
    emit(StudentEnrollmentLoading());
    var response=await _useCase.get(value: val);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      var data=response.asRight();
      _dataHistoryList=data;
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return true;
    }
  }

  Future<bool> enrollNewStudentFunction(StudentModel value)async{
    var response=await _useCase.post(value: StudentEnrollmentModel(semesterId: value.semesterId,studentId: value.id));
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      return false;
    }else{
      return true;
    }
  }

  Future<bool> enrollNewStudents()async{
    showLoadingDialog();
    emit(StudentEnrollmentLoading());
    List<StudentModel> data=List.from(selectNewStudentForEnroll);
    for(var i in data){
      var resp=await enrollNewStudentFunction(i);
      if(!resp){
        break;
      }else{
        _selectNewStudentForEnroll.removeWhere((element) => element.id==i.id,);
        emit(StudentEnrollmentLoaded());
      }
    }
    closeLoadingDialog();
    await get();
    emit(StudentEnrollmentLoaded());
    return true;
  }

  Future<bool> promoteStudentFunction(StudentEnrollmentModel value)async{
    var response=await _useCase.promote(value:value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      return false;
    }else{
      return true;
    }
  }

  Future<bool> promoteStudent()async{
    List<StudentEnrollmentModel> data=List.from(selectedEnrollment);
    final semesterCubit=DiContainer().sl<SemesterAdminCubit>();
    var model=semesterCubit.semesterList.where((element) => element.id==data.first.semesterId,).first;
    List<SemesterLevelsModel> targetSemester=semesterCubit.semesterList.where((element) => element.programId==model.programId && (DataExtractor.extractInt(element.semesterName))==(DataExtractor.extractInt(submittedData.semester)+1),).toList();
    if(targetSemester.isEmpty){
      showMessage("Next Semester not found");
      return false;
    }

    showLoadingDialog();
    emit(StudentEnrollmentLoading());
    for(var i in data){
      var resp=await promoteStudentFunction(i.copyWith(targetSemesterId: targetSemester.first.id,sourceSemesterId: i.semesterId));
      if(!resp){
        break;
      }else{
        selectedEnrollment.removeWhere((element) => element.id==i.id,);
        emit(StudentEnrollmentLoaded());
      }
    }
    closeLoadingDialog();
    await get();
    emit(StudentEnrollmentLoaded());
    return true;
  }

  Future<bool> demoteStudentFunction(StudentEnrollmentModel value)async{
    showMessage("#2432: ${value.enrollmentIdToDelete}/ ${value.studentId} // ${value.sourceSemesterId}");
    var response=await _useCase.demote(value:value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      return false;
    }else{
      return true;
    }
  }

  Future<bool> demoteStudent()async{
    List<StudentEnrollmentModel> data=List.from(selectedEnrollment);
    final semesterCubit=DiContainer().sl<SemesterAdminCubit>();
    var model=semesterCubit.semesterList.where((element) => element.id==data.first.semesterId,).first;
    List<SemesterLevelsModel> targetSemester=semesterCubit.semesterList.where((element) => element.programId==model.programId && (DataExtractor.extractInt(element.semesterName))==(DataExtractor.extractInt(submittedData.semester)-1),).toList();
    if(targetSemester.isEmpty){
      return false;
    }
    showLoadingDialog();
    emit(StudentEnrollmentLoading());
    for(var i in data){
      var resp=await demoteStudentFunction(i.copyWith(sourceSemesterId: targetSemester.first.id,enrollmentIdToDelete: i.id));
      if(!resp){
        break;
      }else{
        selectedEnrollment.removeWhere((element) => element.id==i.id,);
        emit(StudentEnrollmentLoaded());
      }
    }
    closeLoadingDialog();
    await get();
    emit(StudentEnrollmentLoaded());
    return true;
  }
  


  Future<bool> update(StudentEnrollmentModel value)async{
    showLoadingDialog();
    emit(StudentEnrollmentLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return false;
    }else{
      showMessage(response.asRight());
      emit(StudentEnrollmentLoaded());
      closeLoadingDialog();
      return true;
    }
  }
  
}
