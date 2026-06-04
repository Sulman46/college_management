import 'package:college_management/features/Authentication/presentation/page/login.dart';
import 'package:college_management/features/admin/home/presentation/page/admin_home_screen.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/teacher_allocation/models/teacher_allocation_model.dart';
import 'package:college_management/features/admin/teacher_records/models/teacher_model.dart';
import 'package:college_management/features/splash/presentation/page/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/course_catalog/presentation/page/course_catalog_admin_screen.dart';
import '../../features/admin/course_mapping/model/course_mapping_model.dart';
import '../../features/admin/course_mapping/presentation/page/add_new_course_mapping_screen.dart';
import '../../features/admin/departments/presentation/page/admin_department_screen.dart';
import '../../features/admin/programs/presentation/page/add_new_program_screen.dart';
import '../../features/admin/programs/presentation/page/admin_program_screen.dart';
import '../../features/admin/semesters/models/semester_levels_model.dart';
import '../../features/admin/semesters/presentation/page/add_semester_screen.dart';
import '../../features/admin/teacher_allocation/presentation/page/new_allocation_screen.dart';
import '../../features/admin/teacher_records/presentation/page/add_teacher_record_screen.dart';
import '../../features/admin/teacher_records/presentation/page/teacher_record_details_screen.dart';
import '../../features/admin/university_profile/presentation/page/affiliation/add_affiliation_screen.dart';
import 'myapp.dart';

GoRouter goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(
      path: '/Admin-dashboard',
      builder: (context, state) => AdminHomeScreen(),
    ),
    GoRoute(
      path: '/Admin-department',
      builder: (context, state) => AdminDepartmentScreen(),
    ),
    GoRoute(
      path: '/Admin-program',
      builder: (context, state) => AdminProgramScreen(),
    ),
    GoRoute(
      path: '/Admin-Course-catalog',
      builder: (context, state) => CourseCatalogAdminScreen(),
    ),
    GoRoute(
      path: '/Admin-program-create',
      builder: (context, state) {
        ProgramModel? model = state.extra == null
            ? null
            : state.extra as ProgramModel;
        return CreateProgramScreen(programModel: model);
      },
    ),
    GoRoute(
      path: '/Admin-add-semester-screen',
      builder: (context, state) {
            SemesterLevelsModel? model = state.extra == null
            ? null
            : state.extra as SemesterLevelsModel;
        return AddSemesterScreen(semesterLevelsModel: model);
      },
    ),
    GoRoute(
      path: '/Admin-add-course-mapping',
      builder: (context, state) {
        CourseMappingModel? model = state.extra == null
            ? null
            : state.extra as CourseMappingModel;
        return AddNewCourseMappingScreen(updateCourseMapping: model);
      },
    ),
    GoRoute(
      path: '/Admin-affiliation-create',
      builder: (context, state) => AddAffiliationScreen(),
    ),


    GoRoute(
      path: '/Admin-teacher-record-details',
      builder: (context, state) {
        TeacherModel model= state.extra as TeacherModel;
      return  TeacherRecordDetailsScreen(model: model,);
      },
    ),



    GoRoute(
      path: '/Admin-add-teacher-record',
      builder: (context, state) {
        TeacherModel? model = state.extra == null
            ? null
            : state.extra as TeacherModel;
      return  AddTeacherRecordScreen(teacherModel: model,);
      },
    ),


    GoRoute(
      path: '/Admin-add-teacher-allocation',
      builder: (context, state) {
        TeacherAllocationModel? model = state.extra == null
            ? null
            : state.extra as TeacherAllocationModel;
      return  NewAllocationScreen(allocationModel: model,);
      },
    ),

  ],
);
