import 'package:college_management/features/admin/programs/models/program_model.dart';

import '../../../../core/helper/app_date_picker.dart';

class TimeTableManagerModel {
  final String? id;
  final ProgramModel? programModel;
  final TimeTableSemesterModel? semesterModel;
  final DateTime? wefDate;
  final String? shiftType;
  final List<String>? timeSlots;
  final List<String>? days;
  final Map<String, TimeTableCellModel>? data;

  TimeTableManagerModel({
    this.id,
    this.shiftType,
    this.programModel,
    this.semesterModel,
    this.wefDate,
    this.timeSlots,
    this.days,
    this.data,
  });

  factory TimeTableManagerModel.fromMap(Map<String, dynamic> map) {
    return TimeTableManagerModel(
      id: map['_id'] ?? "",
      programModel: ProgramModel.fromMap(map['programId']??{}),
      shiftType: map['shiftType'] ?? "",
      semesterModel: map['semesterId'] != null
          ?TimeTableSemesterModel.fromMap(map['semesterId']): null,
      wefDate: map['wef'] != null
          ? DateTime.tryParse(map['wef'].toString())
          : null,
      timeSlots: map['timeSlots'] != null
          ? List<String>.from(map['timeSlots'])
          : [],
      days: map['days'] != null
          ? List<String>.from(map['days'])
          : [],
      data: map['data'] != null
          ? (map['data'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
          key,
          TimeTableCellModel.fromMap(
            Map<String, dynamic>.from(value),
          ),
        ),
      )
          : {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null && id!.isNotEmpty) '_id': id,
      if (programModel != null) 'programId': programModel?.id??"",
      if (shiftType != null) 'shiftType': shiftType,
      if (semesterModel != null) 'semesterId': semesterModel!.id,
      if (wefDate != null)
        'wef':formatDate(wefDate!),
      if (timeSlots != null) 'timeSlots': timeSlots,
      'days': ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"],
      if (data != null)
        'data': data!.map(
              (key, value) => MapEntry(key, value.toMap()),
        ),
    };
  }

  TimeTableManagerModel copyWith({
    String? id,
    String? department,
    String? shiftType,
    ProgramModel? programModel,
    String? affiliation,
    String? degree,
    TimeTableSemesterModel? semesterModel,
    String? section,
    String? session,
    DateTime? wefDate,
    List<String>? timeSlots,
    List<String>? days,
    Map<String, TimeTableCellModel>? data,
  }) {
    return TimeTableManagerModel(
      id: id ?? this.id,
      shiftType: shiftType ?? this.shiftType,
      programModel: programModel ?? this.programModel,
      semesterModel: semesterModel ?? this.semesterModel,
      wefDate: wefDate ?? this.wefDate,
      timeSlots: timeSlots ?? this.timeSlots,
      days: days ?? this.days,
      data: data ?? this.data,
    );
  }
}

class TimeTableCellModel {
  final String? courseId;
  final String? teacherId;
  final String? teacher;
  final String? subject;
  final String? room;

  TimeTableCellModel({
    this.courseId,
    this.teacherId,
    this.teacher,
    this.subject,
    this.room,
  });

  factory TimeTableCellModel.fromMap(Map<String, dynamic> map) {
    return TimeTableCellModel(
      courseId: map['courseId'],
      teacherId: map['teacherId'],
      teacher: map['teacher'] ?? "",
      subject: map['subject'] ?? "",
      room: map['room'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (courseId != null) 'courseId': courseId,
      if (teacherId != null) 'teacherId': teacherId,
      if (teacher != null) 'teacher': teacher,
      if (subject != null) 'subject': subject,
      if (room != null) 'room': room,
    };
  }

  TimeTableCellModel copyWith({
    String? courseId,
    String? teacherId,
    String? teacher,
    String? subject,
    String? room,
  }) {
    return TimeTableCellModel(
      courseId: courseId ?? this.courseId,
      teacherId: teacherId ?? this.teacherId,
      teacher: teacher ?? this.teacher,
      subject: subject ?? this.subject,
      room: room ?? this.room,
    );
  }
}



class TimeTableSemesterModel {
  final String? id;
  final String? semesterName;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;

  const TimeTableSemesterModel({
    this.id,
    this.semesterName,
    this.startDate,
    this.endDate,
    this.status,
  });

  factory TimeTableSemesterModel.fromMap(Map<String, dynamic> map) {
    return TimeTableSemesterModel(
      id: map['_id']?.toString(),
      semesterName: map['semesterName']?.toString(),
      startDate: map['startDate']!=null ? DateTime.tryParse(map['startDate'].toString()):DateTime.now(),
      endDate:  map['endDate']!=null ? DateTime.tryParse(map['endDate'].toString()):DateTime.now(),
      status: map['status']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'semesterName': semesterName,
      'startDate':formatDate(startDate!) ,
      'endDate':formatDate(endDate!),
      'status': status,
    };
  }

  TimeTableSemesterModel copyWith({
    String? id,
    String? semesterName,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) {
    return TimeTableSemesterModel(
      id: id ?? this.id,
      semesterName: semesterName ?? this.semesterName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}


class TimeTableGetDataModel {
  final String? affiliation;
  final String? department;
  final String? programName;
  final String? degree;
  final String? section;
  final String? session;
  final String? semesterName;
  final String? semesterId;
  final String? programId;
  final DateTime? wef;
  final String? shiftType;

  const TimeTableGetDataModel({
    this.affiliation,
    this.department,
    this.programName,
    this.degree,
    this.section,
    this.session,
    this.semesterName,
    this.semesterId,
    this.programId,
    this.wef,
    this.shiftType,
  });

  TimeTableGetDataModel copyWith({
    String? affiliation,
    String? department,
    String? programName,
    String? degree,
    String? section,
    String? session,
    String? semesterName,
    String? semesterId,
    String? programId,
    DateTime? wef,
    String? shiftType,
  }) {
    return TimeTableGetDataModel(
      affiliation: affiliation ?? this.affiliation,
      department: department ?? this.department,
      programName: programName ?? this.programName,
      degree: degree ?? this.degree,
      section: section ?? this.section,
      session: session ?? this.session,
      semesterName: semesterName ?? this.semesterName,
      semesterId: semesterId ?? this.semesterId,
      programId: programId ?? this.programId,
      wef: wef ?? this.wef,
      shiftType: shiftType ?? this.shiftType,
    );
  }

  /// Affiliation changed
  TimeTableGetDataModel resetAfterAffiliation() {
    return TimeTableGetDataModel(
      affiliation: affiliation,
    );
  }

  /// Department changed
  TimeTableGetDataModel resetAfterDepartment() {
    return TimeTableGetDataModel(
      affiliation: affiliation,
      department: department,
    );
  }

  /// Program changed
  TimeTableGetDataModel resetAfterProgram() {
    return TimeTableGetDataModel(
      affiliation: affiliation,
      department: department,
      programId: programId,
      programName: programName,
    );
  }

  /// Degree changed
  TimeTableGetDataModel resetAfterDegree() {
    return TimeTableGetDataModel(
      affiliation: affiliation,
      department: department,
      programId: programId,
      programName: programName,
      degree: degree,
    );
  }

  /// Section changed
  TimeTableGetDataModel resetAfterSection() {
    return TimeTableGetDataModel(
      affiliation: affiliation,
      department: department,
      programId: programId,
      programName: programName,
      degree: degree,
      section: section,
    );
  }

  /// Session changed
  TimeTableGetDataModel resetAfterSession() {
    return TimeTableGetDataModel(
      affiliation: affiliation,
      department: department,
      programId: programId,
      programName: programName,
      degree: degree,
      section: section,
      session: session,
    );
  }

  /// Semester changed
  TimeTableGetDataModel resetAfterSemester() {
    return TimeTableGetDataModel(
      affiliation: affiliation,
      department: department,
      programId: programId,
      programName: programName,
      degree: degree,
      section: section,
      session: session,
      semesterId: semesterId,
      semesterName: semesterName,
    );
  }

  /// WEF changed
  TimeTableGetDataModel resetAfterWef() {
    return TimeTableGetDataModel(
      affiliation: affiliation,
      department: department,
      programId: programId,
      programName: programName,
      degree: degree,
      section: section,
      session: session,
      semesterId: semesterId,
      semesterName: semesterName,
      wef: wef,
    );
  }
}