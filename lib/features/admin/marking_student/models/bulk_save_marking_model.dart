class BulkSaveMarkingModel {
  final String? studentId;
  final String? semesterId;
  final String? srNo;
  final String? rollNo;
  final String? studentName;
  final String? courseMappingId;
  final String? semesterName;
  final String? department;
  final String? program;
  final String? session;
  final String? section;

  final int? mids;
  final int? sessional;
  final int? finalMarks;   // mapped to "final"
  final int? practical;

  final int? totalMarks;
  final int? grandMax;

  final String? grade;
  final double? gpa;

  final String? gradeOverride;
  final double? gpaOverride;

  final bool? passed;
  final bool? isLocked;

  BulkSaveMarkingModel({
    this.studentId,
    this.semesterId,
    this.srNo,
    this.rollNo,
    this.studentName,
    this.courseMappingId,
    this.semesterName,
    this.department,
    this.program,
    this.session,
    this.section,
    this.mids,
    this.sessional,
    this.finalMarks,
    this.practical,
    this.totalMarks,
    this.grandMax,
    this.grade,
    this.gpa,
    this.gradeOverride,
    this.gpaOverride,
    this.passed,
    this.isLocked,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'semesterId': semesterId,
      'srNo': srNo,
      'rollNo': rollNo,
      'studentName': studentName,
      'courseMappingId': courseMappingId,
      'semesterName': semesterName,
      'department': department,
      'program': program,
      'session': session,
      'section': section,

      'mids': mids,
      'sessional': sessional,
      'final': finalMarks,
      'practical': practical,

      'totalMarks': totalMarks,
      'grandMax': grandMax,

      'grade': grade,
      'gpa': gpa,

      'gradeOverride': gradeOverride,
      'gpaOverride': gpaOverride,

      'passed': passed,
      'isLocked': isLocked,
    };
  }
}


class BulkSaveMarksRequest {
  final List<BulkSaveMarkingModel> marks;
  final String courseType;

  BulkSaveMarksRequest({
    required this.marks,
    required this.courseType,
  });

  Map<String, dynamic> toMap() {
    return {
      'marks': marks.map((e) => e.toMap()).toList(),
      'courseType': courseType,
    };
  }


  Map<String, dynamic> lockMap(){
    return {
      "courseMappingId":marks.first.courseMappingId??"",
      "isLocked":marks.first.isLocked??false,
      "semesterId":marks.first.semesterId??"",
    };
  }
}