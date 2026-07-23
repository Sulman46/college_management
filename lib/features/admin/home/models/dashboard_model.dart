import 'dart:convert';

class DashboardModel {
  final String totalTeacherLength;
  final String totalStudent;
  final String totalDepartment;
  final String totalLeaveRequest;
  final String pendingLeaveRequest;

  DashboardModel({
    required this.totalTeacherLength,
    required this.totalStudent,
    required this.totalDepartment,
    required this.totalLeaveRequest,
    required this.pendingLeaveRequest,
  });

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      totalTeacherLength: "${map['totalTeacherLength'] ?? 0}",
      totalStudent:"${ map['totalStudent'] ?? 0}",
      totalDepartment: "${map['totalDepartment'] ?? 0}",
      totalLeaveRequest: "${map['totalLeaveRequest'] ?? 0}",
      pendingLeaveRequest: "${map['pendingLeaveRequest'] ?? 0}",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalTeacherLength': totalTeacherLength,
      'totalStudent': totalStudent,
      'totalDepartment': totalDepartment,
      'totalLeaveRequest': totalLeaveRequest,
      'pendingLeaveRequest': pendingLeaveRequest,
    };
  }

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}