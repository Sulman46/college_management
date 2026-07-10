import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/helper/key_generator/time_table_slot_key_generator.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_attendance_admin_header.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_attendance_stats_section.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_attendance_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import '../widgets/filter_teacher_attendance.dart';

class TeacherAttendanceAdminScreen extends StatefulWidget {
  const TeacherAttendanceAdminScreen({super.key});

  @override
  State<TeacherAttendanceAdminScreen> createState() =>
      _TeacherAttendanceAdminScreenState();
}

class _TeacherAttendanceAdminScreenState
    extends State<TeacherAttendanceAdminScreen> {
  final _teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _teacherAttendanceCubit.getDepartmentFilterValue("");
      if(_authCubit.userModel!.role==UserRole.admin){
        _teacherAttendanceCubit.getTabVal(true);
      }else{
        _teacherAttendanceCubit.getTabVal(false);

      }
      await _teacherAttendanceCubit.get();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TeacherAttendanceAdminHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
              child: BlocBuilder(
                bloc: _teacherAttendanceCubit,
                builder: (context, statevakb) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      FilterTeacherAttendance(),
                      SizedBox(height: 10),
                      TeacherAttendanceStatsSection(),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Ongoing Classes",
                            fontSize: 13,
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                          InkWell(
                            onTap: () async {
                              await _teacherAttendanceCubit.get();
                            },
                            child: Icon(Icons.refresh, size: 20,color: AppColor.white,),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (_teacherAttendanceCubit.filterList
                          .where(
                            (element) =>
                            !_teacherAttendanceCubit.isHistory? (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
                                _teacherAttendanceCubit.departmentFilter:true) && (isTimeInSlot(element.slotTime??"00:00-00:00",TimeOfDay.now()) && isToday(element.date!, DateTime.now())):  (_teacherAttendanceCubit.departmentFilter!=""?element.department ==
                                    _teacherAttendanceCubit.departmentFilter:true) &&
                                (_teacherAttendanceCubit.teacherFilterName !=
                                        "All Teacher"
                                    ? element.teacher ==
                                          _teacherAttendanceCubit
                                              .teacherFilterName
                                    : true) &&
                                (_teacherAttendanceCubit.historyFilterType !=
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
                          .isNotEmpty)
                        ...List.generate(
                          _teacherAttendanceCubit.filterList
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
                              .length,
                          (index) {
                            return TeacherAttendanceWidget(
                              model:
                              _teacherAttendanceCubit.filterList
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
                                      .toList()[index],
                            );
                          },
                        )
                      else
                        DataNotFoundWidget(
                          onTap: () async {
                            await _teacherAttendanceCubit.get();
                          },
                        ),
                      SizedBox(height: 15),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _authCubit=DiContainer().sl<AuthenticationCubit>();
