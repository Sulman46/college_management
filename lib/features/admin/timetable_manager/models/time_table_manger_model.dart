class TimeTableManagerModel {
  final String? id;
  final String? department;
  final String? programName;
  final String? affiliation;
  final String? degree;
  final int? semesterLevel;
  final String? section;
  final String? session;
  final DateTime? wefDate;
  final List<String>? timeSlots;
  final List<String>? days;
  final Map<String, TimeTableCellModel>? data;

  TimeTableManagerModel({
    this.id,
    this.department,
    this.programName,
    this.affiliation,
    this.degree,
    this.semesterLevel,
    this.section,
    this.session,
    this.wefDate,
    this.timeSlots,
    this.days,
    this.data,
  });

  factory TimeTableManagerModel.fromMap(Map<String, dynamic> map) {
    return TimeTableManagerModel(
      id: map['_id'] ?? "",
      department: map['department'] ?? "",
      programName: map['programName'] ?? "",
      affiliation: map['affiliation'] ?? "",
      degree: map['degree'] ?? "",
      semesterLevel: map['semesterLevel'] != null
          ? int.tryParse("${map['semesterLevel']}") ?? 0
          : 0,
      section: map['section'] ?? "",
      session: map['session'] ?? "",
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
      if (department != null) 'department': department,
      if (programName != null) 'programName': programName,
      if (affiliation != null) 'affiliation': affiliation,
      if (degree != null) 'degree': degree,
      if (semesterLevel != null) 'semesterLevel': semesterLevel,
      if (section != null) 'section': section,
      if (session != null) 'session': session,
      if (wefDate != null)
        'wef': wefDate!.toIso8601String(),
      if (timeSlots != null) 'timeSlots': timeSlots,
      if (days != null) 'days': days,
      if (data != null)
        'data': data!.map(
              (key, value) => MapEntry(key, value.toMap()),
        ),
    };
  }

  TimeTableManagerModel copyWith({
    String? id,
    String? department,
    String? programName,
    String? affiliation,
    String? degree,
    int? semesterLevel,
    String? section,
    String? session,
    DateTime? wefDate,
    List<String>? timeSlots,
    List<String>? days,
    Map<String, TimeTableCellModel>? data,
  }) {
    return TimeTableManagerModel(
      id: id ?? this.id,
      department: department ?? this.department,
      programName: programName ?? this.programName,
      affiliation: affiliation ?? this.affiliation,
      degree: degree ?? this.degree,
      semesterLevel: semesterLevel ?? this.semesterLevel,
      section: section ?? this.section,
      session: session ?? this.session,
      wefDate: wefDate ?? this.wefDate,
      timeSlots: timeSlots ?? this.timeSlots,
      days: days ?? this.days,
      data: data ?? this.data,
    );
  }
}

class TimeTableCellModel {
  final String? courseId;
  final String? teacher;
  final String? subject;
  final String? room;

  TimeTableCellModel({
    this.courseId,
    this.teacher,
    this.subject,
    this.room,
  });

  factory TimeTableCellModel.fromMap(Map<String, dynamic> map) {
    return TimeTableCellModel(
      courseId: map['courseId'] ?? "",
      teacher: map['teacher'] ?? "",
      subject: map['subject'] ?? "",
      room: map['room'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (courseId != null) 'courseId': courseId,
      if (teacher != null) 'teacher': teacher,
      if (subject != null) 'subject': subject,
      if (room != null) 'room': room,
    };
  }

  TimeTableCellModel copyWith({
    String? courseId,
    String? teacher,
    String? subject,
    String? room,
  }) {
    return TimeTableCellModel(
      courseId: courseId ?? this.courseId,
      teacher: teacher ?? this.teacher,
      subject: subject ?? this.subject,
      room: room ?? this.room,
    );
  }
}