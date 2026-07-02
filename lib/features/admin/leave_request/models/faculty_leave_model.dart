class FacultyLeaveModel {
  final String? id;
  final FacultyTeacherModel? teacher;
  final List<FacultyDepartmentModel>? departments;
  final String? leaveType;
  final String? startDate;
  final String? endDate;
  final String? reason;
  final String? status;
  final String? appliedAt;

  FacultyLeaveModel({
    this.id,
    this.teacher,
    this.departments,
    this.leaveType,
    this.startDate,
    this.endDate,
    this.reason,
    this.status,
    this.appliedAt,
  });

  int get countDays {
    if (startDate == null || endDate == null) return 0;

    try {
      final start = DateTime.parse(startDate!);
      final end = DateTime.parse(endDate!);

      return end.difference(start).inDays + 1;
    } catch (_) {
      return 0;
    }
  }

  factory FacultyLeaveModel.fromMap(Map<String, dynamic> map) {
    return FacultyLeaveModel(
      id: map['_id'],
      teacher: map['teacherId'] != null
          ? FacultyTeacherModel.fromMap(map['teacherId'])
          : null,
      departments: (map['departments'] as List<dynamic>?)
          ?.map((e) => FacultyDepartmentModel.fromMap(e))
          .toList(),
      leaveType: map['leaveType'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      reason: map['reason'],
      status: map['status'],
      appliedAt: map['appliedAt'],
    );
  }

  Map<String,dynamic>  toMap(){
    return {
      if(id!=null)
        "_id":id,
      "status": status,
      "endDate":endDate,
      "startDate":startDate,
      "reason":reason,
      "teacherId":teacher?.id??"",
    };
  }


  FacultyLeaveModel copyWith({
    String? id,
    FacultyTeacherModel? teacher,
    List<FacultyDepartmentModel>? departments,
    String? leaveType,
    String? startDate,
    String? endDate,
    String? reason,
    String? status,
    String? appliedAt,
  }) {
    return FacultyLeaveModel(
      id: id ?? this.id,
      teacher: teacher ?? this.teacher,
      departments: departments ?? this.departments,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      appliedAt: appliedAt ?? this.appliedAt,
    );
  }
}

class FacultyTeacherModel {
  final String? id;
  final String? name;
  final String? email;

  FacultyTeacherModel({
    this.id,
    this.name,
    this.email,
  });

  factory FacultyTeacherModel.fromMap(Map<String, dynamic> map) {
    return FacultyTeacherModel(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
    );
  }

  FacultyTeacherModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return FacultyTeacherModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}

class FacultyDepartmentModel {
  final String? id;
  final String? name;
  final String? code;

  FacultyDepartmentModel({
    this.id,
    this.name,
    this.code,
  });

  factory FacultyDepartmentModel.fromMap(Map<String, dynamic> map) {
    return FacultyDepartmentModel(
      id: map['_id'],
      name: map['name'],
      code: map['code'],
    );
  }

  FacultyDepartmentModel copyWith({
    String? id,
    String? name,
    String? code,
  }) {
    return FacultyDepartmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}