class TeacherAllocationModel {
  final String? id;
  final String? affiliation;
  final String? department;
  final String? programName;
  final List<String>? combinedPrograms;
  final String? degree;
  final String? batch;
  final String? section;
  final String? semester;
  final String? courseName;
  final String? courseCode;
  final String? creditHours;
  final String? teacherName;
  final bool? isCombinedClass;
  final String? allocationType;
  final double? rate;
  final String? status;

  TeacherAllocationModel({
    this.id,
    this.affiliation,
    this.department,
    this.programName,
    this.combinedPrograms,
    this.degree,
    this.batch,
    this.section,
    this.semester,
    this.courseName,
    this.courseCode,
    this.creditHours,
    this.teacherName,
    this.isCombinedClass,
    this.allocationType,
    this.rate,
    this.status,
  });

  factory TeacherAllocationModel.fromMap(Map<String, dynamic> map) {
    return TeacherAllocationModel(
      id: map['_id'] ?? "",
      affiliation: map['affiliation'] ?? "",
      department: map['department'] ?? "",
      programName: map['programName'] ?? "",

      combinedPrograms: map['combinedPrograms'] == null
          ? []
          : List<String>.from(
        map['combinedPrograms'].map((e) => e.toString()),
      ),

      degree: map['degree'] ?? "",
      batch: map['batch'] ?? "",
      section: map['section'] ?? "",
      semester: map['semester'] ?? "",
      courseName: map['courseName'] ?? "",
      courseCode: map['courseCode'] ?? "",
      creditHours: map['creditHours'] ?? "",
      teacherName: map['teacherName'] ?? "",

      isCombinedClass: map['isCombinedClass'] ?? false,

      allocationType: map['allocationType'] ?? "Workload",

      rate: map['rate'] != null
          ? double.tryParse("${map['rate']}") ?? 0
          : 0,

      status: map['status'] ?? "Active",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if(id!=null)
      '_id': id,
      'affiliation': affiliation,
      'department': department,
      'programName': programName,
      'combinedPrograms': combinedPrograms,
      'degree': degree,
      'batch': batch,
      'section': section,
      'semester': semester,
      'courseName': courseName,
      'courseCode': courseCode,
      'creditHours': creditHours,
      'teacherName': teacherName,
      'isCombinedClass': isCombinedClass,
      'allocationType': allocationType,
      'rate': rate,
      'status': status,
    };
  }

  TeacherAllocationModel copyWith({
    String? id,
    String? affiliation,
    String? department,
    String? programName,
    List<String>? combinedPrograms,
    String? degree,
    String? batch,
    String? section,
    String? semester,
    String? courseName,
    String? courseCode,
    String? creditHours,
    String? teacherName,
    bool? isCombinedClass,
    String? allocationType,
    double? rate,
    String? status,
  }) {
    return TeacherAllocationModel(
      id: id ?? this.id,
      affiliation: affiliation ?? this.affiliation,
      department: department ?? this.department,
      programName: programName ?? this.programName,
      combinedPrograms: combinedPrograms ?? this.combinedPrograms,
      degree: degree ?? this.degree,
      batch: batch ?? this.batch,
      section: section ?? this.section,
      semester: semester ?? this.semester,
      courseName: courseName ?? this.courseName,
      courseCode: courseCode ?? this.courseCode,
      creditHours: creditHours ?? this.creditHours,
      teacherName: teacherName ?? this.teacherName,
      isCombinedClass: isCombinedClass ?? this.isCombinedClass,
      allocationType: allocationType ?? this.allocationType,
      rate: rate ?? this.rate,
      status: status ?? this.status,
    );
  }
}