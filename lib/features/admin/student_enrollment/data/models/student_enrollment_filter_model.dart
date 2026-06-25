class StudentEnrollmentFilterModel {
  final String? semester;
  final String? section;
  final String? department;
  final String? session;
  final String? affiliation;
  final String? program;

  const StudentEnrollmentFilterModel({
    this.semester,
    this.section,
    this.department,
    this.session,
    this.affiliation,
    this.program,
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
      program: map['program']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (semester != null && semester!.isNotEmpty)
        'semester': semester!.replaceAll(" (Active)", "").replaceAll(" (Inactive)", ""),
      if (section != null && section!.isNotEmpty)
        'section': section,
      if (department != null && department!.isNotEmpty)
        'department': department,
      if (session != null && session!.isNotEmpty)
        'session': session,
      if (affiliation != null && affiliation!.isNotEmpty)
        'affiliation': affiliation,
      // if (program != null && program!.isNotEmpty)
      //   'affiliation': program,
    };
  }


  StudentEnrollmentFilterModel copyWith({
    String? affiliation,
    String? department,
    String? program,
    String? section,
    String? session,
    String? semester,
  }) {
    // Affiliation changed
    if (affiliation != null) {
      return StudentEnrollmentFilterModel(
        affiliation: affiliation,
      );
    }

    // Department changed
    if (department != null) {
      return StudentEnrollmentFilterModel(
        affiliation: this.affiliation,
        department: department,
      );
    }

    // Program changed
    if (program != null) {
      return StudentEnrollmentFilterModel(
        affiliation: this.affiliation,
        department: this.department,
        program: program,
      );
    }

    // Section changed
    if (section != null) {
      return StudentEnrollmentFilterModel(
        affiliation: this.affiliation,
        department: this.department,
        program: this.program,
        section: section,
      );
    }

    // Session changed
    if (session != null) {
      return StudentEnrollmentFilterModel(
        affiliation: this.affiliation,
        department: this.department,
        program: this.program,
        section: this.section,
        session: session,
      );
    }

    // Normal copy
    return StudentEnrollmentFilterModel(
      affiliation: affiliation ?? this.affiliation,
      department: department ?? this.department,
      program: program ?? this.program,
      section: section ?? this.section,
      session: session ?? this.session,
      semester: semester ?? this.semester,
    );
  }

  bool get isAnyNull=>semester==null||section==null||department==null||session==null||program==null||affiliation==null;
}