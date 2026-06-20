import 'package:college_management/features/admin/programs/models/program_model.dart';

class SemesterLevelsModel {
  final String? id;
  final String? semesterName;
  final String? programId;
  final ProgramModel? programModel;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;

  SemesterLevelsModel({
    this.id,
    this.semesterName,
    this.programId,
    this.programModel,
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

      programModel: ProgramModel.fromMap(map['program']??""),
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
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      if (status != null) 'status': status,
    };
  }

  SemesterLevelsModel copyWith({
    String? id,
    String? semesterName,
    String? programId,
    ProgramModel? programModel,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) {
    return SemesterLevelsModel(
      id: id ?? this.id,
      semesterName: semesterName ?? this.semesterName,
      programModel: programModel ?? this.programModel,
      programId: programId ?? this.programId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}