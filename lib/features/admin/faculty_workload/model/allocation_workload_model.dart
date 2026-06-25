// ── allocation_workload_model.dart ───────────────────────────────────────────
//
// Matches this API shape exactly:
// {
//   _id, teacherName, courseCode, courseName, creditHours,
//   status, isCombinedClass, combinedPrograms,
//   teacherId:       { _id, teacherName }
//   courseMappingId: {
//     _id, status,
//     semesterId: {
//       _id, semesterName, status,
//       programId: { _id, name, session, section }
//     },
//     courseId: { _id, courseCode, courseTitle, creditHours, type }
//   }
// }

class AllocationWorkloadModel {
  final String? id;

  // flat fields — always present on the allocation document itself
  final String? teacherName;
  final String? courseCode;
  final String? courseName;
  final int?    creditHours;
  final String? status;
  final bool    isCombinedClass;
  final List<String> combinedPrograms;

  // nested populated objects (may be null if backend doesn't populate)
  final TeacherInfoModel?       teacher;
  final CourseMappingInfoModel? courseMapping;

  AllocationWorkloadModel({
    this.id,
    this.teacherName,
    this.courseCode,
    this.courseName,
    this.creditHours,
    this.status,
    this.isCombinedClass  = false,
    this.combinedPrograms = const [],
    this.teacher,
    this.courseMapping,
  });

  factory AllocationWorkloadModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return AllocationWorkloadModel();

    return AllocationWorkloadModel(
      id:           map['_id']?.toString()          ?? '',
      teacherName:  map['teacherName']?.toString()  ?? '',
      courseCode:   map['courseCode']?.toString()   ?? '',
      courseName:   map['courseName']?.toString()   ?? '',
      status:       map['status']?.toString()       ?? 'Active',
      isCombinedClass: map['isCombinedClass'] == true,
      creditHours: map['creditHours'] != null
          ? int.tryParse('${map['creditHours']}') ?? 0
          : 0,
      combinedPrograms: map['combinedPrograms'] is List
          ? List<String>.from(
          (map['combinedPrograms'] as List).map((e) => e.toString()))
          : [],
      teacher: map['teacherId'] is Map
          ? TeacherInfoModel.fromMap(
          map['teacherId'] as Map<String, dynamic>)
          : null,
      courseMapping: map['courseMappingId'] is Map
          ? CourseMappingInfoModel.fromMap(
          map['courseMappingId'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ── courseMappingId ──────────────────────────────────────────────────────────

class CourseMappingInfoModel {
  final String? id;
  final String? status;
  final SemesterInfoModel? semester;  // ← semesterId
  final CourseInfoModel?   course;    // ← courseId

  CourseMappingInfoModel({this.id, this.status, this.semester, this.course});

  factory CourseMappingInfoModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return CourseMappingInfoModel();
    return CourseMappingInfoModel(
      id:       map['_id']?.toString()    ?? '',
      status:   map['status']?.toString() ?? '',
      semester: map['semesterId'] is Map
          ? SemesterInfoModel.fromMap(map['semesterId'] as Map<String, dynamic>)
          : null,
      course: map['courseId'] is Map
          ? CourseInfoModel.fromMap(map['courseId'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ── semesterId ───────────────────────────────────────────────────────────────

class SemesterInfoModel {
  final String? id;
  final String? semesterName; // "1", "2", etc.
  final String? status;
  final ProgramInfoModel? program; // ← programId

  SemesterInfoModel({this.id, this.semesterName, this.status, this.program});

  factory SemesterInfoModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return SemesterInfoModel();
    return SemesterInfoModel(
      id:           map['_id']?.toString()           ?? '',
      semesterName: map['semesterName']?.toString()  ?? '',
      status:       map['status']?.toString()        ?? '',
      program: map['programId'] is Map
          ? ProgramInfoModel.fromMap(map['programId'] as Map<String, dynamic>)
          : null,
    );
  }
}

// ── programId ────────────────────────────────────────────────────────────────

class ProgramInfoModel {
  final String? id;
  final String? name;       // "Program 1 BZU"
  final String? session;    // "2021-2025"
  final String? section;    // "A"

  ProgramInfoModel({this.id, this.name, this.session, this.section});

  factory ProgramInfoModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return ProgramInfoModel();
    return ProgramInfoModel(
      id:      map['_id']?.toString()     ?? '',
      name:    map['name']?.toString()    ?? '',
      session: map['session']?.toString() ?? '',
      section: map['section']?.toString() ?? '',
    );
  }
}

// ── courseId ─────────────────────────────────────────────────────────────────

class CourseInfoModel {
  final String? id;
  final String? courseCode;   // "CS-202"
  final String? courseTitle;  // "Database System"
  final int?    creditHours;  // 3
  final String? type;         // "Theory"

  // set during workload computation (not from API)
  final String programLabel;  // "Program 1 BZU › A › Sem 1"
  final bool   isCombined;

  CourseInfoModel({
    this.id,
    this.courseCode,
    this.courseTitle,
    this.creditHours,
    this.type,
    this.programLabel = '',
    this.isCombined   = false,
  });

  factory CourseInfoModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return CourseInfoModel();
    return CourseInfoModel(
      id:          map['_id']?.toString()          ?? '',
      courseCode:  map['courseCode']?.toString()   ?? '',
      courseTitle: map['courseTitle']?.toString()  ?? '',
      type:        map['type']?.toString()         ?? '',
      creditHours: map['creditHours'] != null
          ? int.tryParse('${map['creditHours']}') ?? 0
          : 0,
    );
  }
}

// ── teacherId ────────────────────────────────────────────────────────────────

class TeacherInfoModel {
  final String? id;
  final String? teacherName;

  TeacherInfoModel({this.id, this.teacherName});

  factory TeacherInfoModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return TeacherInfoModel();
    return TeacherInfoModel(
      id:          map['_id']?.toString()          ?? '',
      teacherName: map['teacherName']?.toString()  ?? '',
    );
  }
}