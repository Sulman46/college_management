class TeacherWorkloadModel {
  final String? id;
  final String? teacherName;
  final String? status;
  final String? designation;
  final String? teacherType;
  final int? targetWorkload;
  final List<TeacherDepartmentModel> departments;

  TeacherWorkloadModel({
    this.id,
    this.teacherName,
    this.status,
    this.designation,
    this.teacherType,
    this.targetWorkload,
    this.departments = const [],
  });

  factory TeacherWorkloadModel.fromMap(Map<String, dynamic> map) {
    // API sends "department" as a List of objects: [{_id, name}, ...]
    final rawDept = map['department'];
    final departments = rawDept is List
        ? rawDept
        .map((e) => TeacherDepartmentModel.fromMap(e as Map<String, dynamic>))
        .toList()
        : <TeacherDepartmentModel>[];

    return TeacherWorkloadModel(
      id:             map['_id']?.toString(),
      teacherName:    map['teacherName']?.toString(),
      status:         map['status']?.toString(),
      designation:    map['designation']?.toString(),
      teacherType:    map['teacherType']?.toString(),
      targetWorkload: map['targetWorkload'] != null
          ? int.tryParse('${map['targetWorkload']}')
          : null,
      departments: departments,
    );
  }
}

class TeacherDepartmentModel {
  final String? id;
  final String? name;

  TeacherDepartmentModel({this.id, this.name});

  factory TeacherDepartmentModel.fromMap(Map<String, dynamic> map) {
    return TeacherDepartmentModel(
      id:   map['_id']?.toString(),
      name: map['name']?.toString(),
    );
  }
}