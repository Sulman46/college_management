class SemesterLevelsModel {
  final String? id;
  final String? semesterName;
  final String? programId;
  final String? programName;
  final String? department;
  final String? degree;
  final String? affiliation;
  final String? section;
  final String? session;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;

  SemesterLevelsModel({
    this.id,
    this.semesterName,
    this.programId,
    this.programName,
    this.department,
    this.degree,
    this.affiliation,
    this.section,
    this.session,
    this.startDate,
    this.endDate,
    this.status,
  });

  factory SemesterLevelsModel.fromMap(Map<String, dynamic> map) {
    return SemesterLevelsModel(
      id: map['_id'] ?? "",
      semesterName: map['semesterName'] ?? "",

      programId: map['programId'] is Map
          ? map['programId']['_id']
          : map['programId'] ?? "",

      programName: map['programName'] ?? "",
      department: map['department'] ?? "",
      degree: map['degree'] ?? "",
      affiliation: map['affiliation'] ?? "",
      section: map['section'] ?? "",
      session: map['session'] ?? "",

      startDate: map['startDate'] != null
          ? DateTime.tryParse(map['startDate'])
          : null,

      endDate: map['endDate'] != null
          ? DateTime.tryParse(map['endDate'])
          : null,

      status: map['status'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'semesterName': semesterName,
      'programId': programId,
      'programName': programName,
      'department': department,
      'degree': degree,
      'affiliation': affiliation,
      'section': section,
      'session': session,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      if (status != null) 'status': status,
    };
  }

  SemesterLevelsModel copyWith({
    String? id,
    String? semesterName,
    String? programId,
    String? programName,
    String? department,
    String? degree,
    String? affiliation,
    String? section,
    String? session,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) {
    return SemesterLevelsModel(
      id: id ?? this.id,
      semesterName: semesterName ?? this.semesterName,
      programId: programId ?? this.programId,
      programName: programName ?? this.programName,
      department: department ?? this.department,
      degree: degree ?? this.degree,
      affiliation: affiliation ?? this.affiliation,
      section: section ?? this.section,
      session: session ?? this.session,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}