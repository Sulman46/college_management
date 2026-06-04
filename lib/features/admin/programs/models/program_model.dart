import '../../../../core/enums/status_enum.dart';

class ProgramModel {
  String id;
  String name;
  String code;
  String department;
  String affiliationName;
  String degree;
  String session;
  String section;
  StatusEnum status;

  int mids;
  int sessional;
  int finalMarks;

  int totalTheory;
  int theoryPassPercentage;

  int practicalMax;
  int practicalPassPercentage;

  ProgramModel({
    required this.id,
    required this.name,
    required this.code,
    required this.department,
    required this.affiliationName,
    required this.degree,
    required this.session,
    required this.section,
    required this.status,
    required this.mids,
    required this.sessional,
    required this.finalMarks,
    required this.totalTheory,
    required this.theoryPassPercentage,
    required this.practicalMax,
    required this.practicalPassPercentage,
  });

  factory ProgramModel.fromMap(
      Map<String, dynamic> map) {
    return ProgramModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      department: map['department'] ?? '',
      affiliationName:
      map['affiliationName'] ?? '',
      degree: map['degree'] ?? '',
      session: map['session'] ?? '',
      section: map['section'] ?? '',
      status: map['status']!=null? map['status']=="Active"?StatusEnum.Active:StatusEnum.Inactive:StatusEnum.Inactive,      mids: map['mids'] ?? 0,
      sessional: map['sessional'] ?? 0,
      finalMarks: map['final'] ?? 0,

      totalTheory:
      map['totalTheory'] ?? 0,

      theoryPassPercentage:
      map['theoryPassPercentage'] ?? 0,

      practicalMax:
      map['practicalMax'] ?? 0,

      practicalPassPercentage:
      map['practicalPassPercentage'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'code': code,
      'department': department,
      'affiliationName': affiliationName,
      'degree': degree,
      'session': session,
      'section': section,
      'status': status.name,
      'mids': mids,
      'sessional': sessional,
      'final': finalMarks,
      'totalTheory': totalTheory,
      'theoryPassPercentage':
      theoryPassPercentage,
      'practicalMax': practicalMax,
      'practicalPassPercentage':
      practicalPassPercentage,
    };
  }
}

