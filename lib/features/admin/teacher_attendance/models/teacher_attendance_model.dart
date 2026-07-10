
import '../../../../core/helper/app_date_picker.dart';

class TeacherAttendanceModel {
  final String? id;
  final String? timetableId;
  final String? department;
  final String? programName;
  final String? affiliation;
  final String? degree;
  final String? semesterLevel;
  final String? section;
  final String? session;
  final String? teacher;
  final String? teacherId;
  final String? teacherType;
  final List<String>? teacherDepts;
  final String? subject;
  final String? slotTime;
  final String? slotIndex;
  final String? room;
  final String? status;
  final int? minutes;
  final String? attendanceType;
  final DateTime? date;
  final DateTime? month;
  final String? markedBy;
  final bool? isCombinedClass;
  final List<String>? combinedPrograms;
  final String? combinedLabel;

  TeacherAttendanceModel({
    this.id,
    this.timetableId,
    this.department,
    this.programName,
    this.affiliation,
    this.degree,
    this.semesterLevel,
    this.section,
    this.session,
    this.teacher,
    this.teacherId,
    this.teacherType,
    this.teacherDepts,
    this.subject,
    this.slotTime,
    this.slotIndex,
    this.room,
    this.status,
    this.minutes,
    this.attendanceType,
    this.date,
    this.month,
    this.markedBy,
    this.isCombinedClass,
    this.combinedPrograms,
    this.combinedLabel,
  });

  factory TeacherAttendanceModel.fromMap(Map<String, dynamic> map) {
    return TeacherAttendanceModel(
      id: map['_id'] ?? "",
      timetableId: map['timetableId'] ?? "",
      department: map['department'] ?? "",
      programName: map['programName'] ?? "",
      affiliation: map['affiliation'] ?? "",
      degree: map['degree'] ?? "Regular",
      semesterLevel: map['semesterName'] ?? "",
      section: map['section'] ?? "",
      session: map['session'] ?? "",
      teacher: map['teacher'] ?? "",
      teacherDepts: map['teacherDepts'] != null
          ? List<String>.from(map['teacherDepts'])
          : [],
      teacherId: map['teacherId'] ?? "",
      teacherType: map['teacherType'] ?? "",
      subject: map['subject'] ?? "",
      slotTime: map['slotTime'] ?? "",
      slotIndex: "${map['slotIndex']??""}",
      room: map['room'] ?? "",
      status: map['status'] ?? "",
      minutes: map['minutes'] != null
          ? int.tryParse("${map['minutes']}") ?? 0
          : 0,
      attendanceType: map['attendanceType'] ?? "",
      date: map['date'] != null
          ? DateTime.tryParse(map['date'].toString())
          : null,

      month: map['month'] != null
          ? DateTime.tryParse(map['month'].toString())
          : null,
      markedBy: map['markedBy'] ?? "",
      isCombinedClass: map['isCombinedClass'] ?? false,
      combinedPrograms: map['combinedPrograms'] != null
          ? List<String>.from(map['combinedPrograms'])
          : [],
      combinedLabel: map['combinedLabel'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null && id!.isNotEmpty) '_id': id,
      if (timetableId != null) 'timetableId': timetableId,
      if (teacherType != null) 'teacherType': teacherType,
      if (teacherId != null) 'teacherId': teacherId,
      if (teacherDepts != null) 'teacherDepts': teacherDepts,
      if (department != null) 'department': department,
      if (programName != null) 'programName': programName,
      if (affiliation != null) 'affiliation': affiliation,
      if (degree != null) 'degree': degree,
      if (semesterLevel != null) 'semesterName': semesterLevel,
      if (section != null) 'section': section,
      if (session != null) 'session': session,
      if (teacher != null) 'teacher': teacher,
      if (subject != null) 'subject': subject,
      if (slotTime != null) 'slotTime': slotTime,
      if (slotIndex != null) 'slotIndex': slotIndex,
      if (room != null) 'room': room,
      if (status != null) 'status': status,
      if (minutes != null) 'minutes': minutes,
      if (attendanceType != null) 'attendanceType': attendanceType,
      if (date != null) 'date':formatDate(date!),
      if (month != null) 'month':formatDateMonthOnly(month!),
      if (markedBy != null) 'markedBy': markedBy,
      if (isCombinedClass != null) 'isCombinedClass': isCombinedClass,
      if (combinedPrograms != null) 'combinedPrograms': combinedPrograms,
      if (combinedLabel != null) 'combinedLabel': combinedLabel,
    };
  }

  TeacherAttendanceModel copyWith({
    String? id,
    String? timetableId,
    String? department,
    String? programName,
    String? affiliation,
    String? degree,
    String? semesterLevel,
    String? section,
    String? session,
    String? teacher,
    String? subject,
    String? slotTime,
    String? slotIndex,
    String? room,
    String? status,

     String? teacherId,
     String? teacherType,
     List<String>? teacherDepts,
    int? minutes,
    String? attendanceType,
    DateTime? date,
    DateTime? month,
    String? markedBy,
    bool? isCombinedClass,
    List<String>? combinedPrograms,
    String? combinedLabel,
  }) {
    return TeacherAttendanceModel(
      id: id ?? this.id,
      teacherId: teacherId ?? this.teacherId,
      teacherType: teacherType ?? this.teacherType,
      teacherDepts: teacherDepts ?? this.teacherDepts,
      timetableId: timetableId ?? this.timetableId,
      department: department ?? this.department,
      programName: programName ?? this.programName,
      affiliation: affiliation ?? this.affiliation,
      degree: degree ?? this.degree,
      semesterLevel: semesterLevel ?? this.semesterLevel,
      section: section ?? this.section,
      session: session ?? this.session,
      teacher: teacher ?? this.teacher,
      subject: subject ?? this.subject,
      slotTime: slotTime ?? this.slotTime,
      slotIndex: slotIndex ?? this.slotIndex,
      room: room ?? this.room,
      status: status ?? this.status,
      minutes: minutes ?? this.minutes,
      attendanceType: attendanceType ?? this.attendanceType,
      date: date ?? this.date,
      month: month ?? this.month,
      markedBy: markedBy ?? this.markedBy,
      isCombinedClass: isCombinedClass ?? this.isCombinedClass,
      combinedPrograms: combinedPrograms ?? this.combinedPrograms,
      combinedLabel: combinedLabel ?? this.combinedLabel,
    );
  }


  bool get hasNullFields =>
      department == null ||
      department == null ||
          affiliation == null ||
          degree == null ||
          semesterLevel == null ||
          section == null ||
          session == null ||
          timetableId == null ||

          teacher == null ||
          subject == null ||
          slotTime == null ||
          room == null ||
          status == null ||
          minutes == null ||
          attendanceType == null ||
          date == null ||
          month == null ||
          markedBy == null ||
          (combinedPrograms == null || combinedPrograms!.isEmpty);

}