
class HodAssignModel {
  final String? id;
  final HodTeacherModel? teacher;
  final HodDepartmentModel? department;
  final DateTime? assignedDate;
  final String? status;

  HodAssignModel({
    this.id,
    this.teacher,
    this.department,
    this.assignedDate,
    this.status,
  });

  factory HodAssignModel.fromMap(Map<String, dynamic> map) {
    return HodAssignModel(
      id: map['_id'] ?? map['id'] ?? "",
      teacher: HodTeacherModel.fromMap(map['teacherId'] ?? ""),
      department: HodDepartmentModel.fromMap(map['departmentId'] ?? ""),
      assignedDate: map['assignedDate'] != null
          ? DateTime.tryParse(map['assignedDate'].toString())
          : null,
      status: map['status'] ?? "Active",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null && id!.isNotEmpty) '_id': id,
      if (teacher != null)
        'teacherId': teacher?.id,
      if (department != null)
        'departmentId': department?.id,
      if (assignedDate != null)
        'assignedDate': assignedDate!.toIso8601String(),
      if (status != null && status!.isNotEmpty)
        'status': status,
    };
  }

  HodAssignModel copyWith({
    String? id,
    HodTeacherModel? teacher,
    HodDepartmentModel? department,
    DateTime? assignedDate,
    String? status,
  }) {
    return HodAssignModel(
      id: id ?? this.id,
      teacher: teacher ?? this.teacher,
      department: department ?? this.department,
      assignedDate: assignedDate ?? this.assignedDate,
      status: status ?? this.status,
    );
  }
}

class HodTeacherModel{
  final String? id;
  final String? teacherName;
  final String? userName;
  final bool? isAccountGenerated;
  final String? email;
  final String? phone;
  final String? status;
  HodTeacherModel({this.teacherName,this.id,this.userName,this.isAccountGenerated,this.status,this.phone,this.email});


  factory HodTeacherModel.fromMap(Map<String, dynamic> map) {
   return HodTeacherModel(
     id: map['_id'] ?? map['id'] ?? "",
     teacherName: map['teacherName'] ?? "",
     email:map['email'] ?? "",
     isAccountGenerated:map['isAccountGenerated'] ?? false,
     userName:map['userName'] ?? "",
     phone: map['phone'] ?? "",
     status: map['status'] ?? "Active",

   );
  }

}



class HodDepartmentModel {
  String? id;
  String? name;
  String? code;
  DepartmentStatus? status;
  DateTime? date;

  HodDepartmentModel({
     this.id,
     this.name,
     this.code,
     this.status,
     this.date,
  });

  factory HodDepartmentModel.fromMap(
      Map<String, dynamic> map) {
    return HodDepartmentModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      status: map['status']!=null?map['status']=="Active" ? DepartmentStatus.Active:DepartmentStatus.Inactive:DepartmentStatus.Inactive,
      date: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'code': code,
      'status': status?.name??"Active",
      'createdAt': date?.toIso8601String(),
    };
  }
}

enum DepartmentStatus{
  Active,Inactive,
}