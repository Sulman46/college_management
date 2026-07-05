
class FilterExamsScheduleModel {
   String? semester;
   String? section;
   String? department;
   String? session;
   String? affiliation;
   String? program;
   String? semesterId;
   String? programId;

   FilterExamsScheduleModel({
    this.semesterId,
    this.semester,
    this.section,
    this.department,
    this.session,
    this.affiliation,
    this.programId,
    this.program,
  });

  factory FilterExamsScheduleModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return FilterExamsScheduleModel(
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
        'semesterName': semester!.replaceAll(" (Active)", "").replaceAll(" (Inactive)", ""),
      if (section != null && section!.isNotEmpty)
        'section': section,
      // if (department != null && department!.isNotEmpty)
      //   'department': department,
      if (session != null && session!.isNotEmpty)
        'session': session,
      if (program != null && program!.isNotEmpty)
        'program': program,
      // if (semesterId != null && semesterId!.isNotEmpty)
      //   'semesterId': semesterId,
      // if (programId != null && programId!.isNotEmpty)
      //   'programId': programId,
    };
  }


  FilterExamsScheduleModel copyWith({
    String? affiliation,
    String? department,
    String? program,
    String? section,
    String? session,
    String? semester,
    String? semesterId,
    String? programId,
  }) {
    // Affiliation changed
    if (affiliation != null) {
      return FilterExamsScheduleModel(
        affiliation: affiliation,
      );
    }

    // Department changed
    if (department != null) {
      return FilterExamsScheduleModel(
        affiliation: this.affiliation,
        department: department,
      );
    }

    // Program changed
    if (program != null) {
      return FilterExamsScheduleModel(
        affiliation: this.affiliation,
        department: this.department,
        program: program,
      );
    }

    // Section changed
    if (section != null) {
      return FilterExamsScheduleModel(
        affiliation: this.affiliation,
        department: this.department,
        program: this.program,
        section: section,
      );
    }

    // Session changed
    if (session != null) {
      return FilterExamsScheduleModel(
        affiliation: this.affiliation,
        department: this.department,
        program: this.program,
        section: this.section,
        session: session,
      );
    }

    // semester Changed
    if(semester!=null){
      return FilterExamsScheduleModel(
        affiliation: affiliation ?? this.affiliation,
        department: department ?? this.department,
        program: program ?? this.program,
        section: section ?? this.section,
        session: session ?? this.session,
        semester: semester,
        semesterId: semesterId ?? this.semesterId,
        programId: programId ?? this.programId,
      );
    }


    return FilterExamsScheduleModel(
      affiliation: affiliation ?? this.affiliation,
      department: department ?? this.department,
      program: program ?? this.program,
      section: section ?? this.section,
      session: session ?? this.session,
      semester: semester ?? this.semester,
      semesterId: semesterId ?? this.semesterId,
      programId: programId ?? this.programId,
    );
  }

  bool get isAnyNull =>
      affiliation == null || affiliation!.isEmpty ||
          department == null || department!.isEmpty ||
          program == null || program!.isEmpty ||
          programId == null || programId!.isEmpty ||
          session == null || session!.isEmpty ||
          section == null || section!.isEmpty ||
          semester == null || semester!.isEmpty ||
          semesterId == null || semesterId!.isEmpty ;
}