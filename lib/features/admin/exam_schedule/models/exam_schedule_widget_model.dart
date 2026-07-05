import 'package:flutter/material.dart';

class ExamScheduleWidgetModel {
   String? id;
   String? courseMappingId;
   String? courseCode;
   String? courseTitle;
   DateTime? examDate;
   TimeOfDay? examTime;
   String? examType;

   ExamScheduleWidgetModel({
    this.id,
    this.courseMappingId,
    this.courseCode,
    this.courseTitle,
    this.examDate,
    this.examTime,
    this.examType,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (courseMappingId != null) 'courseMappingId': courseMappingId,
      if (examDate != null)
        'examDate':
        '${examDate!.year.toString().padLeft(4, '0')}-${examDate!.month.toString().padLeft(2, '0')}-${examDate!.day.toString().padLeft(2, '0')}',
      if (examTime != null)
        'examTime':
        '${examTime!.hour.toString().padLeft(2, '0')}:${examTime!.minute.toString().padLeft(2, '0')}',
      if (examType != null) 'examType': examType,
    };
  }

  ExamScheduleWidgetModel copyWith({
    String? id,
    String? courseMappingId,
    String? courseCode,
    String? courseTitle,
    DateTime? examDate,
    TimeOfDay? examTime,
    String? examType,
  }) {
    return ExamScheduleWidgetModel(
      id: id ?? this.id,
      courseMappingId: courseMappingId ?? this.courseMappingId,
      courseCode: courseCode ?? this.courseCode,
      courseTitle: courseTitle ?? this.courseTitle,
      examDate: examDate ?? this.examDate,
      examTime: examTime ?? this.examTime,
      examType: examType ?? this.examType,
    );
  }
}