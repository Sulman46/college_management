import 'package:college_management/features/admin/departments/data/model/department_model.dart';
import 'package:college_management/features/admin/university_profile/models/affiliation_model.dart';

import '../../../../core/enums/status_enum.dart';

class ProgramModel {
  String? id;
  String? name;
  String? code;
  DepartmentModel? department;
  String? affiliationId;
  String? affiliationName;
  String? degree;
  String? session;
  String? section;
  StatusEnum? status;

  int? mids;
  int? sessional;
  int? finalMarks;

  int? totalTheory;
  int? theoryPassPercentage;

  int? practicalMax;
  int? practicalPassPercentage;

  ProgramModel({
     this.id,
     this.name,
     this.code,
     this.department,
     this.affiliationId,
     this.affiliationName,
     this.degree,
     this.session,
     this.section,
     this.status,
     this.mids,
     this.sessional,
     this.finalMarks,
     this.totalTheory,
     this.theoryPassPercentage,
     this.practicalMax,
     this.practicalPassPercentage,
  });

  factory ProgramModel.fromMap(
      Map<String, dynamic> map) {
    return ProgramModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      department: DepartmentModel.fromMap(map['department']??""),
      affiliationId:map['affiliation']??"",
      affiliationName:map['affiliationName']??"",
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
      'department': department?.id,
      'affiliation': affiliationId,
      'degree': degree,
      'session': session,
      'section': section,
      'status': status?.name,
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


  ProgramModel copyWith({
    String? id,
    String? name,
    String? code,
    DepartmentModel? department,
    String? affiliationId,
    String? affiliationName,
    String? degree,
    String? session,
    String? section,
    StatusEnum? status,
    int? mids,
    int? sessional,
    int? finalMarks,
    int? totalTheory,
    int? theoryPassPercentage,
    int? practicalMax,
    int? practicalPassPercentage,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      department: department ?? this.department,
      affiliationId: affiliationId ?? this.affiliationId,
      affiliationName: affiliationName ?? this.affiliationName,
      degree: degree ?? this.degree,
      session: session ?? this.session,
      section: section ?? this.section,
      status: status ?? this.status,
      mids: mids ?? this.mids,
      sessional: sessional ?? this.sessional,
      finalMarks: finalMarks ?? this.finalMarks,
      totalTheory: totalTheory ?? this.totalTheory,
      theoryPassPercentage:
      theoryPassPercentage ?? this.theoryPassPercentage,
      practicalMax: practicalMax ?? this.practicalMax,
      practicalPassPercentage:
      practicalPassPercentage ?? this.practicalPassPercentage,
    );
  }

}

