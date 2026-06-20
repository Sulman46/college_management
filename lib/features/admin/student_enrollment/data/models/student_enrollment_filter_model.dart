class StudentEnrollmentFilterModel {
  final String? semester;
  final String? section;
  final String? department;
  final String? session;
  final String? affiliation;

  const StudentEnrollmentFilterModel({
    this.semester,
    this.section,
    this.department,
    this.session,
    this.affiliation,
  });

  factory StudentEnrollmentFilterModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return StudentEnrollmentFilterModel(
      semester: map['semester']?.toString(),
      section: map['section']?.toString(),
      department: map['department']?.toString(),
      session: map['session']?.toString(),
      affiliation: map['affiliation']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (semester != null && semester!.isNotEmpty)
        'semester': semester,
      if (section != null && section!.isNotEmpty)
        'section': section,
      if (department != null && department!.isNotEmpty)
        'department': department,
      if (session != null && session!.isNotEmpty)
        'session': session,
      if (affiliation != null && affiliation!.isNotEmpty)
        'affiliation': affiliation,
    };
  }

  StudentEnrollmentFilterModel copyWith({
    String? semester,
    String? section,
    String? department,
    String? session,
    String? affiliation,
  }) {
    return StudentEnrollmentFilterModel(
      semester: semester ?? this.semester,
      section: section ?? this.section,
      department: department ?? this.department,
      session: session ?? this.session,
      affiliation: affiliation ?? this.affiliation,
    );
  }

  bool get isAnyNull=>semester==null||section==null||department==null||session==null||affiliation==null;
}