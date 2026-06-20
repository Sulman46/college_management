class AppApis {
  AppApis._();

  //base urls
  // static String baseUrl = "http://172.29.64.1:9500";
  // static String baseUrl = "http://192.168.100.195:9500";
  static String baseUrl = "http://192.168.100.200:9500";
  // static String baseUrl = "http://10.193.167.161:9500";

  static String login = "/api/auth/login";

  /// access generated
  static String accessGenerate="/api/admin/generate-user";

  /// university profile update, affiliation etc
  static String universityProfileSetup="/api/university-setup";

  /// profile image update
  static String profileImageUpdate="/update-profile-img";

  /// department
  static String department = "/api/departments";

  /// program
  static String program= "/api/programs";

  /// course-catalog
  static String courseCatalog="/api/course-catalog";

  /// course-mapping
  static String courseMapping="/api/course-mappings";

  /// semester
  static String semester="/api/semesters";

  /// teacher
  static String teachers="/api/teachers";

  /// teacher allocation
  static String teacherAllocation="/api/allocations";

  /// teacher attendance
  static String teacherAttendancePost="/api/teacher-attendance/mark";
  static String teacherAttendanceEdit="/api/teacher-attendance/edit/";
  static String teacherAttendanceDelete="/api/teacher-attendance/delete/";
  static String teacherAttendanceHistory="/api/teacher-attendance/history";

  // announcement
  static String announcement="/api/notices";

  // hod
  static String hodAssign="/api/hod/assign";
  static String hodList="/api/hod/list";
  static String hodUpdate="/api/hod/update";
  static String hodDelete="/api/hod/delete";

  // timetable manager
  static String timeTableManager="/api/timetables";

  /// student register
  static String studentRegister="/api/students";

  /// student enrollment
  static String studentEnrollments="/api/enrollments";



  /// share pref
  static String userKey = "user_data";
  static String tokenKey = "user_token";
}
