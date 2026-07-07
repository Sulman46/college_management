
import '../../timetable_manager/models/time_table_manger_model.dart';

class TeacherAttendanceTimeTableModel {

  TimeTableCellModel tableCellModel;
  String slotIndex;
  String slotTime;
  String minutes;
  String status;
  TeacherAttendanceTimeTableModel({required this.tableCellModel,required this.slotTime,required this.minutes,required this.status,required this.slotIndex});


  TeacherAttendanceTimeTableModel copyWith({
    TimeTableCellModel? tableCellModel,
    String? slotIndex,
    String? slotTime,
    String? minutes,
    String? status,
  }) {
    return TeacherAttendanceTimeTableModel(
      tableCellModel: tableCellModel ?? this.tableCellModel,
      slotIndex: slotIndex ?? this.slotIndex,
      slotTime: slotTime ?? this.slotTime,
      minutes: minutes ?? this.minutes,
      status: status ?? this.status,
    );
  }

}