import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/features/admin/teacher_attendance/models/teacher_attendance_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/extensions/dart_extensions.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/loader_dialog.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../../../timetable_manager/models/time_table_manger_model.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/teacher_attendance_time_table_model.dart';
import 'state.dart';

class TeacherAttendanceCubit extends Cubit<TeacherAttendanceState> {
  final TeacherAttendanceUseCase _useCase;
  TeacherAttendanceCubit(this._useCase) : super(TeacherAttendanceInit());

  List<TeacherAttendanceModel> _dataList=[];
  List<TeacherAttendanceModel> get dataList=>_dataList;

  List<TeacherAttendanceModel> _filterList=[];
  List<TeacherAttendanceModel> get filterList=>_filterList;

   List<TeacherAttendanceTimeTableModel> _teacherDataList=[];
  List<TeacherAttendanceTimeTableModel> get teacherDataList=>_teacherDataList;


  bool isHistory=false;



  String selectedDepartment="All Departments";
  String teacherFilterName="All Teacher";
  String historyFilterType="All";
  DateTime historyFilterDate=DateTime.now();

  TeacherAttendanceModel teacherAttendanceModel = TeacherAttendanceModel();

  String attendanceType="";

  void getAttendanceType(String val){
    emit(TeacherAttendanceLoading());
    attendanceType=val;
    if(teacherDataList.isNotEmpty){
      for (int i=0;i< teacherDataList.length;i++){
      var model=  _teacherDataList[i];
      _teacherDataList[i]=model.copyWith(status: val,minutes: "0");
      }
    }
    emit(TeacherAttendanceLoaded());
  }

  void updateMinutes({required String minutes,required int index}){
    emit(TeacherAttendanceLoading());
    var model=  _teacherDataList[index];
    _teacherDataList[index]=model.copyWith(minutes:minutes );
    emit(TeacherAttendanceLoaded());
  }

  void updateType({required String type,required int index}){
    emit(TeacherAttendanceLoading());
    var model=  _teacherDataList[index];
    _teacherDataList[index]=model.copyWith(minutes:"0",status:type  );
    emit(TeacherAttendanceLoaded());
  }


  void getTeacherDataList(List<TimeTableManagerModel> timeTableData){
    attendanceType=ConstantData.teacherAttendanceStatus[0];
    _teacherDataList=[];
    emit(TeacherAttendanceLoading());

    DateTime selectedDate=teacherAttendanceModel.date!;
    String dayName = DateFormat('EEEE').format(selectedDate);
    var timeTableDataList=timeTableData
        .where(
            (element) =>
        element.id ==teacherAttendanceModel.timetableId);

    List<String>  timeSlotDataList= timeTableDataList
        .expand((element) => element.timeSlots!,).toList();

    for (int i=0;i< timeSlotDataList.length;i++ ){
      for(var mo in timeTableDataList.map((e) => e.data,).toList()){
        String slotKey="$dayName-$i";
        if(mo!.containsKey(slotKey)){
          var model=mo[slotKey];
          var alreadyModel=dataList.where((element) =>element.teacherId==model!.teacherId && element.room==model.room && element.subject==model.subject
              && (element.date!.year == teacherAttendanceModel.date!.year ||
              element.date!.month == teacherAttendanceModel.date!.month ||
              element.date!.day == teacherAttendanceModel.date!.day)).isNotEmpty;
          if(!alreadyModel){
            TeacherAttendanceTimeTableModel teacherTimeTableModel=TeacherAttendanceTimeTableModel(minutes: "0",status: ConstantData.teacherAttendanceStatus[0],tableCellModel: model!, slotTime: timeSlotDataList[i], slotIndex: i.toString());
            _teacherDataList.add(teacherTimeTableModel);
          }
        }
      }
    }
    emit(TeacherAttendanceLoaded());
  }

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
    emit(TeacherAttendanceLoading());
    var response=await _useCase.post(value: value);
    if(response.isLeft()){
      showMessage(response.asLeft(),isError: true);
      emit(TeacherAttendanceLoaded());
      return false;
    }else{
      emit(TeacherAttendanceLoaded());
      return true;
    }
  }

  Future<bool> uploadTeacherAttendance()async{
    final authCubit = DiContainer().sl<AuthenticationCubit>();
   final List<TeacherAttendanceTimeTableModel> list=List.from(teacherDataList);
    bool isCompleted=true;
    emit(TeacherAttendanceLoading());
    showLoadingDialog();
    for(var i in list){
      var model=teacherAttendanceModel.copyWith(slotTime: i.slotTime,slotIndex: i.slotIndex,minutes: i.status=="Late"|| i.status=="Early Left" ? int.parse(i.minutes):0,attendanceType: "Subject-Wise",teacher: i.tableCellModel.teacher,teacherId: i.tableCellModel.teacherId,subject: i.tableCellModel.subject,room: i.tableCellModel.room,status: i.status,markedBy: authCubit.userModel!.role.toJson());
      var res=await post(model);
      if(res){
        _teacherDataList.remove(i);
      }else{
        isCompleted=false;
      }
    }


    emit(TeacherAttendanceLoaded());
    closeLoadingDialog();
    await get();
    return isCompleted;
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
      _dataList.remove(value);
      _filterList.remove(value);
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
