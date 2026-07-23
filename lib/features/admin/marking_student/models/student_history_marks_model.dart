class StudentHistoryMarksModel {
  final String? id;
  final SemesterHistoryModel? semester;
  final CourseMappingHistoryModel? courseMapping;
  final StudentHistoryModel? student;

  final int? finalMarks;
  final double? gpa;
  final String? grade;
  final int? grandMax;
  final bool? isLocked;
  final int? mids;
  final bool? passed;
  final int? sessional;
  final int? totalMarks;

  final String? semesterName;
  final String? department;
  final String? program;
  final String? section;
  final String? session;
  final String? affiliation;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic gpaOverride;

  StudentHistoryMarksModel({
    this.id,
    this.semester,
    this.courseMapping,
    this.student,
    this.finalMarks,
    this.gpa,
    this.grade,
    this.grandMax,
    this.isLocked,
    this.mids,
    this.passed,
    this.sessional,
    this.totalMarks,
    this.semesterName,
    this.department,
    this.program,
    this.section,
    this.session,
    this.affiliation,
    this.createdAt,
    this.updatedAt,
    this.gpaOverride,
  });

  factory StudentHistoryMarksModel.fromMap(Map<String, dynamic> map) {
    return StudentHistoryMarksModel(
      id: map['_id'],
      semester: map['semesterId'] != null
          ? SemesterHistoryModel.fromMap(map['semesterId'])
          : null,
      courseMapping: map['courseMappingId'] != null
          ? CourseMappingHistoryModel.fromMap(map['courseMappingId'])
          : null,
      student: map['studentId'] != null
          ? StudentHistoryModel.fromMap(map['studentId'])
          : null,
      finalMarks: map['final'],
      gpa: map['gpa']?.toDouble(),
      grade: map['grade'],
      grandMax: map['grandMax'],
      isLocked: map['isLocked'],
      mids: map['mids'],
      passed: map['passed'],
      sessional: map['sessional'],
      totalMarks: map['totalMarks'],
      semesterName: map['semesterName'],
      department: map['department'],
      program: map['program'],
      section: map['section'],
      session: map['session'],
      affiliation: map['affiliation'],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'])
          : null,
      gpaOverride: map['gpaOverride'],
    );
  }

  Map<String, dynamic> toMap() => {
    '_id': id,
    'semesterId': semester?.toMap(),
    'courseMappingId': courseMapping?.toMap(),
    'studentId': student?.toMap(),
    'final': finalMarks,
    'gpa': gpa,
    'grade': grade,
    'grandMax': grandMax,
    'isLocked': isLocked,
    'mids': mids,
    'passed': passed,
    'sessional': sessional,
    'totalMarks': totalMarks,
    'semesterName': semesterName,
    'department': department,
    'program': program,
    'section': section,
    'session': session,
    'affiliation': affiliation,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'gpaOverride': gpaOverride,
  };

  StudentHistoryMarksModel copyWith({
    String? id,
    SemesterHistoryModel? semester,
    CourseMappingHistoryModel? courseMapping,
    StudentHistoryModel? student,
    int? finalMarks,
    double? gpa,
    String? grade,
    int? grandMax,
    bool? isLocked,
    int? mids,
    bool? passed,
    int? sessional,
    int? totalMarks,
    String? semesterName,
    String? department,
    String? program,
    String? section,
    String? session,
    String? affiliation,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic gpaOverride,
  }) {
    return StudentHistoryMarksModel(
      id: id ?? this.id,
      semester: semester ?? this.semester,
      courseMapping: courseMapping ?? this.courseMapping,
      student: student ?? this.student,
      finalMarks: finalMarks ?? this.finalMarks,
      gpa: gpa ?? this.gpa,
      grade: grade ?? this.grade,
      grandMax: grandMax ?? this.grandMax,
      isLocked: isLocked ?? this.isLocked,
      mids: mids ?? this.mids,
      passed: passed ?? this.passed,
      sessional: sessional ?? this.sessional,
      totalMarks: totalMarks ?? this.totalMarks,
      semesterName: semesterName ?? this.semesterName,
      department: department ?? this.department,
      program: program ?? this.program,
      section: section ?? this.section,
      session: session ?? this.session,
      affiliation: affiliation ?? this.affiliation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gpaOverride: gpaOverride ?? this.gpaOverride,
    );
  }
}

class SemesterHistoryModel {
  final String? id;
  final String? semesterName;
  final ProgramHistoryModel? program;
  final String? status;

  SemesterHistoryModel({
    this.id,
    this.semesterName,
    this.program,
    this.status,
  });

  factory SemesterHistoryModel.fromMap(Map<String, dynamic> map) => SemesterHistoryModel(
    id: map['_id'],
    semesterName: map['semesterName'],
    program: map['programId'] is Map
        ? ProgramHistoryModel.fromMap(map['programId'])
        : null,
    status: map['status'],
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'semesterName': semesterName,
    'programId': program?.toMap(),
    'status': status,
  };
}

class ProgramHistoryModel {
  final String? id;
  final String? name;
  final DepartmentHistoryModel? department;
  final String? affiliationName;
  final String? degree;
  final String? session;
  final String? section;

  ProgramHistoryModel({
    this.id,
    this.name,
    this.department,
    this.affiliationName,
    this.degree,
    this.session,
    this.section,
  });

  factory ProgramHistoryModel.fromMap(Map<String, dynamic> map) => ProgramHistoryModel(
    id: map['_id'],
    name: map['name'],
    department: map['department'] != null
        ? DepartmentHistoryModel.fromMap(map['department'])
        : null,
    affiliationName: map['affiliationName'],
    degree: map['degree'],
    session: map['session'],
    section: map['section'],
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'name': name,
    'department': department?.toMap(),
    'affiliationName': affiliationName,
    'degree': degree,
    'session': session,
    'section': section,
  };
}

class DepartmentHistoryModel {
  final String? id;
  final String? name;

  DepartmentHistoryModel({this.id, this.name});

  factory DepartmentHistoryModel.fromMap(Map<String, dynamic> map) =>
      DepartmentHistoryModel(
        id: map['_id'],
        name: map['name'],
      );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'name': name,
  };
}

class CourseMappingHistoryModel {
  final String? id;
  final CourseHistoryModel? course;

  CourseMappingHistoryModel({this.id, this.course});

  factory CourseMappingHistoryModel.fromMap(Map<String, dynamic> map) =>
      CourseMappingHistoryModel(
        id: map['_id'],
        course: map['courseId'] != null
            ? CourseHistoryModel.fromMap(map['courseId'])
            : null,
      );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'courseId': course?.toMap(),
  };
}

class CourseHistoryModel {
  final String? id;
  final String? courseCode;
  final String? courseTitle;
  final int? creditHours;
  final String? type;

  CourseHistoryModel({
    this.id,
    this.courseCode,
    this.courseTitle,
    this.creditHours,
    this.type,
  });

  factory CourseHistoryModel.fromMap(Map<String, dynamic> map) => CourseHistoryModel(
    id: map['_id'],
    courseCode: map['courseCode'],
    courseTitle: map['courseTitle'],
    creditHours: map['creditHours'],
    type: map['type'],
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'courseCode': courseCode,
    'courseTitle': courseTitle,
    'creditHours': creditHours,
    'type': type,
  };
}

class StudentHistoryModel {
  final String? id;
  final String? registrationNumber;
  final String? rollNo;
  final String? name;

  StudentHistoryModel({
    this.id,
    this.registrationNumber,
    this.rollNo,
    this.name,
  });

  factory StudentHistoryModel.fromMap(Map<String, dynamic> map) => StudentHistoryModel(
    id: map['_id'],
    registrationNumber: map['registrationNumber'],
    rollNo: map['rollNo'],
    name: map['name'],
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'registrationNumber': registrationNumber,
    'rollNo': rollNo,
    'name': name,
  };
}