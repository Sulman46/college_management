class TableFilterModel {
  String? department;
  String? program;
  String? session;

  TableFilterModel({
    this.department,
    this.program,
    this.session,
  });

  bool get allEmpty {
    return (department == null || department!.trim().isEmpty) &&
        (program == null || program!.trim().isEmpty) &&
        (session == null || session!.trim().isEmpty);
  }

  TableFilterModel copyWith({
    String? department,
    String? program,
    String? session,
  }) {
    return TableFilterModel(
      department: department ?? this.department,
      program: program ?? this.program,
      session: session ?? this.session,
    );
  }
}