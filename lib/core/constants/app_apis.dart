import 'package:shared_preferences/shared_preferences.dart';

class AppApis {
  AppApis._();

  //base urls
  // static String baseUrl = "http://172.29.64.1:9500";
  // static String baseUrl = "http://192.168.0.100:9500";
  // static String baseUrl = "http://192.168.100.198:9500";
  static String _baseUrl = "http://10.234.210.161:9500";


  static String get baseUrl => _baseUrl;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final ip = prefs.getString("server_ip") ?? "http://10.234.210.161:9500";
    _baseUrl = "http://$ip";
  }

  static Future<void> setBaseUrl(String ip) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("server_ip", ip);
    _baseUrl = "http://$ip";
  }


  static String login = "/api/auth/login";
  static String authStatus = "/api/auth/status-check";
  /// admin,coord dashboard api
  static String dashboardApi = "/api/app-dashboard-data";

  /// access generated neural
  static String accessGenerate="/api/admin/generate-user";

  /// users lists neural
  static String userList="/api/admin/users-list";
  static String userListStatus="/api/admin/user-status";
  static String userResetKey="/api/admin/user-reset-key";

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

  /// announcement
  static String announcement="/api/notices";

  /// hod
  static String hodAssign="/api/hod/assign";
  static String hodList="/api/hod/list";
  static String hodUpdate="/api/hod/update";
  static String hodDelete="/api/hod/delete";

  /// timetable manager
  static String timeTableManager="/api/timetables";


  static String coordinatorRegister="/api/coordinators/register";
  static String coordinatorManagement="/api/coordinators";

  /// student register
  static String studentRegister="/api/students";

  /// student enrollment
  static String studentEnrollments="/api/enrollments";
  static String studentEnrollmentsSearch="/api/enrollments/search/";
  static String studentEnrollmentsPromote="/api/enrollments/promote";
  static String studentEnrollmentsDemote="/api/enrollments/demote";

  /// leave
  static String leave="/api/leaves";


  /// freeze request
  static String freezePendingRequest="/api/admin/pending-requests";
  static String freezeFinalizedRequest="/api/admin/all-status-history";
  static String updateFreezeStatus="/api/update-status-request";
  static String deleteFreezeRequest="/api/admin/delete-request";
  static String studentRequestFreeze="/api/student/my-status-requests";
  static String sendStudentRequestFreeze="/api/student/submit-status-request";

  /// marking students
  static String markingStudents="/api/marks";
  static String markingCourseData="/api/marking-engine/course-data";
  static String bulkSaveMarks="/api/bulk-save";
  static String markingLock="/api/lock";
  static String studentMarkingHistory="/api/marking/student-history-roll/";

  /// result
  static String resultSheet="/api/result-sheet";

  /// exam date fetch
  static String fetchExamDate="/api/exam-schedule/fetch";
  static String examScheduleBulkSave="/api/exam-schedule/bulk-save";




  /// share pref
  static String userKey = "user_data";
  static String tokenKey = "user_token";
}
