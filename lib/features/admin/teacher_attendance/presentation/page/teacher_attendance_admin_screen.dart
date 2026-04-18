import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/faculty_workload/presentation/widgets/stat_card_widget.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_attendance_admin_header.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_attendance_stats_section.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_attendance_tab_button.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/add_sheet.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/time_table_sheet_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

import '../widgets/filter_teacher_attendance.dart';


class TeacherAttendanceAdminScreen extends StatefulWidget {
  const TeacherAttendanceAdminScreen({super.key});

  @override
  State<TeacherAttendanceAdminScreen> createState() => _TeacherAttendanceAdminScreenState();
}

class _TeacherAttendanceAdminScreenState extends State<TeacherAttendanceAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TeacherAttendanceAdminHeader(),
          SliverToBoxAdapter(child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: screenPaddingHori,),
            child: Column(
              children: [
                SizedBox(height: 10,),
                FilterTeacherAttendance(),
                SizedBox(height: 10,),
                TeacherAttendanceStatsSection(),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(text: "Ongoing Classes",fontSize: 13,color: AppColor.black,fontWeight: FontWeight.w600,),
                    Icon(Icons.refresh,size: 20,)
                  ],
                ),
                SizedBox(height: 15,),

              ],
            ),
          ),)
        ],
      ),
    );
  }
}
