class UserResultModel {
  final String? studentId;
  final String? srNo;
  final String? rollNo;
  final String? studentName;
  final String? status;
  final List<ResultCourseModel> courses;
  final double? totalGpaPoints;
  final int? totalCredits;
  final int? courseCount;
  final double? cgpa;

  const UserResultModel({
    this.studentId,
    this.srNo,
    this.rollNo,
    this.studentName,
    this.status,
    this.courses = const [],
    this.totalGpaPoints,
    this.totalCredits,
    this.courseCount,
    this.cgpa,
  });

  factory UserResultModel.fromMap(Map<String, dynamic> map) {
    return UserResultModel(
      studentId: map['studentId']?.toString(),
      srNo: map['srNo']?.toString(),
      rollNo: map['rollNo']?.toString(),
      studentName: map['studentName']?.toString(),
      status: map['status']?.toString(),
      courses: map['courses'] != null
          ? List<ResultCourseModel>.from(
        (map['courses'] as List)
            .map((e) => ResultCourseModel.fromMap(e)),
      )
          : [],
      totalGpaPoints: (map['totalGpaPoints'] as num?)?.toDouble(),
      totalCredits: map['totalCredits'],
      courseCount: map['courseCount'],
      cgpa: (map['cgpa'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (studentId != null) 'studentId': studentId,
      if (srNo != null) 'srNo': srNo,
      if (rollNo != null) 'rollNo': rollNo,
      if (studentName != null) 'studentName': studentName,
      if (status != null) 'status': status,
      'courses': courses.map((e) => e.toMap()).toList(),
      if (totalGpaPoints != null) 'totalGpaPoints': totalGpaPoints,
      if (totalCredits != null) 'totalCredits': totalCredits,
      if (courseCount != null) 'courseCount': courseCount,
      if (cgpa != null) 'cgpa': cgpa,
    };
  }

  UserResultModel copyWith({
    String? studentId,
    String? srNo,
    String? rollNo,
    String? studentName,
    String? status,
    List<ResultCourseModel>? courses,
    double? totalGpaPoints,
    int? totalCredits,
    int? courseCount,
    double? cgpa,
  }) {
    return UserResultModel(
      studentId: studentId ?? this.studentId,
      srNo: srNo ?? this.srNo,
      rollNo: rollNo ?? this.rollNo,
      studentName: studentName ?? this.studentName,
      status: status ?? this.status,
      courses: courses ?? this.courses,
      totalGpaPoints: totalGpaPoints ?? this.totalGpaPoints,
      totalCredits: totalCredits ?? this.totalCredits,
      courseCount: courseCount ?? this.courseCount,
      cgpa: cgpa ?? this.cgpa,
    );
  }
}

class ResultCourseModel {
  final String? courseCode;
  final String? courseTitle;
  final int? creditHours;
  final String? type;
  final ResultMarksModel? marks;
  final int? grandMax;
  final String? grade;
  final double? gpa;
  final bool? passed;
  final bool? isLocked;

  const ResultCourseModel({
    this.courseCode,
    this.courseTitle,
    this.creditHours,
    this.type,
    this.marks,
    this.grandMax,
    this.grade,
    this.gpa,
    this.passed,
    this.isLocked,
  });

  factory ResultCourseModel.fromMap(Map<String, dynamic> map) {
    return ResultCourseModel(
      courseCode: map['courseCode']?.toString(),
      courseTitle: map['courseTitle']?.toString(),
      creditHours: map['creditHours'],
      type: map['type']?.toString(),
      marks: map['marks'] != null
          ? ResultMarksModel.fromMap(map['marks'])
          : null,
      grandMax: map['grandMax'],
      grade: map['grade']?.toString(),
      gpa: (map['gpa'] as num?)?.toDouble(),
      passed: map['passed'],
      isLocked: map['isLocked'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (courseCode != null) 'courseCode': courseCode,
      if (courseTitle != null) 'courseTitle': courseTitle,
      if (creditHours != null) 'creditHours': creditHours,
      if (type != null) 'type': type,
      if (marks != null) 'marks': marks!.toMap(),
      if (grandMax != null) 'grandMax': grandMax,
      if (grade != null) 'grade': grade,
      if (gpa != null) 'gpa': gpa,
      if (passed != null) 'passed': passed,
      if (isLocked != null) 'isLocked': isLocked,
    };
  }

  ResultCourseModel copyWith({
    String? courseCode,
    String? courseTitle,
    int? creditHours,
    String? type,
    ResultMarksModel? marks,
    int? grandMax,
    String? grade,
    double? gpa,
    bool? passed,
    bool? isLocked,
  }) {
    return ResultCourseModel(
      courseCode: courseCode ?? this.courseCode,
      courseTitle: courseTitle ?? this.courseTitle,
      creditHours: creditHours ?? this.creditHours,
      type: type ?? this.type,
      marks: marks ?? this.marks,
      grandMax: grandMax ?? this.grandMax,
      grade: grade ?? this.grade,
      gpa: gpa ?? this.gpa,
      passed: passed ?? this.passed,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}

class ResultMarksModel {
  final int? mids;
  final int? sessional;
  final int? finalMarks;
  final dynamic practical;
  final int? total;

  const ResultMarksModel({
    this.mids,
    this.sessional,
    this.finalMarks,
    this.practical,
    this.total,
  });

  factory ResultMarksModel.fromMap(Map<String, dynamic> map) {
    return ResultMarksModel(
      mids: map['mids'],
      sessional: map['sessional'],
      finalMarks: map['final'],
      practical: map['practical'],
      total: map['total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (mids != null) 'mids': mids,
      if (sessional != null) 'sessional': sessional,
      if (finalMarks != null) 'final': finalMarks,
      if (practical != null) 'practical': practical,
      if (total != null) 'total': total,
    };
  }

  ResultMarksModel copyWith({
    int? mids,
    int? sessional,
    int? finalMarks,
    dynamic practical,
    int? total,
  }) {
    return ResultMarksModel(
      mids: mids ?? this.mids,
      sessional: sessional ?? this.sessional,
      finalMarks: finalMarks ?? this.finalMarks,
      practical: practical ?? this.practical,
      total: total ?? this.total,
    );
  }
}