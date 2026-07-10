import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/helper/key_generator/time_table_slot_key_generator.dart';
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
        Expanded(child: StatCardWidget(title: "Total", color: AppColor.blue, value:_teacherAttendanceCubit.filterList
            .where(
              (element) =>
          !_teacherAttendanceCubit.isHistory? (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
              _teacherAttendanceCubit.departmentFilter:true) && (isTimeInSlot(element.slotTime??"00:00-00:00",TimeOfDay.now()) && isToday(element.date!, DateTime.now())): (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
              _teacherAttendanceCubit.departmentFilter:true) &&
              (_teacherAttendanceCubit
                  .teacherFilterName !=
                  "All Teacher"
                  ? element.teacher ==
                  _teacherAttendanceCubit
                      .teacherFilterName
                  : true) &&
              (_teacherAttendanceCubit
                  .historyFilterType !=
                  "All"
                  ? _teacherAttendanceCubit
                  .historyFilterType ==
                  "Daily"
                  ? element.date ==
                  _teacherAttendanceCubit
                      .historyFilterDate
                  : (element.month != null
                  ? element.month!.month ==
                  _teacherAttendanceCubit
                      .historyFilterDate
                      .month &&
                  element.month!.year ==
                      _teacherAttendanceCubit
                          .historyFilterDate
                          .year
                  : true)
                  : true),
        )
            .toList().length.toString())),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Present", color: AppColor.green, value:"${_teacherAttendanceCubit.filterList
            .where(
              (element) =>
          !_teacherAttendanceCubit.isHistory? (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
              _teacherAttendanceCubit.departmentFilter:true) && (isTimeInSlot(element.slotTime??"00:00-00:00",TimeOfDay.now()) && isToday(element.date!, DateTime.now())): (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
              _teacherAttendanceCubit.departmentFilter:true) &&
              (_teacherAttendanceCubit
                  .teacherFilterName !=
                  "All Teacher"
                  ? element.teacher ==
                  _teacherAttendanceCubit
                      .teacherFilterName
                  : true) &&
              (_teacherAttendanceCubit
                  .historyFilterType !=
                  "All"
                  ? _teacherAttendanceCubit
                  .historyFilterType ==
                  "Daily"
                  ? element.date ==
                  _teacherAttendanceCubit
                      .historyFilterDate
                  : (element.month != null
                  ? element.month!.month ==
                  _teacherAttendanceCubit
                      .historyFilterDate
                      .month &&
                  element.month!.year ==
                      _teacherAttendanceCubit
                          .historyFilterDate
                          .year
                  : true)
                  : true),
        )
            .toList().where((element) => element.status=="Present",).length}")),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Absent", color: AppColor.red, value:"${_teacherAttendanceCubit.filterList
            .where(
              (element) =>
          !_teacherAttendanceCubit.isHistory? (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
              _teacherAttendanceCubit.departmentFilter:true) && (isTimeInSlot(element.slotTime??"00:00-00:00",TimeOfDay.now()) && isToday(element.date!, DateTime.now())): (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
              _teacherAttendanceCubit.departmentFilter:true) &&
              (_teacherAttendanceCubit
                  .teacherFilterName !=
                  "All Teacher"
                  ? element.teacher ==
                  _teacherAttendanceCubit
                      .teacherFilterName
                  : true) &&
              (_teacherAttendanceCubit
                  .historyFilterType !=
                  "All"
                  ? _teacherAttendanceCubit
                  .historyFilterType ==
                  "Daily"
                  ? element.date ==
                  _teacherAttendanceCubit
                      .historyFilterDate
                  : (element.month != null
                  ? element.month!.month ==
                  _teacherAttendanceCubit
                      .historyFilterDate
                      .month &&
                  element.month!.year ==
                      _teacherAttendanceCubit
                          .historyFilterDate
                          .year
                  : true)
                  : true),
        )
            .toList().where((element) => element.status=="Absent",).length}")),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Others", color: AppColor.purple, value:"${_teacherAttendanceCubit.filterList
            .where(
              (element) =>
          !_teacherAttendanceCubit.isHistory? (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
              _teacherAttendanceCubit.departmentFilter:true) && (isTimeInSlot(element.slotTime??"00:00-00:00",TimeOfDay.now()) && isToday(element.date!, DateTime.now())): (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
              _teacherAttendanceCubit.departmentFilter:true) &&
              (_teacherAttendanceCubit
                  .teacherFilterName !=
                  "All Teacher"
                  ? element.teacher ==
                  _teacherAttendanceCubit
                      .teacherFilterName
                  : true) &&
              (_teacherAttendanceCubit
                  .historyFilterType !=
                  "All"
                  ? _teacherAttendanceCubit
                  .historyFilterType ==
                  "Daily"
                  ? element.date ==
                  _teacherAttendanceCubit
                      .historyFilterDate
                  : (element.month != null
                  ? element.month!.month ==
                  _teacherAttendanceCubit
                      .historyFilterDate
                      .month &&
                  element.month!.year ==
                      _teacherAttendanceCubit
                          .historyFilterDate
                          .year
                  : true)
                  : true),
        )
            .toList().where((element) => element.status!="Present" || element.status=="Absent",).length}")),
      ],
    );
  }
}
