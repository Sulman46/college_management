import 'package:flutter/material.dart';

class ExamScheduleResponseModel {
   List<ExamCourseMappingModel> mappings;
   List<ExamScheduleModel> dates;

   ExamScheduleResponseModel({
    required this.mappings,
    required this.dates,
  });

  factory ExamScheduleResponseModel.fromMap(Map<String, dynamic> map) {
    return ExamScheduleResponseModel(
      mappings: (map['mappings'] as List? ?? [])
          .map((e) => ExamCourseMappingModel.fromMap(e))
          .toList(),
      dates: (map['dates'] as List? ?? [])
          .map((e) => ExamScheduleModel.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mappings': mappings.map((e) => e.toMap()).toList(),
      'dates': dates.map((e) => e.toMap()).toList(),
    };
  }

  ExamScheduleResponseModel copyWith({
    List<ExamCourseMappingModel>? mappings,
    List<ExamScheduleModel>? dates,
  }) {
    return ExamScheduleResponseModel(
      mappings: mappings ?? this.mappings,
      dates: dates ?? this.dates,
    );
  }
}

class ExamCourseMappingModel {
   String? id;
   String? courseMappingId;
   String? courseId;
   String? courseCode;
   String? courseTitle;
   int? creditHours;
   String? status;

   ExamCourseMappingModel({
    this.id,
    this.courseMappingId,
    this.courseId,
    this.courseCode,
    this.courseTitle,
    this.creditHours,
    this.status,
  });

  factory ExamCourseMappingModel.fromMap(Map<String, dynamic> map) {
    return ExamCourseMappingModel(
      id: map['_id'],
      courseMappingId: map['courseMappingId'],
      courseId: map['courseId'],
      courseCode: map['courseCode'],
      courseTitle: map['courseTitle'],
      creditHours: map['creditHours'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (courseMappingId != null) 'courseMappingId': courseMappingId,
      if (courseId != null) 'courseId': courseId,
      if (courseCode != null) 'courseCode': courseCode,
      if (courseTitle != null) 'courseTitle': courseTitle,
      if (creditHours != null) 'creditHours': creditHours,
      if (status != null) 'status': status,
    };
  }

  ExamCourseMappingModel copyWith({
    String? id,
    String? courseMappingId,
    String? courseId,
    String? courseCode,
    String? courseTitle,
    int? creditHours,
    String? status,
  }) {
    return ExamCourseMappingModel(
      id: id ?? this.id,
      courseMappingId: courseMappingId ?? this.courseMappingId,
      courseId: courseId ?? this.courseId,
      courseCode: courseCode ?? this.courseCode,
      courseTitle: courseTitle ?? this.courseTitle,
      creditHours: creditHours ?? this.creditHours,
      status: status ?? this.status,
    );
  }
}

class ExamScheduleModel {
   String? id;
   String? courseMappingId;
   DateTime? examDate;
   TimeOfDay? examTime;
   String? examType;

   ExamScheduleModel({
    this.id,
    this.courseMappingId,
    this.examDate,
    this.examTime,
    this.examType,
  });

  factory ExamScheduleModel.fromMap(Map<String, dynamic> map) {
    TimeOfDay? time;

    if (map['examTime'] != null) {
      var parts = map['examTime'].toString().split(':');
      if (parts.length >= 2) {
        time = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    }

    return ExamScheduleModel(
      id: map['_id'],
      courseMappingId: map['courseMappingId'],
      examDate: map['examDate'] != null
          ? DateTime.tryParse(map['examDate'])
          : null,
      examTime: time,
      examType: map['examType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (courseMappingId != null) 'courseMappingId': courseMappingId,
      if (examDate != null)
        'examDate':
        "${examDate!.year.toString().padLeft(4, '0')}-${examDate!.month.toString().padLeft(2, '0')}-${examDate!.day.toString().padLeft(2, '0')}",
      if (examTime != null)
        'examTime':
        "${examTime!.hour.toString().padLeft(2, '0')}:${examTime!.minute.toString().padLeft(2, '0')}",
      if (examType != null) 'examType': examType,
    };
  }

  ExamScheduleModel copyWith({
    String? id,
    String? courseMappingId,
    DateTime? examDate,
    TimeOfDay? examTime,
    String? examType,
  }) {
    return ExamScheduleModel(
      id: id ?? this.id,
      courseMappingId: courseMappingId ?? this.courseMappingId,
      examDate: examDate ?? this.examDate,
      examTime: examTime ?? this.examTime,
      examType: examType ?? this.examType,
    );
  }
}