
class MarksResponseModel{
  List<MarksStudentModel> dataList;
  bool isLocked;
  MarksResponseModel({required this.dataList,required this.isLocked});

  factory MarksResponseModel.fromMap(Map<String, dynamic> map) {
    var studentData= map['students'];
    return MarksResponseModel(
      isLocked: map['isLocked']??false,
      dataList:studentData != null
          ? studentData is List? studentData.map((e)=>MarksStudentModel.fromMap(e)).toList():[]
          : [],
    );
  }

  MarksResponseModel copyWith({
    List<MarksStudentModel>? dataList,
    bool? isLocked,
  }) {
    return MarksResponseModel(
      dataList: dataList ?? this.dataList,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}

class MarksStudentModel {
  final String? enrollmentId;
  final String? studentId;
  final String? srNo;
  final String? rollNo;
  final String? name;
  final String? status;
  final MarksModel? marks;

  MarksStudentModel({
    this.enrollmentId,
    this.studentId,
    this.srNo,
    this.rollNo,
    this.name,
    this.status,
    this.marks,
  });

  factory MarksStudentModel.fromMap(Map<String, dynamic> map) {
    return MarksStudentModel(
      enrollmentId: map['enrollmentId'],
      studentId: map['studentId'],
      srNo: map['srNo'],
      rollNo: map['rollNo'],
      name: map['name'],
      status: map['status'],
      marks: map['marks'] != null
          ? MarksModel.fromMap(map['marks'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enrollmentId': enrollmentId,
      'studentId': studentId,
      'srNo': srNo,
      'rollNo': rollNo,
      'name': name,
      'status': status,
      'marks': marks?.toMap(),
    };
  }

  MarksStudentModel copyWith({
    String? enrollmentId,
    String? studentId,
    String? srNo,
    String? rollNo,
    String? name,
    String? status,
    MarksModel? marks,
    bool updateMarks = false,
  }) {
    return MarksStudentModel(
      enrollmentId: enrollmentId ?? this.enrollmentId,
      studentId: studentId ?? this.studentId,
      srNo: srNo ?? this.srNo,
      rollNo: rollNo ?? this.rollNo,
      name: name ?? this.name,
      status: status ?? this.status,
      marks: updateMarks ? marks : (marks ?? this.marks),
    );
  }


}


class MarksModel {
  final String? id;
  final String? courseMappingId;
  final String? semesterId;
  final String? studentId;
  final int? finalMarks;
  final double? gpa;
  final double? percentage;
  final String? grade;
  final int? grandMax;
  final bool? isLocked;
  final int? mids;
  final int? practical;
  final bool? passed;
  final int? sessional;
  final int? totalMarks;

  MarksModel({
    this.id,
    this.courseMappingId,
    this.semesterId,
    this.studentId,
    this.finalMarks,
    this.gpa,
    this.percentage,
    this.grade,
    this.grandMax,
    this.isLocked,
    this.mids,
    this.passed,
    this.practical,
    this.sessional,
    this.totalMarks,
  });

  factory MarksModel.fromMap(Map<String, dynamic> map) {
    return MarksModel(
      id: map['_id'],
      courseMappingId: map['courseMappingId'],
      semesterId: map['semesterId'],
      studentId: map['studentId'],
      finalMarks: map['final'],
      gpa: (map['gpa'] as num?)?.toDouble(),
      percentage: (map['percentage'] as num?)?.toDouble(),
      grade: map['grade'],
      grandMax: map['grandMax'],
      isLocked: map['isLocked'],
      mids: map['mids'],
      passed: map['passed'],
      sessional: map['sessional'],
      totalMarks: map['totalMarks'],
      practical: map['practical'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (courseMappingId != null) 'courseMappingId': courseMappingId,
      if (semesterId != null) 'semesterId': semesterId,
      if (studentId != null) 'studentId': studentId,
      if (finalMarks != null) 'final': finalMarks,
      if (gpa != null) 'gpa': gpa,
      if (percentage != null) 'percentage': percentage,
      if (grade != null) 'grade': grade,
      if (grandMax != null) 'grandMax': grandMax,
      if (isLocked != null) 'isLocked': isLocked,
      if (mids != null) 'mids': mids,
      if (passed != null) 'passed': passed,
      if (sessional != null) 'sessional': sessional,
      if (totalMarks != null) 'totalMarks': totalMarks,
      if (practical != null) 'practical': practical,
    };
  }

  MarksModel copyWith({
    String? id,
    String? courseMappingId,
    String? semesterId,
    String? studentId,
    int? finalMarks,
    double? gpa,
    double? percentage,
    String? grade,
    int? grandMax,
    bool? isLocked,
    int? mids,
    int? practical,
    bool? passed,
    int? sessional,
    int? totalMarks,
  }) {
    return MarksModel(
      id: id ?? this.id,
      courseMappingId: courseMappingId ?? this.courseMappingId,
      semesterId: semesterId ?? this.semesterId,
      studentId: studentId ?? this.studentId,
      finalMarks: finalMarks ?? this.finalMarks,
      gpa: gpa ?? this.gpa,
      percentage: percentage ?? this.percentage,
      grade: grade ?? this.grade,
      grandMax: grandMax ?? this.grandMax,
      isLocked: isLocked ?? this.isLocked,
      mids: mids ?? this.mids,
      practical: practical ?? this.practical,
      passed: passed ?? this.passed,
      sessional: sessional ?? this.sessional,
      totalMarks: totalMarks ?? this.totalMarks,
    );
  }
}

