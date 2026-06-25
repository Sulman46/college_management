import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/timetable_manager/models/time_table_manger_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/controller/cubit.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/app_date_picker.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_button.dart';

class AddSheet extends StatefulWidget {
  AddSheet({super.key, this.timeModel});
  TimeTableManagerModel? timeModel;
  @override
  State<AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<AddSheet> {
  final _timeTableManagerCubit = DiContainer().sl<TimetableManagerCubit>();
  final _semesterCubit = DiContainer().sl<SemesterAdminCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.timeModel != null) {
        /// todo
        // _timeTableManagerCubit.getTimeTableManagerModel(widget.timeModel!);
      } else {
        _timeTableManagerCubit.getTimeTableManagerModel(
          TimeTableGetDataModel(),
        );
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _timeTableManagerCubit,
      builder: (context, statebskj) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: widget.timeModel == null
                    ? "New Timetable Sheet"
                    : "Update Timetable Sheet",
                fontSize: 15,
                color: AppColor.primary,
              ),
              SizedBox(height: 10),
              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, staetsbkn) {
                  return _semesterCubit.activeSemesterList.isNotEmpty
                      ? CustomPopMenuButton(
                          menus: _semesterCubit.activeSemesterList
                              .map((e) => e.programModel?.affiliationName ?? "")
                              .toSet()
                              .toList(),
                          onSelected: (p0) {
                            _timeTableManagerCubit.getTimeTableManagerModel(
                              TimeTableGetDataModel(
                                affiliation: _semesterCubit.activeSemesterList
                                    .map(
                                      (e) =>
                                          e.programModel?.affiliationName ?? "",
                                    )
                                    .toSet()
                                    .toList()[p0],),
                            );
                          },
                          title: "Affiliation",
                          widget: DropDownFieldWidget(
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .affiliation ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .affiliation !=
                                null,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await _semesterCubit.getSemesterList();
                          },
                          child: DropDownFieldWidget(
                            title: "Affiliation",
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .affiliation ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .affiliation !=
                                null,
                          ),
                        );
                },
              ),
              SizedBox(height: 10),
              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, staetsbkn) {
                  return _semesterCubit.activeSemesterList.isNotEmpty
                      ? CustomPopMenuButton(
                          menus: _semesterCubit.activeSemesterList
                              .where(
                                (element) =>
                                    element.programModel?.affiliationName ==
                                    _timeTableManagerCubit
                                        .addTimeTableManagerModel
                                        .affiliation,
                              )
                              .map((e) => e.programModel?.departmentName ?? "")
                              .toSet()
                              .toList(),
                          onSelected: (p0) {
                            _timeTableManagerCubit.getTimeTableManagerModel(
                              _timeTableManagerCubit.addTimeTableManagerModel.copyWith(department: _semesterCubit.activeSemesterList
                                  .where(
                                    (element) =>
                                element
                                    .programModel
                                    ?.affiliationName ==
                                    _timeTableManagerCubit
                                        .addTimeTableManagerModel
                                        .affiliation,
                              )
                                  .map(
                                    (e) =>
                                e.programModel?.departmentName ?? "",
                              )
                                  .toSet()
                                  .toList()[p0]).resetAfterDepartment()

                            );
                          },
                          title: "Department",
                          widget: DropDownFieldWidget(
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .department ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .department !=
                                null,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await _semesterCubit.getSemesterList();
                          },
                          child: DropDownFieldWidget(
                            title: "Department",
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .department ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .department !=
                                null,
                          ),
                        );
                },
              ),
              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, statebka) {
                  return _semesterCubit.activeSemesterList.isNotEmpty
                      ? CustomPopMenuButton(
                          menus: _semesterCubit.activeSemesterList
                              .where(
                                (element) =>
                                    element.programModel?.affiliationName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .affiliation &&
                                    element.programModel!.departmentName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .department,
                              )
                              .map((e) => e.programModel?.name ?? "")
                              .toSet()
                              .toList(),
                          onSelected: (p0) {
                            _timeTableManagerCubit.getTimeTableManagerModel(
                              _timeTableManagerCubit.addTimeTableManagerModel.copyWith(
                                programName:  _semesterCubit.activeSemesterList
                                    .where(
                                      (element) =>
                                  element
                                      .programModel
                                      ?.affiliationName ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .affiliation &&
                                      element.programModel!.departmentName ==
                                          _timeTableManagerCubit
                                              .addTimeTableManagerModel
                                              .department,
                                )
                                    .map((e) => e.programModel?.name ?? "")
                                    .toSet()
                                    .toList()[p0]).resetAfterProgram(),
                            );
                          },
                          title: "Program",
                          widget: DropDownFieldWidget(
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .programName ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .programName !=
                                null,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await _semesterCubit.getSemesterList();
                          },
                          child: DropDownFieldWidget(
                            title: "Program",
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .programName ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .programName !=
                                null,
                          ),
                        );
                },
              ),
              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, statebka) {
                  return _semesterCubit.activeSemesterList.isNotEmpty
                      ? CustomPopMenuButton(
                          menus: _semesterCubit.activeSemesterList
                              .where(
                                (element) =>
                                    element.programModel?.affiliationName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .affiliation &&
                                    element.programModel!.departmentName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .department &&
                                    element.programModel!.name ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .programName,
                              )
                              .map((e) => e.programModel?.degree ?? "")
                              .toSet()
                              .toList(),
                          onSelected: (p0) {
                            _timeTableManagerCubit.getTimeTableManagerModel(
                              _timeTableManagerCubit.addTimeTableManagerModel.copyWith(
                                degree: _semesterCubit.activeSemesterList
                                    .where(
                                      (element) =>
                                          element
                                                  .programModel
                                                  ?.affiliationName ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .affiliation &&
                                          element.programModel!.departmentName ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .department &&
                                          element.programModel!.name ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .programName,
                                    )
                                    .map((e) => e.programModel?.degree ?? "")
                                    .toSet()
                                    .toList()[p0],
                              ).resetAfterDegree(),
                            );
                          },
                          title: "Degree",
                          widget: DropDownFieldWidget(
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .degree ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .degree !=
                                null,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await _semesterCubit.getSemesterList();
                          },
                          child: DropDownFieldWidget(
                            title: "Degree",
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .degree ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .degree !=
                                null,
                          ),
                        );
                },
              ),

              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, statebskn) {
                  return _semesterCubit.activeSemesterList.isNotEmpty
                      ? CustomPopMenuButton(
                          menus: _semesterCubit.activeSemesterList
                              .where(
                                (element) =>
                                    element.programModel?.affiliationName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .affiliation &&
                                    element.programModel!.departmentName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .department &&
                                    element.programModel!.name ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .programName &&
                                    element.programModel!.degree ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .degree,
                              )
                              .map((e) => e.programModel!.section)
                              .toSet()
                              .toList(),
                          onSelected: (p0) {
                            _timeTableManagerCubit.getTimeTableManagerModel(
                              _timeTableManagerCubit.addTimeTableManagerModel.copyWith(
                                section: _semesterCubit.activeSemesterList
                                    .where(
                                      (element) =>
                                          element
                                                  .programModel
                                                  ?.affiliationName ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .affiliation &&
                                          element.programModel!.departmentName ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .department &&
                                          element.programModel!.name ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .programName &&
                                          element.programModel!.degree ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .degree,
                                    )
                                    .map((e) => e.programModel?.section ?? "")
                                    .toSet()
                                    .toList()[p0],
                              ).resetAfterSection(),
                            );
                          },
                          title: "Section",
                          widget: DropDownFieldWidget(
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .section ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .section !=
                                null,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await _semesterCubit.getSemesterList();
                          },
                          child: DropDownFieldWidget(
                            title: "Section",
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .section ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .section !=
                                null,
                          ),
                        );
                },
              ),
              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, staetsbkj) {
                  return _semesterCubit.activeSemesterList.isNotEmpty
                      ? CustomPopMenuButton(
                          menus: _semesterCubit.activeSemesterList
                              .where(
                                (element) =>
                                    element.programModel?.affiliationName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .affiliation &&
                                    element.programModel!.departmentName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .department &&
                                    element.programModel!.name ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .programName &&
                                    element.programModel!.degree ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .degree &&
                                    element.programModel!.section ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .section,
                              )
                              .map((e) => e.programModel!.session)
                              .toSet()
                              .toList(),
                          onSelected: (p0) {
                            _timeTableManagerCubit.getTimeTableManagerModel(
                              _timeTableManagerCubit.addTimeTableManagerModel.copyWith(

                                session: _semesterCubit.activeSemesterList
                                    .where(
                                      (element) =>
                                          element
                                                  .programModel
                                                  ?.affiliationName ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .affiliation &&
                                          element.programModel!.departmentName ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .department &&
                                          element.programModel!.name ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .programName &&
                                          element.programModel!.degree ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .degree &&
                                          element.programModel!.section ==
                                              _timeTableManagerCubit
                                                  .addTimeTableManagerModel
                                                  .section,
                                    )
                                    .map((e) => e.programModel?.session ?? "")
                                    .toSet()
                                    .toList()[p0],
                              ).resetAfterSession(),
                            );
                          },
                          title: "Session",
                          widget: DropDownFieldWidget(
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .session ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .session !=
                                null,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await _semesterCubit.getSemesterList();
                          },
                          child: DropDownFieldWidget(
                            title: "Session",
                            text:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .session ??
                                "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .session !=
                                null,
                          ),
                        );
                },
              ),
              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, statebska) {
                  return _semesterCubit.activeSemesterList.isNotEmpty
                      ? CustomPopMenuButton(
                          menus: _semesterCubit.activeSemesterList
                              .where(
                                (element) =>
                                    element.programModel?.affiliationName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .affiliation &&
                                    element.programModel!.departmentName ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .department &&
                                    element.programModel!.name ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .programName &&
                                    element.programModel!.degree ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .degree &&
                                    element.programModel!.section ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .section &&
                                    element.programModel!.session ==
                                        _timeTableManagerCubit
                                            .addTimeTableManagerModel
                                            .session,
                              )
                              .map((e) => e.semesterName ?? "")
                              .toSet()
                              .toList(),
                          onSelected: (p0) {
                            String semesterName=_semesterCubit.activeSemesterList
                                .where(
                                  (element) =>
                              element
                                  .programModel
                                  ?.affiliationName ==
                                  _timeTableManagerCubit
                                      .addTimeTableManagerModel
                                      .affiliation &&
                                  element.programModel!.departmentName ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .department &&
                                  element.programModel!.name ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .programName &&
                                  element.programModel!.degree ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .degree &&
                                  element.programModel!.section ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .section &&
                                  element.programModel!.session ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .session,
                            )
                                .map((e) => e.semesterName ?? "")
                                .toSet()
                                .toList()[p0];

                            var semesterModel=_semesterCubit.activeSemesterList
                                .where(
                                  (element) =>
                              element
                                  .programModel
                                  ?.affiliationName ==
                                  _timeTableManagerCubit
                                      .addTimeTableManagerModel
                                      .affiliation &&
                                  element.programModel!.departmentName ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .department &&
                                  element.programModel!.name ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .programName &&
                                  element.programModel!.degree ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .degree &&
                                  element.programModel!.section ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .section &&
                                  element.programModel!.session ==
                                      _timeTableManagerCubit
                                          .addTimeTableManagerModel
                                          .session&&
                                  element.semesterName ==
                                      semesterName,
                            )
                                .toList().first;


                            _timeTableManagerCubit.getTimeTableManagerModel(
                              _timeTableManagerCubit.addTimeTableManagerModel.copyWith(
                                semesterName: semesterModel.semesterName??"",
                                semesterId: semesterModel.id??"",
                                programId: semesterModel.programModel?.id??"",
                              ).resetAfterSemester(),
                            );
                          },
                          title: "Active Semester",
                          widget: DropDownFieldWidget(
                            text:
                                _timeTableManagerCubit
                                        .addTimeTableManagerModel
                                        .semesterName !=
                                    null
                                ? _timeTableManagerCubit
                                      .addTimeTableManagerModel
                                      .semesterName
                                      .toString()
                                : "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .semesterName !=
                                null,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await _semesterCubit.getSemesterList();
                          },
                          child: DropDownFieldWidget(
                            title: "Active Semester",
                            text:
                                _timeTableManagerCubit
                                        .addTimeTableManagerModel
                                        .semesterName !=
                                    null
                                ? _timeTableManagerCubit
                                      .addTimeTableManagerModel
                                      .semesterName
                                      .toString()
                                : "Select..",
                            isFilled:
                                _timeTableManagerCubit
                                    .addTimeTableManagerModel
                                    .semesterName !=
                                null,
                          ),
                        );
                },
              ),
              SizedBox(height: 10),

              InkWell(
                onTap: () async {
                  DateTime? val = await AppDatePicker.pickCustomDate(
                    context: context,
                    initialDate: DateTime.now(),
                    lastDate: DateTime(3000),
                    firstDate: DateTime(2000),
                  );
                  if (val != null) {
                    _timeTableManagerCubit.getTimeTableManagerModel(
                      _timeTableManagerCubit.addTimeTableManagerModel.copyWith(
                        wef: val,
                      ).resetAfterWef(),
                    );
                  }
                },
                child: DropDownFieldWidget(
                  text:
                      _timeTableManagerCubit.addTimeTableManagerModel.wef !=
                          null
                      ? DateToStringHelper.dateMonthYearConvert(
                          _timeTableManagerCubit
                              .addTimeTableManagerModel
                              .wef!,
                        )
                      : "Select..",
                  isFilled:
                      _timeTableManagerCubit.addTimeTableManagerModel.wef !=
                      null,
                  title: "W.E.F Date",
                ),
              ),
              SizedBox(height: 10),
              CustomPopMenuButton(
                menus: ["Morning", "Evening"],
                onSelected: (p0) {
                  _timeTableManagerCubit.getTimeTableManagerModel(
                    _timeTableManagerCubit.addTimeTableManagerModel.copyWith(shiftType: ["Morning", "Evening"][p0])
                  );
                },
                widget: DropDownFieldWidget(
                  text: _timeTableManagerCubit.addTimeTableManagerModel.shiftType ?? "Select..",
                  isFilled: _timeTableManagerCubit.addTimeTableManagerModel.shiftType != null,
                  title: "Shift type",
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      text: "Discard",
                      bgColor: AppColor.white,
                      textColor: AppColor.red,
                      borderColor: AppColor.red,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () async {
                        var model =
                            _timeTableManagerCubit.addTimeTableManagerModel;
                        if (_timeTableManagerCubit.addTimeTableManagerModel.shiftType == null ||
                            model.affiliation == null ||
                            model.department == null ||
                            model.programName == null ||
                            model.degree == null ||
                            model.section == null ||
                            model.session == null ||
                            model.wef == null ||
                            model.semesterName == null) {
                          showMessage("Please fill all fields", isError: true);
                          return;
                        }

                        TimeTableManagerModel timeTableModel=TimeTableManagerModel(shiftType:_timeTableManagerCubit.addTimeTableManagerModel.shiftType?.toLowerCase()??"",programModel: ProgramModel(id: _timeTableManagerCubit.addTimeTableManagerModel.programId),semesterModel: TimeTableSemesterModel(id: _timeTableManagerCubit.addTimeTableManagerModel.semesterId),wefDate: _timeTableManagerCubit.addTimeTableManagerModel.wef);
                        if (widget.timeModel == null) {
                          timeTableModel = timeTableModel.copyWith(
                            timeSlots:
                                _timeTableManagerCubit.addTimeTableManagerModel.shiftType!.toLowerCase() == "morning"
                                ? ConstantData.morningSlot
                                : ConstantData.eveningSlot,
                            data: {},
                          );
                          var response = await _timeTableManagerCubit.post(
                            timeTableModel,
                          );
                          if (response) {
                            await _timeTableManagerCubit.get();
                            Navigator.pop(context);
                          }
                        } else {
                          var val = widget.timeModel;
                          timeTableModel=timeTableModel.copyWith(
                              timeSlots:val?.timeSlots??[],
                            days: val?.days??[],
                                  data: val?.data??{},
                            id: val?.id??"",
                          );
                          var response = await _timeTableManagerCubit.update(
                            timeTableModel,
                          );
                          if (response) {
                            await _timeTableManagerCubit.get();
                            Navigator.pop(context);
                          }
                        }

                        // TODO: Submit logic
                      },
                      text: "Save",
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
