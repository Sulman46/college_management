import 'package:college_management/features/admin/teacher_attendance/models/teacher_attendance_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class TeacherAttendanceCubit extends Cubit<TeacherAttendanceState> {
  final TeacherAttendanceUseCase _useCase;
  TeacherAttendanceCubit(this._useCase) : super(TeacherAttendanceInit());

  List<TeacherAttendanceModel> _dataList=[];
  List<TeacherAttendanceModel> get dataList=>_dataList;

  List<TeacherAttendanceModel> _filterList=[];
  List<TeacherAttendanceModel> get filterList=>_filterList;

  bool isHistory=false;

  void getTabVal(bool val){
    emit(TeacherAttendanceLoading());
    isHistory=val;
    if(!val){
      teacherFilterName="All Teacher";
      historyFilterType="All";
      historyFilterDate=DateTime.now();
    }
    emit(TeacherAttendanceLoaded());
  }

  String selectedDepartment="All Departments";
  String teacherFilterName="All Teacher";
  String historyFilterType="All";
  DateTime historyFilterDate=DateTime.now();

  TeacherAttendanceModel teacherAttendanceModel = TeacherAttendanceModel();
  void getTeacherAttendanceModel(TeacherAttendanceModel val) {
    emit(TeacherAttendanceLoading());
    teacherAttendanceModel = val;
    emit(TeacherAttendanceLoaded());
  }

  String get departmentFilter=>selectedDepartment=="All Departments"?"":selectedDepartment;

  void getDepartmentFilterValue(String val){
    emit(TeacherAttendanceLoading());
    selectedDepartment=val==""?"All Departments":val;
    emit(TeacherAttendanceLoaded());
  }

  void getFilterHistory(String filterType,DateTime date,String teacherName){
    emit(TeacherAttendanceLoading());
    historyFilterType=filterType;
    historyFilterDate=date;
    teacherFilterName=teacherName;
    emit(TeacherAttendanceLoaded());
  }




  Future<bool> post(TeacherAttendanceModel value)async{
    showLoadingDialog();
    emit(TeacherAttendanceLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TeacherAttendanceLoaded());
      closeLoadingDialog();
      return false;
    }else{
      emit(TeacherAttendanceLoaded());
      closeLoadingDialog();
      showMessage(response.asRight());
      return true;
    }
  }

  Future<void> get()async{
    _dataList=[];
    _filterList=[];
    showLoadingDialog();
    emit(TeacherAttendanceLoading());
    var response=await _useCase.get();
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TeacherAttendanceLoaded());
      closeLoadingDialog();
    }else{
      var data=response.asRight();
      _dataList=data;
      _filterList=List.from(dataList);
      emit(TeacherAttendanceLoaded());
      closeLoadingDialog();
    }
  }

  Future<bool> delete(TeacherAttendanceModel value)async{
    showLoadingDialog();
    emit(TeacherAttendanceLoading());
    var response=await _useCase.delete(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TeacherAttendanceLoaded());
      closeLoadingDialog();
      return false;
    }else{
      emit(TeacherAttendanceLoaded());
      closeLoadingDialog();
      showMessage(response.asRight());
      return true;
    }
  }


  Future<bool> update(TeacherAttendanceModel value)async{

    showLoadingDialog();
    emit(TeacherAttendanceLoading());
    var response=await _useCase.update(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TeacherAttendanceLoaded());
      closeLoadingDialog();
      return false;
    }else{

      emit(TeacherAttendanceLoaded());
      closeLoadingDialog();
      showMessage(response.asRight());
      return true;
    }
  }



  void filterData(String val){
    emit(TeacherAttendanceLoading());
    List<TeacherAttendanceModel> temp=[];
    for(var i in dataList){
      if(i.teacher!.toLowerCase().toString().contains(val)){
        temp.add(i);
      }
    }

    _filterList=temp;
    emit(TeacherAttendanceLoaded());
  }





}
