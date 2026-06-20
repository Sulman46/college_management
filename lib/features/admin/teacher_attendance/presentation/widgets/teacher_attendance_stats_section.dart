import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../faculty_workload/presentation/widgets/stat_card_widget.dart';
import '../controller/cubit.dart';

class TeacherAttendanceStatsSection extends StatefulWidget {
  const TeacherAttendanceStatsSection({super.key});

  @override
  State<TeacherAttendanceStatsSection> createState() => _TeacherAttendanceStatsSectionState();
}

class _TeacherAttendanceStatsSectionState extends State<TeacherAttendanceStatsSection> {
  final _teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: StatCardWidget(title: "Total", color: AppColor.blue, value:_teacherAttendanceCubit.dataList.length.toString())),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Present", color: AppColor.green, value:"${_teacherAttendanceCubit.dataList.where((element) => element.status=="Present",).length}")),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Absent", color: AppColor.red, value:"${_teacherAttendanceCubit.dataList.where((element) => element.status=="Absent",).length}")),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Late/Early", color: AppColor.purple, value:"${_teacherAttendanceCubit.dataList.where((element) => element.status=="Late" || element.status=="Early Left",).length}")),
      ],
    );
  }
}
