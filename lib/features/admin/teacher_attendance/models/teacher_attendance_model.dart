
class TeacherAttendanceModel {
  final String? id;
  final String? department;
  final String? programName;
  final String? affiliation;
  final String? degree;
  final String? semesterLevel;
  final String? section;
  final String? session;
  final String? teacher;
  final String? subject;
  final String? slotTime;
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
    this.department,
    this.programName,
    this.affiliation,
    this.degree,
    this.semesterLevel,
    this.section,
    this.session,
    this.teacher,
    this.subject,
    this.slotTime,
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
      department: map['department'] ?? "",
      programName: map['programName'] ?? "",
      affiliation: map['affiliation'] ?? "",
      degree: map['degree'] ?? "Regular",
      semesterLevel: map['semesterLevel'] ?? "",
      section: map['section'] ?? "",
      session: map['session'] ?? "",
      teacher: map['teacher'] ?? "",
      subject: map['subject'] ?? "",
      slotTime: map['slotTime'] ?? "",
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
      if (department != null) 'department': department,
      if (programName != null) 'programName': programName,
      if (affiliation != null) 'affiliation': affiliation,
      if (degree != null) 'degree': degree,
      if (semesterLevel != null) 'semesterLevel': semesterLevel,
      if (section != null) 'section': section,
      if (session != null) 'session': session,
      if (teacher != null) 'teacher': teacher,
      if (subject != null) 'subject': subject,
      if (slotTime != null) 'slotTime': slotTime,
      if (room != null) 'room': room,
      if (status != null) 'status': status,
      if (minutes != null) 'minutes': minutes,
      if (attendanceType != null) 'attendanceType': attendanceType,
      if (date != null) 'date': date!.toIso8601String(),
      if (month != null) 'month': month!.toIso8601String(),
      if (markedBy != null) 'markedBy': markedBy,
      if (isCombinedClass != null) 'isCombinedClass': isCombinedClass,
      if (combinedPrograms != null) 'combinedPrograms': combinedPrograms,
      if (combinedLabel != null) 'combinedLabel': combinedLabel,
    };
  }

  TeacherAttendanceModel copyWith({
    String? id,
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
    String? room,
    String? status,
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
          affiliation == null ||
          degree == null ||
          semesterLevel == null ||
          section == null ||
          session == null ||
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