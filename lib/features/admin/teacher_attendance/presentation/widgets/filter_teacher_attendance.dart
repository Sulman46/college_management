import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/widgets/teacher_department_filter_widget.dart';
import 'package:college_management/features/admin/teacher_records/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/app_date_picker.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class FilterTeacherAttendance extends StatefulWidget {
  const FilterTeacherAttendance({super.key});

  @override
  State<FilterTeacherAttendance> createState() =>
      _FilterTeacherAttendanceState();
}

class _FilterTeacherAttendanceState extends State<FilterTeacherAttendance> {
  final _teacherCubit = DiContainer().sl<TeacherRecordsCubit>();
  final _departmentCubit = DiContainer().sl<AdminDepartmentCubit>();
  final _teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: BlocBuilder(
        bloc: _teacherAttendanceCubit,
        builder: (context, statebkca) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder(
                      bloc: _departmentCubit,
                      builder: (context, statevbu) {
                        List<String> departmentList = List.from(
                          _departmentCubit.departmentList.map((e) => e.name),
                        );
                        departmentList.add("All Departments");
                        return _departmentCubit.departmentList.isNotEmpty
                            ? CustomPopMenuButton(
                                onSelected: (p0) {
                                  _teacherAttendanceCubit
                                      .getDepartmentFilterValue(
                                        departmentList[p0],
                                      );
                                },
                                menus: departmentList,
                                widget: TeacherDepartmentFilterWidget(
                                  text: _teacherAttendanceCubit
                                      .selectedDepartment,
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  await _departmentCubit.getDepartments();
                                },
                                child: TeacherDepartmentFilterWidget(
                                  text: _teacherAttendanceCubit
                                      .selectedDepartment,
                                ),
                              );
                      },
                    ),
                  ),
                  if (_teacherAttendanceCubit.isHistory) ...[
                    SizedBox(width: 5),
                    Expanded(
                      child: BlocBuilder(
                        bloc: _teacherCubit,
                        builder: (context, statevbu) {
                          List<String> departmentList = List.from(
                            _teacherCubit.teacherList.map((e) => e.teacherName),
                          );
                          departmentList.add("All Teacher");
                          return _teacherCubit.teacherList.isNotEmpty
                              ? CustomPopMenuButton(
                            onSelected: (p0) {

                              _teacherAttendanceCubit.getFilterHistory(
                                  _teacherAttendanceCubit.historyFilterType,
                                  _teacherAttendanceCubit.historyFilterDate,
                                  departmentList[p0]);
                            },
                            menus: departmentList,
                            widget: TeacherDepartmentFilterWidget(
                              text: _teacherAttendanceCubit
                                  .teacherFilterName,
                            ),
                          )
                              : InkWell(
                            onTap: () async {
                              await _teacherCubit.getTeachers();
                            },
                            child: TeacherDepartmentFilterWidget(
                              text: _teacherAttendanceCubit
                                  .teacherFilterName,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: CustomPopMenuButton(
                        onSelected: (p0) {
                          _teacherAttendanceCubit.getFilterHistory(
                            ConstantData.filterTeacherAttendanceRecord[p0],
                            _teacherAttendanceCubit.historyFilterDate,
                            _teacherAttendanceCubit.teacherFilterName
                          );
                        },
                        menus: ConstantData.filterTeacherAttendanceRecord,
                        widget: TeacherDepartmentFilterWidget(
                          text: _teacherAttendanceCubit.historyFilterType,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          DateTime? val = await AppDatePicker.pickCustomDate(
                            context: context,
                            initialDate:_teacherAttendanceCubit.historyFilterDate,
                            lastDate: DateTime(3000),
                            firstDate: DateTime(2000),
                          );
                          if (val != null) {
                            _teacherAttendanceCubit.getFilterHistory(
                                _teacherAttendanceCubit.historyFilterType,
                                val,
                                _teacherAttendanceCubit.teacherFilterName
                            );
                          }                        },
                        child: TeacherDepartmentFilterWidget(
                          text: DateToStringHelper.dateMonthYearConvert(
                            _teacherAttendanceCubit.historyFilterDate,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
