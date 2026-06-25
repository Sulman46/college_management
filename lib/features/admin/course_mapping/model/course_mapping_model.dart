class CourseMappingModel {
  final String? id;
  final String? courseMappingId;

  final String? departmentId;
  final String? departmentName;

  final String? programId;
  final String? programName;

  final String? affiliationId;
  final String? affiliationName;

  final String? degree;
  final String? session;
  final String? section;

  final String? semesterId;
  final String? semesterName;

  final String? courseId;
  final String? courseTitle;
  final String? courseName;
  final String? courseCode;

  final String? courseCategory;
  final String? courseType;

  final double? creditHours;

  final String? status;
  final String? createdAt;

  CourseMappingModel({
    this.id,
    this.courseMappingId,
    this.departmentId,
    this.departmentName,
    this.programId,
    this.programName,
    this.affiliationId,
    this.affiliationName,
    this.degree,
    this.session,
    this.section,
    this.semesterId,
    this.semesterName,
    this.courseId,
    this.courseTitle,
    this.courseName,
    this.courseCode,
    this.courseCategory,
    this.courseType,
    this.creditHours,
    this.status,
    this.createdAt,
  });

  factory CourseMappingModel.fromMap(Map<String, dynamic> map) {
    return CourseMappingModel(
      id: map['_id']?.toString(),
      courseMappingId: map['courseMappingId']?.toString(),

      departmentId: map['departmentId']?.toString(),
      departmentName: map['departmentName']?.toString(),

      programId: map['programId']??"",
      programName: map['programName']?.toString(),

      affiliationId: map['affiliationId']?.toString(),
      affiliationName: map['affiliationName']?.toString(),
      degree: map['degree']?.toString(),
      session: map['session']?.toString(),
      section: map['section']?.toString(),

      semesterId: map['semesterId']?.toString(),
      semesterName: map['semesterName']?.toString(),

      courseId: map['courseId']?.toString(),
      courseTitle: map['courseTitle']?.toString(),
      courseName: map['courseName']?.toString(),
      courseCode: map['courseCode']?.toString(),

      courseCategory: map['courseCategory']?.toString(),
      courseType: map['courseType']?.toString(),

      creditHours: (map['creditHours'] as num?)?.toDouble() ?? 0.0,

      status: map['status']?.toString(),
      createdAt: map['createdAt']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'semesterId': semesterId,
      'courseId': courseId,
      'status': status,
      'createdAt': createdAt,
    };
  }

  CourseMappingModel copyWith({
    String? id,
    String? courseMappingId,
    String? departmentId,
    String? departmentName,
    String? programId,
    String? programName,
    String? affiliationId,
    String? affiliationName,
    String? degree,
    String? session,
    String? section,
    String? semesterId,
    String? semesterName,
    String? courseId,
    String? courseTitle,
    String? courseName,
    String? courseCode,
    String? courseCategory,
    String? courseType,
    double? creditHours,
    String? status,
    String? createdAt,
  }) {
    return CourseMappingModel(
      id: id ?? this.id,
      courseMappingId: courseMappingId ?? this.courseMappingId,

      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,

      programId: programId ?? this.programId,
      programName: programName ?? this.programName,

      affiliationId: affiliationId ?? this.affiliationId,
      affiliationName: affiliationName ?? this.affiliationName,

      degree: degree ?? this.degree,
      session: session ?? this.session,
      section: section ?? this.section,

      semesterId: semesterId ?? this.semesterId,
      semesterName: semesterName ?? this.semesterName,

      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      courseName: courseName ?? this.courseName,
      courseCode: courseCode ?? this.courseCode,

      courseCategory: courseCategory ?? this.courseCategory,
      courseType: courseType ?? this.courseType,

      creditHours: creditHours ?? this.creditHours,

      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}