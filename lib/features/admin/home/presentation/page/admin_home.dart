import 'dart:async';

import 'package:college_management/features/admin/home/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/home/presentation/widgets/dashboard_overview_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../freez_unfreez_admin/presentation/page/freeze_unfreeze_screen.dart';
import '../../../student_registrations/presentation/page/registered_student_list_screen.dart';
import '../../../teacher_attendance/presentation/page/teacher_attendance_admin_screen.dart';
import '../../../teacher_records/presentation/page/teacher_records_admin_screen.dart';
import '../../../timetable_manager/presentation/page/timetable_manager_screen.dart';
import '../widgets/admin_welcome_header.dart';
import '../widgets/home_cards_widget.dart';
import '../widgets/quick_action_card.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  var _dashboardCubit=DiContainer().sl<AdminHomeCubit>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(Duration(seconds: 2)).then((value)async {
        await _dashboardCubit.get();
      },);
      _timer = Timer.periodic(const Duration(seconds: 30), (_) async {
        if (!mounted) return;
        await _dashboardCubit.get();
      });
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder(
          bloc: _dashboardCubit,
          builder: (context,statekae) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [

                /// Welcome Header
                WelcomeHeaderWidget(),

                SizedBox(height: 15),


                AppText(
                  text: "Overview",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColor.greyLight,
                ),

                SizedBox(height: 14),

                OverviewSliderWidget(dashboardWidget: _dashboardCubit.dashboardModel,),

                SizedBox(height: 15),

                AppText(
                  text: "Quick Actions",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColor.greyLight,
                ),

                SizedBox(height: 14),
                HomeCardsWidget(title: "Department", icon:  Icons.category, onTap: () {
                  context.push("/Admin-department");

                },),
                SizedBox(height: 10,),
                HomeCardsWidget(title: "Teachers", icon:  Icons.list_alt_sharp, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeacherRecordsAdminScreen()),
                  );
                },),
                SizedBox(height: 10,),
                HomeCardsWidget(title: "Students", icon:  Icons.boy, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisteredStudentListScreen()),
                  );
                },),

                SizedBox(height: 10,),
                HomeCardsWidget(title: "Timetable", icon:  Icons.calendar_month, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimetableManagerScreen()),
                  );
                },),

                SizedBox(height: 10,),
                HomeCardsWidget(title: "Teachers Attendance", icon:  Icons.edit_calendar, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeacherAttendanceAdminScreen()),
                  );
                },),
                SafeArea(child: SizedBox(height: 10,)),

              ],
            );
          }
        ),
      ),
    );
  }
}