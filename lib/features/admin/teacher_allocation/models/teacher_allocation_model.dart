class TeacherAllocationModel {
  final String? id;
  final String? courseMappingId;
  final List<String>? combinedProgramsIds;
  final List<String>? combinedPrograms;
  final String? teacherId;
  final String? teacherName;
  final List<String>? teacherDepartments;
  final String? bankName;
  final String? accountNo;
  final String? phone;
  final String? email;
  final String? department;
  final String? programId;
  final String? programName;
  final String? degree;
  final String? batch;
  final String? section;
  final String? semester;
  final String? semesterId;
  final String? courseName;
  final String? courseCode;
  final String? creditHours;
  final bool? isCombinedClass;

  final String? affiliation;
  final String? status;



  const TeacherAllocationModel({
    this.id,
    this.courseMappingId,

    this.combinedProgramsIds,
    this.combinedPrograms,

    this.teacherId,
    this.teacherName,
    this.teacherDepartments,

    this.bankName,
    this.accountNo,
    this.phone,
    this.email,

    this.department,
    this.programId,
    this.programName,

    this.degree,
    this.batch,
    this.section,

    this.semester,
    this.semesterId,

    this.courseName,
    this.courseCode,
    this.creditHours,

    this.isCombinedClass,
    this.affiliation,
    this.status,
  });

  factory TeacherAllocationModel.fromMap(Map<String, dynamic> map) {
    return TeacherAllocationModel(
      id: map['_id']?.toString(),
      courseMappingId: map['courseMappingId']?.toString(),

      combinedProgramsIds: map['combinedProgramsIds'] == null
          ? []
          : List<String>.from(
        map['combinedProgramsIds'].map((e) => e.toString()),
      ),

      combinedPrograms: map['combinedPrograms'] == null
          ? []
          : [...List<String>.from(
        map['combinedPrograms'].map((e) => e.toString()),
      ),map['programName']?.toString()??""],

      teacherId: map['teacherId']?.toString(),
      teacherName: map['teacherName']?.toString(),

      teacherDepartments: map['teacherDepartments'] == null
          ? []
          : List<String>.from(
        map['teacherDepartments'].map((e) => e.toString()),
      ),

      bankName: map['bankName']?.toString(),
      accountNo: map['accountNo']?.toString(),
      phone: map['phone']?.toString(),
      email: map['email']?.toString(),

      department: map['department']?.toString(),
      programId: map['programId']?.toString(),
      programName: map['programName']?.toString(),

      degree: map['degree']?.toString(),
      batch: map['batch']?.toString(),
      section: map['section']?.toString(),

      semester: map['semester']?.toString(),
      semesterId: map['semesterId']?.toString(),

      courseName: map['courseName']?.toString(),
      courseCode: map['courseCode']?.toString(),
      creditHours: map['creditHours']?.toString(),

      isCombinedClass: map['isCombinedClass'] ?? false,

      affiliation: map['affiliation']?.toString(),
      status: map['status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {

    return {

      if (id != null) '_id': id,
      'courseMappingId': courseMappingId,
      'combinedPrograms': combinedProgramsIds==null?[]: combinedProgramsIds!.map((e) => e.toString(),).toList(),

      'teacherId': teacherId,

      'isCombinedClass': isCombinedClass,

      'affiliation': affiliation,
      'status': status,
    };
  }

  TeacherAllocationModel copyWith({
    String? id,
    String? courseMappingId,
    List<String>? combinedProgramsIds,
    List<String>? combinedPrograms,
    String? teacherId,
    String? teacherName,
    List<String>? teacherDepartments,
    String? bankName,
    String? accountNo,
    String? phone,
    String? email,
    String? department,
    String? programId,
    String? programName,
    String? degree,
    String? batch,
    String? section,
    String? semester,
    String? semesterId,
    String? courseName,
    String? courseCode,
    String? creditHours,
    bool? isCombinedClass,
    String? affiliation,
    String? status,
  }) {
    return TeacherAllocationModel(
      id: id ?? this.id,
      courseMappingId: courseMappingId ?? this.courseMappingId,
      combinedProgramsIds:
      combinedProgramsIds ?? this.combinedProgramsIds,
      combinedPrograms: combinedPrograms ?? this.combinedPrograms,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      teacherDepartments:
      teacherDepartments ?? this.teacherDepartments,
      bankName: bankName ?? this.bankName,
      accountNo: accountNo ?? this.accountNo,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      department: department ?? this.department,
      programId: programId ?? this.programId,
      programName: programName ?? this.programName,
      degree: degree ?? this.degree,
      batch: batch ?? this.batch,
      section: section ?? this.section,
      semester: semester ?? this.semester,
      semesterId: semesterId ?? this.semesterId,
      courseName: courseName ?? this.courseName,
      courseCode: courseCode ?? this.courseCode,
      creditHours: creditHours ?? this.creditHours,
      isCombinedClass: isCombinedClass ?? this.isCombinedClass,
      affiliation: affiliation ?? this.affiliation,
      status: status ?? this.status,
    );
  }
}