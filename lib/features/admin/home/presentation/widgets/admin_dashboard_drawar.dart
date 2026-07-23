import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_assets.dart';
import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/core/models/admin_drawer_button_model.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/page/coordinator_management_screen.dart';
import 'package:college_management/features/admin/exam_schedule/presentation/page/exam_schedule_screen.dart';
import 'package:college_management/features/admin/university_profile/presentation/page/affiliation/affiliated_universities_screen.dart';
import 'package:college_management/features/admin/programs/presentation/page/admin_program_screen.dart';
import 'package:college_management/features/admin/teacher_allocation/presentation/page/teacher_allocation_screen.dart';
import 'package:college_management/features/admin/university_profile/presentation/page/university_profile_screen.dart';
import 'package:college_management/widgets/custom_image_cache.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/controllers/screen_resizing/screen_resize_cubit.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../announcements/presentation/page/announcement_screen.dart';
import '../../../freez_unfreez_admin/presentation/page/freeze_unfreeze_screen.dart';
import '../../../marking_student/presentation/page/marking_student_screen.dart';
import '../../../neural_generator/presentation/page/user_management_screen.dart';
import '../../../student_result/presentation/page/student_result_screen.dart';
import '../../../university_profile/presentation/page/attendance_notification_admin_screen.dart';
import '../../../course_catalog/presentation/page/course_catalog_admin_screen.dart';
import '../../../course_mapping/presentation/page/course_mapping_screen.dart';
import '../../../departments/presentation/page/admin_department_screen.dart';
import '../../../faculty_workload/presentation/page/faculty_workload_screen.dart';
import '../../../hod_assignment/presentation/page/hod_assignment_screen.dart';
import '../../../leave_request/presentation/page/admin_leave_request_screen.dart';
import '../../../neural_generator/presentation/page/neural_generator_screen.dart';
import '../../../pay_roll_and_salary_management/presentation/page/payroll_and_salary_management_screen.dart';
import '../../../semesters/presentation/page/semester_admin_screen.dart';
import '../../../student_enrollment/presentation/page/student_enrollment_screen.dart';
import '../../../student_registrations/presentation/page/registered_student_list_screen.dart';
import '../../../teacher_attendance/presentation/page/teacher_attendance_admin_screen.dart';
import '../../../teacher_records/presentation/page/teacher_records_admin_screen.dart';
import '../../../timetable_manager/presentation/page/timetable_manager_screen.dart';
import 'drawer_button_widget.dart';

class AdminDashboardDrawar extends StatefulWidget {
  const AdminDashboardDrawar({super.key});

  @override
  State<AdminDashboardDrawar> createState() => _AdminDashboardDrawarState();
}

class _AdminDashboardDrawarState extends State<AdminDashboardDrawar> {
  final ScrollController _scrollController = ScrollController();
  final _authCubit=DiContainer().sl<AuthenticationCubit>();

  var sizeCubit = DiContainer().sl<ScreenResizeCubit>();
  @override
  Widget build(BuildContext context) {
    List<AdminDrawerButtonModel> itemsList = [

      if(_authCubit.userModel!.role==UserRole.admin)
      AdminDrawerButtonModel(
        title: "University",
        icon: Icons.account_balance_outlined,
        onTap: () {},
        subList: [
          SubDrawerButtonModel(
            title: "Profile",
            icon: Icons.manage_accounts,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UniversityProfileScreen(),
                ),
              );
            },
          ),
          SubDrawerButtonModel(
            title: "Affiliation",
            icon: Icons.connect_without_contact_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AffiliatedUniversitiesScreen(),
                ),
              );
            },
          ),
          SubDrawerButtonModel(
            title: "Attendance",
            icon: Icons.co_present_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendanceNotificationAdminScreen(),
                ),
              );
            },
          ),
        ],
      ),
      if(_authCubit.userModel!.role==UserRole.admin || _authCubit.userModel!.role==UserRole.hod|| _authCubit.userModel!.role==UserRole.coordinator)
      AdminDrawerButtonModel(
        title: "Department",
        icon: Icons.category,
        onTap: () {
          context.push("/Admin-department");
        },
      ),
      if(_authCubit.userModel!.role==UserRole.admin || _authCubit.userModel!.role==UserRole.hod|| _authCubit.userModel!.role==UserRole.teacher|| _authCubit.userModel!.role==UserRole.coordinator)
      AdminDrawerButtonModel(
        title: "Programs",
        icon: Icons.class_,
        onTap: () {
          context.push("/Admin-program");
        },
      ),

      AdminDrawerButtonModel(
        title: "Semester",
        icon: Icons.school,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SemesterAdminScreen()),
          );
        },
      ),
      AdminDrawerButtonModel(
        title: "Courses",
        icon: Icons.menu_book_sharp,
        onTap: () {},
        subList: [
          if(_authCubit.userModel!.role==UserRole.admin || _authCubit.userModel!.role==UserRole.hod|| _authCubit.userModel!.role==UserRole.coordinator)
          SubDrawerButtonModel(
            title: "Course Catalog",
            icon: Icons.menu_book_sharp,
            onTap: () {
              context.push("/Admin-Course-catalog");
            },
          ),
          SubDrawerButtonModel(
            title: "Course Mapping",
            icon: Icons.map,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseMappingScreen()),
              );
            },
          ),
        ],
      ),

      AdminDrawerButtonModel(
        title: "Timetable Manager",
        icon: Icons.calendar_month,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TimetableManagerScreen()),
          );
        },
      ),
      if(_authCubit.userModel!.role!=UserRole.student)
      AdminDrawerButtonModel(
        title: "Teachers",
        icon: Icons.list_alt_sharp,
        onTap: () {},
        subList: [
          if(_authCubit.userModel!.role==UserRole.admin || _authCubit.userModel!.role==UserRole.hod|| _authCubit.userModel!.role==UserRole.teacher|| _authCubit.userModel!.role==UserRole.coordinator)
          SubDrawerButtonModel(
            title: "Teachers Record",
            icon: Icons.list_alt_sharp,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeacherRecordsAdminScreen(),
                ),
              );
            },
          ),
          SubDrawerButtonModel(
            title: "Teachers Allocation",
            icon: Icons.ballot,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeacherAllocationScreen(),
                ),
              );
            },
          ),
          SubDrawerButtonModel(
            title: "Teachers Attendance",
            icon: Icons.edit_calendar,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeacherAttendanceAdminScreen(),
                ),
              );
            },
          ),

          SubDrawerButtonModel(
            title: "Faculty Workload",
            icon: Icons.work_history_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FacultyWorkloadScreen(),
                ),
              );
            },
          ),

          if(_authCubit.userModel!.role==UserRole.admin||_authCubit.userModel!.role==UserRole.hod||_authCubit.userModel!.role==UserRole.coordinator||_authCubit.userModel!.role==UserRole.teacher)
          SubDrawerButtonModel(
            title: "Leave Request",
            icon: Icons.calendar_month,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminLeaveRequestScreen(),
                ),
              );
            },
          ),
        ],
      ),
      AdminDrawerButtonModel(
        title:_authCubit.userModel!.role==UserRole.student? "Action-Oriented": "Students",
        icon: Icons.boy,
        onTap: () {},
        subList: [
          if(_authCubit.userModel!.role==UserRole.admin||_authCubit.userModel!.role==UserRole.coordinator)
          SubDrawerButtonModel(
            title: "Register Students",
            icon: Icons.boy,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisteredStudentListScreen(),
                ),
              );
            },
          ),
          SubDrawerButtonModel(
            title:_authCubit.userModel!.role==UserRole.student? "Enrollment": "Student Enrollment",
            icon: Icons.workspaces,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentEnrollmentScreen(),
                ),
              );
            },
          ),
          SubDrawerButtonModel(
            title: "Freeze/Withdrawal",
            icon: Icons.severe_cold,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FreezeUnfreezeScreen()),
              );
            },
          ),
          if(_authCubit.userModel!.role==UserRole.admin||_authCubit.userModel!.role==UserRole.hod||_authCubit.userModel!.role==UserRole.student)
          SubDrawerButtonModel(
            title:_authCubit.userModel!.role==UserRole.student? "Result":"Marking Engine",
            icon: Icons.newspaper_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MarkingStudentScreen()),
              );
            },
          ),
          if(_authCubit.userModel!.role!=UserRole.student)
          SubDrawerButtonModel(
            title: "Result",
            icon: Icons.chrome_reader_mode_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentResultScreen()),
              );
            },
          ),
          if(_authCubit.userModel!.role==UserRole.admin)
          SubDrawerButtonModel(
            title: "Exam Schedule",
            icon: Icons.chrome_reader_mode_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExamScheduleScreen()),
              );
            },
          ),
        ],
      ),
      if(_authCubit.userModel!.role==UserRole.admin)
      AdminDrawerButtonModel(
        title: "HOD & Coordinator",
        icon: Icons.manage_accounts_rounded,
        subList: [
          SubDrawerButtonModel(
            title: "HOD Assignment",
            icon: Icons.assignment_ind,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HodAssignmentScreen()),
              );
            },
          ),
          SubDrawerButtonModel(
            title: "Coordinator Management",
            icon: Icons.manage_accounts_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoordinatorManagementScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // if(_authCubit.userModel!.role==UserRole.admin)
      // AdminDrawerButtonModel(
      //   title: "Payroll & Salary Management",
      //   icon: Icons.payment,
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => PayrollAndSalaryManagementScreen(),
      //       ),
      //     );
      //   },
      // ),
      AdminDrawerButtonModel(
        title: "Announcements",
        icon: Icons.announcement,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnnouncementScreen()),
          );
        },
      ),
      if(_authCubit.userModel!.role==UserRole.admin)
      AdminDrawerButtonModel(
        title: "System",
        icon: Icons.manage_accounts_rounded,
        subList: [
          if(_authCubit.userModel!.role==UserRole.admin)
          SubDrawerButtonModel(
            title: "Neural Generator",
            icon: Icons.flash_on_sharp,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NeuralGeneratorScreen(),
                ),
              );
            },
          ),
          if(_authCubit.userModel!.role==UserRole.admin)
          SubDrawerButtonModel(
            title: "User Management",
            icon: Icons.supervised_user_circle_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserManagementScreen()),
              );
            },
          ),

        ],
      ),

      AdminDrawerButtonModel(
        title: "Logout",
        icon: Icons.logout,
        onTap: () async {
          var authCubit = DiContainer().sl<AuthenticationCubit>();
          await authCubit.logout();
          context.go("/login");
        },
      ),
    ];

    return Drawer(
      width: sizeCubit.isLargeScreen
          ? mdWidth(context) * .4
          : mdWidth(context) * .7,
      // shape: Border(right: BorderSide(color: AppColor.primary.withOpacity(.5),width: 1)),
      backgroundColor: AppColor.bgPrimary,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: AppColor.primaryDark),
            child: Column(
              children: [
                const SafeArea(child: SizedBox(height: 3)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20),
                    InkWell(
                      splashColor: AppColor.transparent,
                      hoverColor: AppColor.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  splashColor: AppColor.transparent,
                  hoverColor: AppColor.transparent,
                  onTap: () {},
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppAssets.appLogo),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                AppText(
                  text: _authCubit.userModel?.name??"",
                  fontSize: 15,
                  color: AppColor.white,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  decoration: AppColor.containerNeonGreen,
                  child: AppText(text: _authCubit.userModel?.role.toJson()??"Active",color: AppColor.green,fontSize: 11,),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
          Expanded(
            child: ScrollbarTheme(
              data: ScrollbarThemeData(
                thickness: WidgetStatePropertyAll(3),
                trackColor: WidgetStatePropertyAll(
                  AppColor.primary.withOpacity(.3),
                ),
                trackBorderColor: WidgetStatePropertyAll(
                  AppColor.primary.withOpacity(.4),
                ),
                thumbColor: WidgetStatePropertyAll(AppColor.primary),
              ),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true, // 🔥 always visible
                trackVisibility: true, // optional (shows track)
                interactive: true, // 🔥 draggable
                thickness: 3,
                radius: Radius.circular(10),
                child: SingleChildScrollView(
                  padding: sizeCubit.isLargeScreen
                      ? EdgeInsets.symmetric(horizontal: 10)
                      : EdgeInsets.zero,
                  controller: _scrollController,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Column(
                        children: List.generate(itemsList.length, (index) {
                          bool isLast = index == itemsList.length - 1;
                          return DrawerButtonWidget(
                            // title: index == 0
                            //     ? "Main"
                            //     : index == 11
                            //     ? "Misc"
                            //     : null,
                            model: itemsList[index],
                          );
                        }),
                      ),
                      SafeArea(top: false, child: SizedBox(height: 20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
