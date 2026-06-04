class AppApis {
  AppApis._();

  //base urls
  static String baseUrl = "http://10.193.167.161:9500";

  static String login = "/api/auth/login";

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

  /// share pref
  static String userKey = "user_data";
  static String tokenKey = "user_token";
}
