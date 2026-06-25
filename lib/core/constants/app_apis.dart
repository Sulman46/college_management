class AppApis {
  AppApis._();

  //base urls
  // static String baseUrl = "http://172.29.64.1:9500";
  // static String baseUrl = "http://192.168.0.100:9500";
  // static String baseUrl = "http://192.168.100.198:9500";
  static String baseUrl = "http://10.20.70.161:9500";

  static String login = "/api/auth/login";

  /// access generated
  static String accessGenerate="/api/admin/generate-user";

  /// university profile update, affiliation etc
  static String universityProfileSetup="/api/university-setup";
  static String universityProfileSetupUpdate="/api/university-setup/update-section";
  static String deleteUniversityProfileSetupUpdate="/api/university-setup/delete/";

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

  /// teacher allocation
  static String workload="/api/workload-data";

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


  static String coordinatorRegister="/api/coordinators/register";
  static String coordinatorManagement="/api/coordinators";

  /// student register
  static String studentRegister="/api/students";

  /// student enrollment
  static String studentEnrollments="/api/enrollments";
  static String studentEnrollmentsPromote="/api/enrollments/promote";
  static String studentEnrollmentsDemote="/api/enrollments/demote";



  /// share pref
  static String userKey = "user_data";
  static String tokenKey = "user_token";
}
