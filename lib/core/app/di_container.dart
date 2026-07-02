import 'package:college_management/core/controllers/screen_resizing/screen_resize_cubit.dart';
import 'package:college_management/core/domain/connectivity/data/datasource/datasource.dart';
import 'package:college_management/core/domain/connectivity/data/repository_impl/repository_impl.dart';
import 'package:college_management/core/domain/connectivity/domain/repository/repository.dart';
import 'package:college_management/core/domain/connectivity/domain/usecase/usecase.dart';
import 'package:college_management/features/admin/course_catalog/data/datasource/datasource.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../features/Authentication/data/datasource/datasource.dart';
import '../../features/Authentication/data/repository_impl/repository_impl.dart';
import '../../features/Authentication/domain/repository/repository.dart';
import '../../features/Authentication/domain/usecase/usecase.dart';
import '../../features/Authentication/presentation/controller/cubit.dart';
import '../../features/admin/announcements/data/datasource/datasource.dart';
import '../../features/admin/announcements/data/repository_impl/repository_impl.dart';
import '../../features/admin/announcements/domain/repository/repository.dart';
import '../../features/admin/announcements/domain/usecase/usecase.dart';
import '../../features/admin/announcements/presentation/controller/cubit.dart';
import '../../features/admin/coordinator_management/data/datasource/datasource.dart';
import '../../features/admin/coordinator_management/data/repository_impl/repository_impl.dart';
import '../../features/admin/coordinator_management/domain/repository/repository.dart';
import '../../features/admin/coordinator_management/domain/usecase/usecase.dart';
import '../../features/admin/coordinator_management/presentation/controller/cubit.dart';
import '../../features/admin/course_catalog/data/repository_impl/repository_impl.dart';
import '../../features/admin/course_catalog/domain/repository/repository.dart';
import '../../features/admin/course_catalog/domain/usecase/usecase.dart';
import '../../features/admin/course_catalog/presentation/controller/cubit.dart';
import '../../features/admin/course_mapping/data/datasource/datasource.dart';
import '../../features/admin/course_mapping/data/repository_impl/repository_impl.dart';
import '../../features/admin/course_mapping/domain/repository/repository.dart';
import '../../features/admin/course_mapping/domain/usecase/usecase.dart';
import '../../features/admin/departments/data/datasource/datasource.dart';
import '../../features/admin/departments/data/repository_impl/repository_impl.dart';
import '../../features/admin/departments/domain/repository/repository.dart';
import '../../features/admin/departments/domain/usecase/usecase.dart';
import '../../features/admin/faculty_workload/data/datasource/datasource.dart';
import '../../features/admin/faculty_workload/data/repository_impl/repository_impl.dart';
import '../../features/admin/faculty_workload/domain/repository/repository.dart';
import '../../features/admin/faculty_workload/domain/usecase/usecase.dart';
import '../../features/admin/faculty_workload/presentation/controller/cubit.dart';
import '../../features/admin/freez_unfreez_admin/data/datasource/datasource.dart';
import '../../features/admin/freez_unfreez_admin/data/repository_impl/repository_impl.dart';
import '../../features/admin/freez_unfreez_admin/domain/repository/repository.dart';
import '../../features/admin/freez_unfreez_admin/domain/usecase/usecase.dart';
import '../../features/admin/freez_unfreez_admin/presentation/controller/cubit.dart';
import '../../features/admin/hod_assignment/data/datasource/datasource.dart';
import '../../features/admin/hod_assignment/data/repository_impl/repository_impl.dart';
import '../../features/admin/hod_assignment/domain/repository/repository.dart';
import '../../features/admin/hod_assignment/domain/usecase/usecase.dart';
import '../../features/admin/hod_assignment/presentation/controller/cubit.dart';
import '../../features/admin/leave_request/data/datasource/datasource.dart';
import '../../features/admin/leave_request/data/repository_impl/repository_impl.dart';
import '../../features/admin/leave_request/domain/repository/repository.dart';
import '../../features/admin/leave_request/domain/usecase/usecase.dart';
import '../../features/admin/leave_request/presentation/controller/cubit.dart';
import '../../features/admin/marking_student/data/datasource/datasource.dart';
import '../../features/admin/marking_student/data/repository_impl/repository_impl.dart';
import '../../features/admin/marking_student/domain/repository/repository.dart';
import '../../features/admin/marking_student/domain/usecase/usecase.dart';
import '../../features/admin/marking_student/presentation/controller/cubit.dart';
import '../../features/admin/neural_generator/data/datasource/datasource.dart';
import '../../features/admin/neural_generator/data/repository_impl/repository_impl.dart';
import '../../features/admin/neural_generator/domain/repository/repository.dart';
import '../../features/admin/neural_generator/domain/usecase/usecase.dart';
import '../../features/admin/neural_generator/presentation/controller/cubit.dart';
import '../../features/admin/programs/data/datasource/datasource.dart';
import '../../features/admin/programs/data/repository_impl/repository_impl.dart';
import '../../features/admin/programs/domain/repository/repository.dart';
import '../../features/admin/programs/domain/usecase/usecase.dart';
import '../../features/admin/programs/presentation/controller/cubit.dart';
import '../../features/admin/semesters/data/datasource/datasource.dart';
import '../../features/admin/semesters/data/repository_impl/repository_impl.dart';
import '../../features/admin/semesters/domain/repository/repository.dart';
import '../../features/admin/semesters/domain/usecase/usecase.dart';
import '../../features/admin/semesters/presentation/controller/cubit.dart';
import '../../features/admin/student_enrollment/data/datasource/datasource.dart';
import '../../features/admin/student_enrollment/data/repository_impl/repository_impl.dart';
import '../../features/admin/student_enrollment/domain/repository/repository.dart';
import '../../features/admin/student_enrollment/domain/usecase/usecase.dart';
import '../../features/admin/student_enrollment/presentation/controller/cubit.dart';
import '../../features/admin/student_registrations/data/datasource/datasource.dart';
import '../../features/admin/student_registrations/data/repository_impl/repository_impl.dart';
import '../../features/admin/student_registrations/domain/repository/repository.dart';
import '../../features/admin/student_registrations/domain/usecase/usecase.dart';
import '../../features/admin/student_registrations/presentation/controller/cubit.dart';
import '../../features/admin/teacher_allocation/data/datasource/datasource.dart';
import '../../features/admin/teacher_allocation/data/repository_impl/repository_impl.dart';
import '../../features/admin/teacher_allocation/domain/repository/repository.dart';
import '../../features/admin/teacher_allocation/domain/usecase/usecase.dart';
import '../../features/admin/teacher_allocation/presentation/controller/cubit.dart';
import '../../features/admin/teacher_attendance/data/datasource/datasource.dart';
import '../../features/admin/teacher_attendance/data/repository_impl/repository_impl.dart';
import '../../features/admin/teacher_attendance/domain/repository/repository.dart';
import '../../features/admin/teacher_attendance/domain/usecase/usecase.dart';
import '../../features/admin/teacher_attendance/presentation/controller/cubit.dart';
import '../../features/admin/teacher_records/data/datasource/datasource.dart';
import '../../features/admin/teacher_records/data/repository_impl/repository_impl.dart';
import '../../features/admin/teacher_records/domain/repository/repository.dart';
import '../../features/admin/teacher_records/domain/usecase/usecase.dart';
import '../../features/admin/teacher_records/presentation/controller/cubit.dart';
import '../../features/admin/timetable_manager/data/datasource/datasource.dart';
import '../../features/admin/timetable_manager/data/repository_impl/repository_impl.dart';
import '../../features/admin/timetable_manager/domain/repository/repository.dart';
import '../../features/admin/timetable_manager/domain/usecase/usecase.dart';
import '../../features/admin/timetable_manager/presentation/controller/cubit.dart';
import '../../features/admin/university_profile/data/datasource/datasource.dart';
import '../../features/admin/university_profile/data/repository_impl/repository_impl.dart';
import '../../features/admin/university_profile/domain/repository/repository.dart';
import '../../features/admin/university_profile/domain/usecase/usecase.dart';
import '../../features/admin/university_profile/presentation/controller/cubit.dart';
import '../domain/connectivity/presentaion/connectivity_controller.dart';


class DiContainer{
 final sl=GetIt.instance;

  Future<void> init()async{
    WidgetsFlutterBinding.ensureInitialized();
    // sl.registerLazySingleton(() => LocalizationGetx(),);
    await executeFirstTime();
    cubits();
    sl<AuthenticationCubit>().initFunction();
  }

  Future<void> executeFirstTime()async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    //// internet connection
    sl.registerLazySingleton<DataSourceConnection>(() => CheckInternetClassConnection(),);
    sl.registerLazySingleton<RepositoryConnection>(() => ConnectionImpl(dataSourceConnection: sl()),);
    sl.registerLazySingleton(() => UseCaseConnection(repository: sl()),);



    // //// student dashboard
    sl.registerLazySingleton<UniversityProfileDataSource>(() => FunctionClassUniversityProfile(),);
    sl.registerLazySingleton<UniversityProfileRepository>(() => UniversityProfileRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => UniversityProfileUseCase(repository: sl()),);


    // authentications
    sl.registerLazySingleton<AuthenticationDataSource>(() => FunctionClassAuthentication(),);
    sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => AuthenticationUseCase(repository: sl()),);


    // admin department
    sl.registerLazySingleton<AdminDepartmentDataSource>(() => FunctionClassAdminDepartment(),);
    sl.registerLazySingleton<AdminDepartmentRepository>(() => AdminDepartmentRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => AdminDepartmentUseCase(repository: sl()),);


    // admin programs
    sl.registerLazySingleton<AdminProgramsDataSource>(() => FunctionClassAdminPrograms(),);
    sl.registerLazySingleton<AdminProgramsRepository>(() => AdminProgramsRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => AdminProgramsUseCase(repository: sl()),);

    // admin course catalog
    sl.registerLazySingleton<CourseCatalogAdminDataSource>(() => FunctionClassCourseCatalogAdmin(),);
    sl.registerLazySingleton<CourseCatalogAdminRepository>(() => CourseCatalogAdminRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => CourseCatalogAdminUseCase(repository: sl()),);


    // admin semester
    sl.registerLazySingleton<SemesterAdminDataSource>(() => FunctionClassSemesterAdmin(),);
    sl.registerLazySingleton<SemesterAdminRepository>(() => SemesterAdminRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => SemesterAdminUseCase(repository: sl()),);

    // admin course mapping
    sl.registerLazySingleton<CourseMappingDataSource>(() => FunctionClassCourseMapping(),);
    sl.registerLazySingleton<CourseMappingRepository>(() => CourseMappingRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => CourseMappingUseCase(repository: sl()),);


    // admin teacher records
    sl.registerLazySingleton<TeacherRecordsDataSource>(() => FunctionClassTeacherRecords(),);
    sl.registerLazySingleton<TeacherRecordsRepository>(() => TeacherRecordsRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => TeacherRecordsUseCase(repository: sl()),);

    // admin teacher allocation
    sl.registerLazySingleton<TeacherAllocationDataSource>(() => FunctionClassTeacherAllocation(),);
    sl.registerLazySingleton<TeacherAllocationRepository>(() => TeacherAllocationRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => TeacherAllocationUseCase(repository: sl()),);

    // admin announcement
    sl.registerLazySingleton<AnnouncementsDataSource>(() => FunctionClassAnnouncements(),);
    sl.registerLazySingleton<AnnouncementsRepository>(() => AnnouncementsRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => AnnouncementsUseCase(repository: sl()),);

    // hod assignment
    sl.registerLazySingleton<HODAssignmentDataSource>(() => FunctionClassHODAssignment(),);
    sl.registerLazySingleton<HODAssignmentRepository>(() => HODAssignmentRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => HODAssignmentUseCase(repository: sl()),);

    // Timetable Manager
    sl.registerLazySingleton<TimetableManagerDataSource>(() => FunctionClassTimetableManager(),);
    sl.registerLazySingleton<TimetableManagerRepository>(() => TimetableManagerRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => TimetableManagerUseCase(repository: sl()),);


    // access generate
    sl.registerLazySingleton<NeuralGeneratorDataSource>(() => FunctionClassNeuralGenerator(),);
    sl.registerLazySingleton<NeuralGeneratorRepository>(() => NeuralGeneratorRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => NeuralGeneratorUseCase(repository: sl()),);


    // Timetable Manager
    sl.registerLazySingleton<TeacherAttendanceDataSource>(() => FunctionClassTeacherAttendance(),);
    sl.registerLazySingleton<TeacherAttendanceRepository>(() => TeacherAttendanceRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => TeacherAttendanceUseCase(repository: sl()),);


    // student registration
    sl.registerLazySingleton<StudentRegistrationDataSource>(() => FunctionClassStudentRegistration(),);
    sl.registerLazySingleton<StudentRegistrationRepository>(() => StudentRegistrationRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => StudentRegistrationUseCase(repository: sl()),);

    // Student Enrollment
    sl.registerLazySingleton<StudentEnrollmentDataSource>(() => FunctionClassStudentEnrollment(),);
    sl.registerLazySingleton<StudentEnrollmentRepository>(() => StudentEnrollmentRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => StudentEnrollmentUseCase(repository: sl()),);

    // coordinator management
    sl.registerLazySingleton<CoordinatorManagementDataSource>(() => FunctionClassCoordinatorManagement(),);
    sl.registerLazySingleton<CoordinatorManagementRepository>(() => CoordinatorManagementRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => CoordinatorManagementUseCase(repository: sl()),);


    // coordinator management
    sl.registerLazySingleton<FacultyWorkLoadDataSource>(() => FunctionClassFacultyWorkLoad(),);
    sl.registerLazySingleton<FacultyWorkLoadRepository>(() => FacultyWorkLoadRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => FacultyWorkLoadUseCase(repository: sl()),);


    // leave request
    sl.registerLazySingleton<LeaveRequestDataSource>(() => FunctionClassLeaveRequest(),);
    sl.registerLazySingleton<LeaveRequestRepository>(() => LeaveRequestRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => LeaveRequestUseCase(repository: sl()),);

    // freeze
    sl.registerLazySingleton<FreezUnFreezDataSource>(() => FunctionClassFreezUnFreez(),);
    sl.registerLazySingleton<FreezUnFreezRepository>(() => FreezUnFreezRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => FreezUnFreezUseCase(repository: sl()),);

    // marking
    sl.registerLazySingleton<MarkingStudentDataSource>(() => FunctionClassMarkingStudent(),);
    sl.registerLazySingleton<MarkingStudentRepository>(() => MarkingStudentRepositoryImpl(dataSource: sl()),);
    sl.registerLazySingleton(() => MarkingStudentUseCase(repository: sl()),);


    ConnectivityController().init();
    await sl.allReady();
  }

  //// cubits
  void cubits()async{
    sl.registerLazySingleton(() => UniversityProfileCubit(sl()),);
    sl.registerLazySingleton(() => AuthenticationCubit(sl()),);
    sl.registerLazySingleton(() => AdminDepartmentCubit(sl()),);
    sl.registerLazySingleton(() => AdminProgramsCubit(sl()),);
    sl.registerLazySingleton(() => CourseCatalogAdminCubit(sl()),);
    sl.registerLazySingleton(() => SemesterAdminCubit(sl()),);
    sl.registerLazySingleton(() => CourseMappingCubit(sl()),);
    sl.registerLazySingleton(() => TeacherRecordsCubit(sl()),);
    sl.registerLazySingleton(() => TeacherAllocationCubit(sl()),);
    sl.registerLazySingleton(() => AnnouncementsCubit(sl()),);
    sl.registerLazySingleton(() => HODAssignmentCubit(sl()),);
    sl.registerLazySingleton(() => TimetableManagerCubit(sl()),);
    sl.registerLazySingleton(() => NeuralGeneratorCubit(sl()),);
    sl.registerLazySingleton(() => TeacherAttendanceCubit(sl()),);
    sl.registerLazySingleton(() => StudentRegistrationCubit(sl()),);
    sl.registerLazySingleton(() => StudentEnrollmentCubit(sl()),);
    sl.registerLazySingleton(() => CoordinatorManagementCubit(sl()),);
    sl.registerLazySingleton(() => FacultyWorkLoadCubit(sl()),);
    sl.registerLazySingleton(() => LeaveRequestCubit(sl()),);
    sl.registerLazySingleton(() => FreezUnFreezCubit(sl()),);
    sl.registerLazySingleton(() => MarkingStudentCubit(sl()),);

    sl.registerLazySingleton(() => ScreenResizeCubit(),);
  }

}