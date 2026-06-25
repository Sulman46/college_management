
class SemesterProgramModel {
  String id;
  String name;

  String departmentId;
  String departmentName;

  String affiliationId;
  String affiliationName;

  String degree;
  String session;
  String section;
  String code;
  String status;

  SemesterProgramModel({
    required this.id,
    required this.name,
    required this.departmentId,
    required this.departmentName,
    required this.affiliationId,
    required this.affiliationName,
    required this.degree,
    required this.session,
    required this.section,
    required this.code,
    required this.status,
  });

  factory SemesterProgramModel.fromMap(Map<String, dynamic> map) {
    return SemesterProgramModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      departmentId: map['department']["_id"] ?? '',
      departmentName: map['department']["name"] ?? '',
      affiliationId: map['affiliation'] is Map? map['affiliation']['id']??"":map['affiliation']?? '',
      affiliationName: map['affiliationName'] ?? '',
      degree: map['degree'] ?? '',
      session: map['session'] ?? '',
      section: map['section'] ?? '',
      code: map['code'] ?? '',
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'department': departmentId,
      'departmentName': departmentName,
      'affiliation': affiliationId,
      'affiliationName': affiliationName,
      'degree': degree,
      'session': session,
      'section': section,
      'code': code,
      'status': status,
    };
  }

  SemesterProgramModel copyWith({
    String? id,
    String? name,
    String? departmentId,
    String? departmentName,
    String? affiliationId,
    String? affiliationName,
    String? degree,
    String? session,
    String? section,
    String? code,
    String? status,
  }) {
    return SemesterProgramModel(
      id: id ?? this.id,
      name: name ?? this.name,
      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,
      affiliationId: affiliationId ?? this.affiliationId,
      affiliationName: affiliationName ?? this.affiliationName,
      degree: degree ?? this.degree,
      session: session ?? this.session,
      section: section ?? this.section,
      code: code ?? this.code,
      status: status ?? this.status,
    );
  }
}