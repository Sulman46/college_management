import 'package:college_management/core/enums/user_enums.dart';

class ConstantData{
  static List<UserRole> userRoles=[
    UserRole.student,
    UserRole.teacher,
    UserRole.hod,
    UserRole.coordinator,
    UserRole.admin,
  ];
  static List<String> semesterList=['1', '2', '3', '4','5','6', '7', '8'];
  static List<String> qualificationList = [
    "Intermediate",
    "DAE",
    "Bachelor",
    "BS",
    "BSc",
    "BA",
    "B.Com",
    "BBA",
    "BE",
    "LLB",
    "Master",
    "MA",
    "MSc",
    "M.Com",
    "MBA",
    "MCS",
    "MIT",
    "MS",
    "MPhil",
    "PhD",
    "Post Doctorate",
    "Other",
  ];


  static List<String> designationList = ["Lecturer", "Assistant Professor", "Associate Professor", "Professor", "Head of Department", "Visiting Faculty"];


  static List<String> announcementCategoryList = [
    'Urgent','Academic','Sports','Technical'
  ];

  static List<String> announcementPriorityList = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static List<String> hodAssignStatus=["Active", "On Leave", "Former"];


  static List<String> teacherAttendanceStatus=['Present', 'Absent', 'Late', 'Early Left', 'Short', 'Half Day'];
  static List<String> teacherAttendanceType=['Subject-Wise', 'Overall', 'Live-Marking', 'Manual-Entry'];
  static List<String> filterTeacherAttendanceRecord=[
    "All",
    "Daily",
    "Monthly"
  ];

  static List<String> severityList=["Safe", "Caution","Danger"];

  static List<String>  morningSlot = [
    "08:00-09:00","09:00-10:00","10:00-11:00","11:00-12:00","12:00-13:00",
  ];
  static List<String>  eveningSlot = [
    "12:00-13:00","13:00-14:00","14:00-15:00","15:00-16:00","16:00-17:00",
  ];

  static List<String> coordinatorDesignation=["Program Coordinator","Assistant Coordinator","Deputy Coordinator","Senior Coordinator"];

  static List<String> courseTypes=['Theory', 'Lab', 'Theory + Lab'];

}