class CoordinatorRegisterModel {
  final String? id;
  final String? coordinatorName;
  final List<CoordinatorProgramModel>? programs;
  final String? email;
  final String? userName;
  final bool? isAccountGenerated;
  final String? phone;
  final String? cnic;
  final String? designation;
  final String? status;

  const CoordinatorRegisterModel({
    this.id,
    this.coordinatorName,
    this.isAccountGenerated,
    this.userName,
    this.programs,
    this.email,
    this.phone,
    this.cnic,
    this.designation,
    this.status,
  });

  factory CoordinatorRegisterModel.fromMap(Map<String, dynamic> map) {
    return CoordinatorRegisterModel(
      id: map['_id']?.toString(),
      userName: map['userName']??"-",
      isAccountGenerated: map['isAccountGenerated']??false,
      coordinatorName: map['coordinatorName']?.toString(),
      programs: map['programs'] == null
          ? []
          : List<CoordinatorProgramModel>.from(
        map['programs'].map(
              (e) => CoordinatorProgramModel.fromMap(e),
        ),
      ),
      email: map['email']?.toString(),
      phone: map['phone']?.toString(),
      cnic: map['cnic']?.toString(),
      designation: map['designation']?.toString(),
      status: map['status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'coordinatorName': coordinatorName,
      'programs': programs?.map((e) => e.id).toList(),
      'email': email,
      'phone': phone,
      'cnic': cnic,
      'designation': designation,
      'status': status,
    };
  }

  CoordinatorRegisterModel copyWith({
    String? id,
    String? coordinatorName,
    bool? isAccountGenerated,
    String? userName,
    List<CoordinatorProgramModel>? programs,
    String? email,
    String? phone,
    String? cnic,
    String? designation,
    String? status,
  }) {
    return CoordinatorRegisterModel(
      id: id ?? this.id,
      coordinatorName: coordinatorName ?? this.coordinatorName,
      userName: userName ?? this.userName,
      isAccountGenerated: isAccountGenerated ?? this.isAccountGenerated,
      programs: programs ?? this.programs,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      cnic: cnic ?? this.cnic,
      designation: designation ?? this.designation,
      status: status ?? this.status,
    );
  }
}


class CoordinatorProgramModel {
  final String? id;
  final String? name;
  final String? code;
  final CoordinatorDepartmentModel? department;
  final String? degree;
  final String? session;
  final String? section;
  final String? status;
  final String? effectiveStatus;

  const CoordinatorProgramModel({
    this.id,
    this.name,
    this.code,
    this.department,
    this.degree,
    this.session,
    this.section,
    this.status,
    this.effectiveStatus,
  });

  factory CoordinatorProgramModel.fromMap(Map<String, dynamic> map) {
    return CoordinatorProgramModel(
      id: map['_id']?.toString(),
      name: map['name']?.toString(),
      code: map['code']?.toString(),
      department: map['department'] == null
          ? null
          : CoordinatorDepartmentModel.fromMap(map['department']),
      degree: map['degree']?.toString(),
      session: map['session']?.toString(),
      section: map['section']?.toString(),
      status: map['status']?.toString(),
      effectiveStatus: map['effectiveStatus']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'name': name,
      'code': code,
      'department': department?.toMap(),
      'degree': degree,
      'session': session,
      'section': section,
      'status': status,
      'effectiveStatus': effectiveStatus,
    };
  }

  CoordinatorProgramModel copyWith({
    String? id,
    String? name,
    String? code,
    CoordinatorDepartmentModel? department,
    String? degree,
    String? session,
    String? section,
    String? status,
    String? effectiveStatus,
  }) {
    return CoordinatorProgramModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      department: department ?? this.department,
      degree: degree ?? this.degree,
      session: session ?? this.session,
      section: section ?? this.section,
      status: status ?? this.status,
      effectiveStatus: effectiveStatus ?? this.effectiveStatus,
    );
  }
}


class CoordinatorDepartmentModel {
  final String? id;
  final String? name;
  final String? code;
  final String? status;

  const CoordinatorDepartmentModel({
    this.id,
    this.name,
    this.code,
    this.status,
  });

  factory CoordinatorDepartmentModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return CoordinatorDepartmentModel(
      id: map['_id']?.toString(),
      name: map['name']?.toString(),
      code: map['code']?.toString(),
      status: map['status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'name': name,
      'code': code,
      'status': status,
    };
  }

  CoordinatorDepartmentModel copyWith({
    String? id,
    String? name,
    String? code,
    String? status,
  }) {
    return CoordinatorDepartmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
    );
  }
}