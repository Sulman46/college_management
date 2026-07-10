import 'package:college_management/core/helper/app_date_picker.dart';

class TeacherSendLeaveRequestModel {
  final String leaveType;
  final String teacherId;
  final List<String> departments;
  final String reason;
  final DateTime startDate;
  final DateTime endDate;

  TeacherSendLeaveRequestModel({
    required this.leaveType,
    required this.teacherId,
    required this.departments,
    required this.reason,
    required this.startDate,
    required this.endDate,
  });

  TeacherSendLeaveRequestModel copyWith({
    String? leaveType,
    String? teacherId,
    List<String>? departments,
    String? reason,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TeacherSendLeaveRequestModel(
      leaveType: leaveType ?? this.leaveType,
      teacherId: teacherId ?? this.teacherId,
      departments: departments ?? this.departments,
      reason: reason ?? this.reason,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'leaveType': leaveType,
      'teacherId': teacherId,
      'departments': departments,
      'reason': reason,
      'startDate':  formatDate(startDate),
      'endDate': formatDate(endDate),
    };
  }

  factory TeacherSendLeaveRequestModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return TeacherSendLeaveRequestModel(
      leaveType: map['leaveType'] ?? '',
      teacherId: map['teacherId'] ?? '',
      departments: List<String>.from(map['departments'] ?? []),
      reason: map['reason'] ?? '',
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }
}