class CourseMappingModel {
  final String? id;
  final String? department;
  final String? program;
  final String? degree;
  final String? affiliation;
  final String? session;
  final String? section;
  final String? semesterId;
  final String? semesterName;
  final String? courseId;
  final String? courseTitle;
  final String? courseCode;
  final String? courseCategory;
  final String? courseType;
  final double? creditHours;
  final String? status;

  CourseMappingModel({
    this.id,
    this.department,
    this.program,
    this.degree,
    this.affiliation,
    this.session,
    this.section,
    this.semesterId,
    this.semesterName,
    this.courseId,
    this.courseTitle,
    this.courseCode,
    this.courseCategory,
    this.courseType,
    this.creditHours,
    this.status,
  });

  factory CourseMappingModel.fromMap(Map<String, dynamic> map) {
    return CourseMappingModel(
      id: map['_id'] ?? "",
      department: map['department'] ?? "",
      program: map['program'] ?? "",
      degree: map['degree'] ?? "",
      affiliation: map['affiliation'] ?? "",
      session: map['session'] ?? "",
      section: map['section'] ?? "",
      semesterId: map['semesterId'] ?? "",
      semesterName: map['semesterName'] ?? "",
      courseId: map['courseId'] ?? "",
      courseTitle: map['courseTitle'] ?? "",
      courseCode: map['courseCode'] ?? "",
      courseCategory: map['courseCategory'] ?? "",
      courseType: map['courseType'] ?? "",
      creditHours: map['creditHours'] != null
          ? double.tryParse("${map['creditHours']}") ?? 0
          : 0,
      status: map['status'] ?? "Active",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if(id!=null)
        '_id':id,
      'department': department,
      'program': program,
      'degree': degree,
      'affiliation': affiliation,
      'session': session,
      'section': section,
      'semesterId': semesterId,
      'semesterName': semesterName,
      'courseId': courseId,
      'courseTitle': courseTitle,
      'courseCode': courseCode,
      'courseCategory': courseCategory,
      'courseType': courseType,
      'creditHours': creditHours,
      'status': status,
    };
  }

  CourseMappingModel copyWith({
    String? id,
    String? department,
    String? program,
    String? degree,
    String? affiliation,
    String? session,
    String? section,
    String? semesterId,
    String? semesterName,
    String? courseId,
    String? courseTitle,
    String? courseCode,
    String? courseCategory,
    String? courseType,
    double? creditHours,
    String? status,
  }) {
    return CourseMappingModel(
      id: id ?? this.id,
      department: department ?? this.department,
      program: program ?? this.program,
      degree: degree ?? this.degree,
      affiliation: affiliation ?? this.affiliation,
      session: session ?? this.session,
      section: section ?? this.section,
      semesterId: semesterId ?? this.semesterId,
      semesterName: semesterName ?? this.semesterName,
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      courseCode: courseCode ?? this.courseCode,
      courseCategory: courseCategory ?? this.courseCategory,
      courseType: courseType ?? this.courseType,
      creditHours: creditHours ?? this.creditHours,
      status: status ?? this.status,
    );
  }
}