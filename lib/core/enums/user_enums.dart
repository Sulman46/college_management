enum UserRole {
  admin,
  hod,
  teacher,
  coordinator,
  student;

  // Convert String -> Enum
  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;

      case 'hod':
        return UserRole.hod;

      case 'teacher':
        return UserRole.teacher;

      case 'coordinator':
        return UserRole.coordinator;

      case 'student':
        return UserRole.student;

      default:
        return UserRole.student;
    }
  }

  // Convert Enum -> String
  String toJson() {
    switch (this) {
      case UserRole.admin:
        return "Admin";

      case UserRole.hod:
        return "HOD";

      case UserRole.teacher:
        return "Teacher";

      case UserRole.coordinator:
        return "Coordinator";

      case UserRole.student:
        return "Student";
    }
  }
}