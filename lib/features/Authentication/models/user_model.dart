import 'dart:developer';

import '../../../core/enums/user_enums.dart';

class UserModel {
  final String id;
  final UserRole role;
  final String name;
  final String email;
  final String profileImg;
  final List<String> department;


  final String teacherType;
  final String teacherId;
  final String teacherFullName;


  final String studentObjectId;
  final String programName;
  final String studentDepartment;
  final String srNo;
  final String rollNo;
  final String section;
  final String session;

  UserModel({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.profileImg,
    required this.department,

    required this.teacherType,
    required this.teacherId,
    required this.teacherFullName,


    required this.studentObjectId,
    required this.rollNo,
    required this.section,
    required this.session,
    required this.programName,
    required this.srNo,
    required this.studentDepartment,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    bool isDptList=json['department'] is List;
    return UserModel(
      id: json['id'] ?? '',

      role: json['role']!=null? json['role'] =="Admin"?UserRole.admin:json['role']=="Teacher"?UserRole.teacher:json['role']=="Coordinator"?UserRole.coordinator:json['role']=="HOD"?UserRole.hod:json['role']=="Student"?UserRole.student:UserRole.student:UserRole.student,

      name: json['name'] ?? '',

      email: json['email'] ?? '',

      profileImg: json['profileImg'] ?? '',

      department:isDptList? List<String>.from(
        json['department'] ?? [],
      ):["${json['department']??""}"],


      teacherType: json['teacherType'] ?? '',
      teacherId: json['teacherId'] ?? '',
      teacherFullName: json['teacherFullName'] ?? '',
        srNo: json['srNo'] ?? '',
        studentObjectId: json['studentObjectId'] ?? '',
        rollNo: json['rollNo'] ?? '',
        programName: json['programName'] ?? '',
        session: json['session'] ?? '',
        section: json['section'] ?? '',
        studentDepartment:isDptList?"": json['department'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "role": role.toJson(),
      "name": name,
      "email": email,
      "profileImg": profileImg,
      "department": department.toList(),
    };
  }
}