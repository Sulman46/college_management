import 'dart:developer';

import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_attendance/models/teacher_attendance_model.dart';
import 'package:college_management/features/admin/teacher_attendance/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';


class AddTeacherAttendanceScreen extends StatefulWidget {
  const AddTeacherAttendanceScreen({super.key});

  @override
  State<AddTeacherAttendanceScreen> createState() =>
      _AddTeacherAttendanceScreenState();
}

class _AddTeacherAttendanceScreenState
    extends State<AddTeacherAttendanceScreen> {
  final _timeTableCubit = DiContainer().sl<TimetableManagerCubit>();
  final _teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();
  final _authCubit = DiContainer().sl<AuthenticationCubit>();
  TextEditingController minuteLateController=TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel());
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
          bloc: _teacherAttendanceCubit,
          builder: (context,staevhk) {
            return Column(
              children: [
                CustomTopBar(text: "Manual Attendance Entry"),
                /// todo

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: screenPaddingHori,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        BlocBuilder(
                          bloc: _timeTableCubit,
                          builder: (context, statseba) {
                            return _timeTableCubit.dataList.isNotEmpty
                                ? CustomPopMenuButton(
                              menus: _timeTableCubit.dataList
                                  .map((e) => e.programModel?.affiliationName ?? "")
                                  .toSet()
                                  .toList(),
                              onSelected: (p0) {
                                String val = _timeTableCubit.dataList
                                    .map((e) => e.programModel?.affiliationName ?? "")
                                    .toSet().toList()[p0];
                                _teacherAttendanceCubit
                                    .getTeacherAttendanceModel(
                                  TeacherAttendanceModel(affiliation: val),
                                );
                              },
                              title: "Affiliation",
                              widget: DropDownFieldWidget(
                                text:
                                _teacherAttendanceCubit
                                    .teacherAttendanceModel
                                    .affiliation ??
                                    "Select..",
                                isFilled: _teacherAttendanceCubit
                                    .teacherAttendanceModel
                                    .affiliation!=null,
                              ),
                            )
                                : InkWell(
                              onTap: () async {
                                await _timeTableCubit.get();
                              },
                              child: DropDownFieldWidget(
                                title: "Affiliation",
                                text:
                                _teacherAttendanceCubit
                                    .teacherAttendanceModel
                                    .affiliation ??
                                    "Select..",
                                isFilled: _teacherAttendanceCubit
                                    .teacherAttendanceModel
                                    .affiliation!=null,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),

                        BlocBuilder(
                          bloc: _timeTableCubit,
                          builder: (context, statseba) {
                            return _timeTableCubit.dataList.isNotEmpty && _teacherAttendanceCubit.teacherAttendanceModel.affiliation!=null
                                ? CustomPopMenuButton(
                              menus: _timeTableCubit.dataList
                                  .where(
                                    (element) =>
                                element.programModel?.affiliationName ==
                                    _teacherAttendanceCubit
                                        .teacherAttendanceModel
                                        .affiliation,
                              )
                                  .map((e) => e.programModel?.department?.name ?? "")
                                  .toSet().toList(),
                              onSelected: (p0) {
                                String val=_timeTableCubit.dataList
                                    .where(
                                      (element) =>
                                  element.programModel?.affiliationName ==
                                      _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .affiliation,
                                )
                                    .map((e) => e.programModel?.department?.name ?? "")
                                    .toSet().toList()[p0];
                                _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel(affiliation:_teacherAttendanceCubit.teacherAttendanceModel.affiliation,department: val));

                              },
                              title: "Department",
                              widget: DropDownFieldWidget(
                                text:
                                _teacherAttendanceCubit
                                    .teacherAttendanceModel
                                    .department ??
                                    "Select..",
                                isFilled: _teacherAttendanceCubit
                                    .teacherAttendanceModel
                                    .department!=null,
                              ),
                            )
                                : InkWell(
                              onTap: () async {
                                if(_teacherAttendanceCubit.teacherAttendanceModel.affiliation!=null){
                                  await _timeTableCubit.get();
                                }
                              },
                              child: DropDownFieldWidget(
                                title: "Department",
                                text:
                                _teacherAttendanceCubit
                                    .teacherAttendanceModel
                                    .department ??
                                    "Select..",
                                isFilled: _teacherAttendanceCubit
                                    .teacherAttendanceModel
                                    .department!=null,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),

                        BlocBuilder(
                          bloc: _timeTableCubit,
                          builder: (context, statseba) {
                            return _timeTableCubit.dataList.isNotEmpty && _teacherAttendanceCubit.teacherAttendanceModel.department!=null
                                ? CustomPopMenuButton(
                              menus: _timeTableCubit.dataList
                                  .where(
                                    (element) =>
                                element.programModel?.affiliationName ==
                                    _teacherAttendanceCubit
                                        .teacherAttendanceModel
                                        .affiliation && element.programModel!.department!.name ==
                                    _teacherAttendanceCubit
                                        .teacherAttendanceModel
                                        .department ,
                              )
                                  .map((e) => e.programModel?.name??"")
                                  .toSet().toList(),
                              onSelected: (p0) {
                                String val=_timeTableCubit.dataList
                                    .where(
                                      (element) =>
                                  element.programModel?.affiliationName ==
                                      _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .affiliation && element.programModel!.department!.name ==
                                      _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .department ,
                                )
                                    .map((e) => e.programModel?.name??"")
                                    .toSet().toList()[p0];
                                var model=_teacherAttendanceCubit.teacherAttendanceModel;

                                /// todo this add only one program
                                List<String> combineProgramList=[];
                                combineProgramList.add(val);
                                _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel(affiliation:model.affiliation,department: model.department,combinedPrograms:combineProgramList));
                                // List<String> combineProgramList=model.combinedPrograms??[];
                                // combineProgramList.add(val);
                                // if(!combineProgramList.contains(val)){
                                //   combineProgramList.add(val);
                                //   _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel(affiliation:model.affiliation,department: model.department,combinedPrograms:combineProgramList));
                                // }

                              },
                              title: "Program",
                              widget: DropDownFieldWidget(
                                text:
                                _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!=null && _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!.isNotEmpty? _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms?.join(", ")??"":   "Select..",
                                isFilled: _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!=null && _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!.isNotEmpty,
                              ),
                            )
                                : InkWell(
                              onTap: () async {
                                if(_teacherAttendanceCubit.teacherAttendanceModel.department!=null){
                                  await _timeTableCubit.get();
                                }
                              },
                              child: DropDownFieldWidget(
                                title: "Program",
                                text:
                                _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!=null && _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!.isNotEmpty? _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms?.join(", ")??"":   "Select..",
                                isFilled: _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!=null && _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!.isNotEmpty,
                              ),
                            );
                          },
                        ),
                        // if(_teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!=null && _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!.isNotEmpty)
                        //   ...[SizedBox(height: 5),
                        //   Align(
                        //     alignment: AlignmentGeometry.centerLeft,
                        //     child: Wrap(
                        //       children: List.generate(_teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms?.length??0, (index) => CatalogDepartWidget(text: _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms![index], onTap: () {
                        //         List<String> list=List.from(_teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms??[]);
                        //         list.removeWhere((element) => element==_teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms![index],);
                        //        var model=_teacherAttendanceCubit.teacherAttendanceModel;
                        //         _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel(affiliation:model.affiliation,department: model.department,combinedPrograms:list));
                        //       },),),
                        //     ),
                        //   ),],
                        SizedBox(height: 10),

                        Row(
                          children: [
                            ///  degree
                            Expanded(
                              child: BlocBuilder(
                                bloc: _timeTableCubit,
                                builder: (context, statseba) {
                                  return _timeTableCubit.dataList.isNotEmpty && _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!=null && _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!.isNotEmpty
                                      ? CustomPopMenuButton(
                                    menus: _timeTableCubit.dataList
                                        .where(
                                            (element) =>
                                        element.programModel?.affiliationName ==
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .affiliation && element.programModel!.department!.name ==
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .department &&
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .combinedPrograms!.contains(element.programModel?.name??"")
                                    )
                                        .map((e) => e.programModel?.degree ?? "")
                                        .toSet().toList(),
                                    onSelected: (p0) {
                                      String val=_timeTableCubit.dataList
                                          .where(
                                            (element) =>
                                        element.programModel?.affiliationName ==
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .affiliation && element.programModel!.department!.name ==
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .department &&
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .combinedPrograms!.contains(element.programModel?.name??"") ,
                                      )
                                          .map((e) => e.programModel?.degree ?? "")
                                          .toSet().toList()[p0];
                                      var model=_teacherAttendanceCubit.teacherAttendanceModel;
                                      _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel(affiliation:model.affiliation,department: model.department,combinedPrograms:model.combinedPrograms,degree: val));

                                    },
                                    title: "Degree",
                                    widget: DropDownFieldWidget(
                                      text:
                                      _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .degree ??
                                          "Select..",
                                      isFilled: _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .degree!=null,
                                    ),
                                  )
                                      : InkWell(
                                    onTap: () async {
                                      if(_teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!=null && _teacherAttendanceCubit.teacherAttendanceModel.combinedPrograms!.isNotEmpty){
                                        await _timeTableCubit.get();
                                      }
                                    },
                                    child: DropDownFieldWidget(
                                      title: "Degree",
                                      text:
                                      _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .degree ??
                                          "Select..",
                                      isFilled: _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .degree!=null,
                                    ),
                                  );
                                },
                              ),
                            ),

                            /// section
                            SizedBox(width: 10),
                            Expanded(
                                child: BlocBuilder(
                                  bloc: _timeTableCubit,
                                  builder: (context, statseba) {
                                    return _timeTableCubit.dataList.isNotEmpty && _teacherAttendanceCubit.teacherAttendanceModel.degree!=null
                                        ? CustomPopMenuButton(
                                      menus: _timeTableCubit.dataList
                                          .where(
                                              (element) =>
                                          element.programModel?.affiliationName ==
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .affiliation && element.programModel!.department!.name ==
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .department &&
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .combinedPrograms!.contains(element.programModel?.name??"")
                                              && element.programModel?.degree==_teacherAttendanceCubit.teacherAttendanceModel.degree
                                      )
                                          .map((e) => e.programModel?.section ?? "").toSet()
                                          .toList(),
                                      onSelected: (p0) {
                                        String val=_timeTableCubit.dataList
                                            .where(
                                                (element) =>
                                            element.programModel?.affiliationName ==
                                                _teacherAttendanceCubit
                                                    .teacherAttendanceModel
                                                    .affiliation && element.programModel!.department!.name ==
                                                _teacherAttendanceCubit
                                                    .teacherAttendanceModel
                                                    .department &&
                                                _teacherAttendanceCubit
                                                    .teacherAttendanceModel
                                                    .combinedPrograms!.contains(element.programModel?.name??"")
                                                && element.programModel?.degree==_teacherAttendanceCubit.teacherAttendanceModel.degree
                                        )
                                            .map((e) => e.programModel?.section ?? "").toSet()
                                            .toList()[p0];
                                        var model=_teacherAttendanceCubit.teacherAttendanceModel;
                                        _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel(affiliation:model.affiliation,department: model.department,combinedPrograms:model.combinedPrograms,degree: model.degree,section: val));

                                      },
                                      title: "Section",
                                      widget: DropDownFieldWidget(
                                        text:
                                        _teacherAttendanceCubit
                                            .teacherAttendanceModel
                                            .section ??
                                            "Select..",
                                        isFilled: _teacherAttendanceCubit
                                            .teacherAttendanceModel
                                            .section!=null,
                                      ),
                                    )
                                        : InkWell(
                                      onTap: () async {
                                        if(_teacherAttendanceCubit.teacherAttendanceModel.degree!=null ){
                                          await _timeTableCubit.get();
                                        }
                                      },
                                      child: DropDownFieldWidget(
                                        title: "Section",
                                        text:
                                        _teacherAttendanceCubit
                                            .teacherAttendanceModel
                                            .section ??
                                            "Select..",
                                        isFilled: _teacherAttendanceCubit
                                            .teacherAttendanceModel
                                            .section!=null,
                                      ),
                                    );
                                  },
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [


                            ///session
                            Expanded(
                                child: BlocBuilder(
                                  bloc: _timeTableCubit,
                                  builder: (context, statseba) {
                                    return _timeTableCubit.dataList.isNotEmpty && _teacherAttendanceCubit.teacherAttendanceModel.section!=null
                                        ? CustomPopMenuButton(
                                      menus: _timeTableCubit.dataList
                                          .where(
                                              (element) =>
                                          element.programModel?.affiliationName ==
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .affiliation && element.programModel!.department!.name ==
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .department &&
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .combinedPrograms!.contains(element.programModel?.name??"")
                                              && element.programModel?.degree==_teacherAttendanceCubit.teacherAttendanceModel.degree
                                              && element.programModel?.section==_teacherAttendanceCubit.teacherAttendanceModel.section
                                      )
                                          .map((e) => e.programModel?.section ?? "").toSet()
                                          .toList(),
                                      onSelected: (p0) {
                                        String val=_timeTableCubit.dataList
                                            .where(
                                                (element) =>
                                            element.programModel?.affiliationName ==
                                                _teacherAttendanceCubit
                                                    .teacherAttendanceModel
                                                    .affiliation && element.programModel!.department!.name ==
                                                _teacherAttendanceCubit
                                                    .teacherAttendanceModel
                                                    .department &&
                                                _teacherAttendanceCubit
                                                    .teacherAttendanceModel
                                                    .combinedPrograms!.contains(element.programModel?.name??"")
                                                && element.programModel?.degree==_teacherAttendanceCubit.teacherAttendanceModel.degree
                                                && element.programModel?.section==_teacherAttendanceCubit.teacherAttendanceModel.section
                                        )
                                            .map((e) => e.programModel?.session ?? "").toSet()
                                            .toList()[p0];
                                        var model=_teacherAttendanceCubit.teacherAttendanceModel;

                                        _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel(section: model.section,affiliation:model.affiliation,department: model.department,combinedPrograms:model.combinedPrograms,degree: model.degree,session: val));

                                      },
                                      title: "Session",
                                      widget: DropDownFieldWidget(
                                        text:
                                        _teacherAttendanceCubit
                                            .teacherAttendanceModel
                                            .session ??
                                            "Select..",
                                        isFilled: _teacherAttendanceCubit
                                            .teacherAttendanceModel
                                            .session!=null,
                                      ),
                                    )
                                        : InkWell(
                                      onTap: () async {
                                        if(_teacherAttendanceCubit.teacherAttendanceModel.section!=null ){
                                          await _timeTableCubit.get();
                                        }
                                      },
                                      child: DropDownFieldWidget(
                                        title: "Session",
                                        text:
                                        _teacherAttendanceCubit
                                            .teacherAttendanceModel
                                            .session ??
                                            "Select..",
                                        isFilled: _teacherAttendanceCubit
                                            .teacherAttendanceModel
                                            .session!=null,
                                      ),
                                    );
                                  },
                                )
                            ),
                            SizedBox(width: 10),

                            /// semester
                            Expanded(
                              child: BlocBuilder(
                                bloc: _timeTableCubit,
                                builder: (context, statseba) {
                                  return _timeTableCubit.dataList.isNotEmpty && _teacherAttendanceCubit.teacherAttendanceModel.session!=null
                                      ? CustomPopMenuButton(
                                    menus: _timeTableCubit.dataList
                                        .where(
                                            (element) =>
                                        element.programModel?.affiliationName ==
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .affiliation && element.programModel!.department!.name ==
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .department &&
                                            _teacherAttendanceCubit
                                                .teacherAttendanceModel
                                                .combinedPrograms!.contains(element.programModel?.name??"")
                                            && element.programModel?.degree==_teacherAttendanceCubit.teacherAttendanceModel.degree
                                            && element.programModel?.section==_teacherAttendanceCubit.teacherAttendanceModel.section
                                            && element.programModel?.session==_teacherAttendanceCubit.teacherAttendanceModel.session
                                    )
                                        .map((e) => e.semesterModel?.semesterName ?? "").toSet()
                                        .toList(),
                                    onSelected: (p0) {
                                      var dataModel=_timeTableCubit.dataList
                                          .where(
                                              (element) =>
                                          element.programModel?.affiliationName ==
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .affiliation && element.programModel!.department!.name ==
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .department &&
                                              _teacherAttendanceCubit
                                                  .teacherAttendanceModel
                                                  .combinedPrograms!.contains(element.programModel?.name??"")
                                              && element.programModel?.degree==_teacherAttendanceCubit.teacherAttendanceModel.degree
                                              && element.programModel?.section==_teacherAttendanceCubit.teacherAttendanceModel.section
                                              && element.programModel?.session==_teacherAttendanceCubit.teacherAttendanceModel.session
                                      );
                                      String val=
                                      dataModel.map((e) => e.semesterModel?.semesterName ?? "").toSet()
                                          .toList()[p0];
                                      var timetableModel=
                                      dataModel.where((element) =>element.semesterModel?.semesterName==val ,).first;
                                      var model=_teacherAttendanceCubit.teacherAttendanceModel;
                                      _teacherAttendanceCubit.getTeacherAttendanceModel(TeacherAttendanceModel(affiliation:model.affiliation,department: model.department,combinedPrograms:model.combinedPrograms,degree: model.degree,section: model.section,session: model.session,semesterLevel:val,timetableId: timetableModel.id));
                                    },
                                    title: "Semester",
                                    widget: DropDownFieldWidget(
                                      text:
                                      _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .semesterLevel ??
                                          "Select..",
                                      isFilled: _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .semesterLevel!=null,
                                    ),
                                  )
                                      : InkWell(
                                    onTap: () async {
                                      if(_teacherAttendanceCubit.teacherAttendanceModel.session!=null ){
                                        await _timeTableCubit.get();
                                      }
                                    },
                                    child: DropDownFieldWidget(
                                      title: "Semester",
                                      text:
                                      _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .semesterLevel ??
                                          "Select..",
                                      isFilled: _teacherAttendanceCubit
                                          .teacherAttendanceModel
                                          .semesterLevel!=null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),


                        SizedBox(height: 20),

                        CustomElevatedButton(
                          width: mdWidth(context) * .5,
                          height: 35,
                          onPressed: () async {
                            var model=_teacherAttendanceCubit.teacherAttendanceModel;

                            if(model.timetableId!=null){
                              Navigator.pop(context);
                            }else {
                              showMessage("Please fill required fields");
                            }
                            // TODO: Submit logic
                          },
                          text: "Save",
                        ),

                        SafeArea(top: false, child: SizedBox(height: 30)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
