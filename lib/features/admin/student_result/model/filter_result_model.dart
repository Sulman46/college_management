
class FilterResultModel {
  final String? semester;
  final String? section;
  final String? department;
  final String? session;
  final String? affiliation;
  final String? program;
  final String? semesterId;
  final String? programId;

  const FilterResultModel({
    this.semesterId,
    this.semester,
    this.section,
    this.department,
    this.session,
    this.affiliation,
    this.programId,
    this.program,
  });

  factory FilterResultModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return FilterResultModel(
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
      if (semesterId != null && semesterId!.isNotEmpty)
        'semesterId': semesterId,
      if (programId != null && programId!.isNotEmpty)
        'programId': programId,
    };
  }


  FilterResultModel copyWith({
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
      return FilterResultModel(
        affiliation: affiliation,
      );
    }

    // Department changed
    if (department != null) {
      return FilterResultModel(
        affiliation: this.affiliation,
        department: department,
      );
    }

    // Program changed
    if (program != null) {
      return FilterResultModel(
        affiliation: this.affiliation,
        department: this.department,
        program: program,
      );
    }

    // Section changed
    if (section != null) {
      return FilterResultModel(
        affiliation: this.affiliation,
        department: this.department,
        program: this.program,
        section: section,
      );
    }

    // Session changed
    if (session != null) {
      return FilterResultModel(
        affiliation: this.affiliation,
        department: this.department,
        program: this.program,
        section: this.section,
        session: session,
      );
    }

    // semester Changed
    if(semester!=null){
      return FilterResultModel(
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


    return FilterResultModel(
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