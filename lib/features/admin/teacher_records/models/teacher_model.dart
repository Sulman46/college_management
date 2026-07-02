import 'package:college_management/features/admin/departments/data/model/department_model.dart';

class TeacherModel {
  final String? id;
  final String? teacherName;
  final String? userName;
  final bool? isAccountGenerated;
  final String? email;
  final String? phone;
  final String? gender;
  final String? status;
  final List<DepartmentModel>? department;
  final String? designation;
  final String? qualification;
  final String? specialization;
  final String? teacherType;
  final String? joiningDate;
  final double? ratePerLecture;
  final double? targetWorkload;
  final String? allocationType;
  final String? bankName;
  final String? accountNo;

  TeacherModel({
    this.id,
    this.teacherName,
    this.userName,
    this.isAccountGenerated,
    this.email,
    this.phone,
    this.gender,
    this.status,
    this.department,
    this.designation,
    this.qualification,
    this.specialization,
    this.teacherType,
    this.joiningDate,
    this.ratePerLecture,
    this.targetWorkload,
    this.allocationType,
    this.bankName,
    this.accountNo,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      id: map['_id'] ?? "",
      teacherName: map['teacherName'] ?? "",
      isAccountGenerated: map['isAccountGenerated'] ?? false,
      userName: map['userName'] ?? "-",
      email: map['email'] ?? "",
      phone: map['phone'] ?? "",
      gender: map['gender'] ?? "Male",
      status: map['status'] ?? "Active",

      department: map['department'] == null
          ? []
          : List<DepartmentModel>.from(
        map['department'].map((e) =>  DepartmentModel.fromMap(e)),
      ),

      designation: map['designation'] ?? "",
      qualification: map['qualification'] ?? "",
      specialization: map['specialization'] ?? "",
      teacherType: map['teacherType'] ?? "Permanent",
      joiningDate: map['joiningDate'] ?? "",

      ratePerLecture: map['ratePerLecture'] != null
          ? double.tryParse("${map['ratePerLecture']}") ?? 0
          : 0,

      targetWorkload: map['targetWorkload'] != null
          ? double.tryParse("${map['targetWorkload']}") ?? 0
          : 0,

      allocationType: map['allocationType'] ?? "Per Lecture",
      bankName: map['bankName'] ?? "",
      accountNo: map['accountNo'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if(id!=null)
        "_id":id,
      'teacherName': teacherName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'status': status,
      'department': department?.map((e) => e.id,).toList()??[],
      'designation': designation,
      'qualification': qualification,
      'specialization': specialization,
      'teacherType': teacherType,
      'joiningDate': joiningDate,
      'ratePerLecture': ratePerLecture,
      'targetWorkload': targetWorkload,
      'allocationType': allocationType,
      'bankName': bankName,
      'accountNo': accountNo,
    };
  }

  TeacherModel copyWith({
    String? id,
    String? teacherName,
    String? email,
    String? phone,
    String? gender,
    String? status,
    List<DepartmentModel>? department,
    String? designation,
    String? qualification,
    String? specialization,
    String? teacherType,
    String? joiningDate,
    double? ratePerLecture,
    double? targetWorkload,
    String? allocationType,
    String? bankName,
    String? accountNo,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      teacherName: teacherName ?? this.teacherName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      qualification: qualification ?? this.qualification,
      specialization: specialization ?? this.specialization,
      teacherType: teacherType ?? this.teacherType,
      joiningDate: joiningDate ?? this.joiningDate,
      ratePerLecture: ratePerLecture ?? this.ratePerLecture,
      targetWorkload: targetWorkload ?? this.targetWorkload,
      allocationType: allocationType ?? this.allocationType,
      bankName: bankName ?? this.bankName,
      accountNo: accountNo ?? this.accountNo,
    );
  }
}