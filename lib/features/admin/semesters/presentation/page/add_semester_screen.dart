import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/university_profile/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/helper/app_date_picker.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../../departments/presentation/controller/cubit.dart';
import '../../../programs/presentation/controller/cubit.dart';

class AddSemesterScreen extends StatefulWidget {
   AddSemesterScreen({super.key,this.semesterLevelsModel});
SemesterLevelsModel? semesterLevelsModel;
  @override
  State<AddSemesterScreen> createState() => _AddSemesterScreenState();
}

class _AddSemesterScreenState extends State<AddSemesterScreen> {

  var _departmentCubit = DiContainer().sl<AdminDepartmentCubit>();
  var _profileCubit = DiContainer().sl<UniversityProfileCubit>();
  var _programCubit = DiContainer().sl<AdminProgramsCubit>();
  var _semesterCubit = DiContainer().sl<SemesterAdminCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _semesterCubit.getSemesterLevel(widget.semesterLevelsModel??SemesterLevelsModel());
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: BlocBuilder(
        bloc: _semesterCubit,
        builder: (context,statesbk) {
          return Column(
            children: [
              /// 🔷 TOP BAR (UPDATED)
              CustomTopBar(text:widget.semesterLevelsModel!=null? "Update Semester":"Create Semester"),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenPaddingHori,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      AppText(
                        text: "Semester Setup",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 5),
                      AppText(
                        text:
                        widget.semesterLevelsModel!=null?
                        "Fill all required details to update semester record":
                        "Fill all required details to create a new semester record",
                        fontSize: 11,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 20),

                      /// 🔹 DEPARTMENT
                      BlocBuilder(
                        bloc: _departmentCubit,
                        builder: (context,statesbknk) {
                          return _buildField(
                            title: "Department",
                            child: SizedBox(
                              width: mdWidth(context),
                              child:
                              _departmentCubit.departmentList.isNotEmpty?
                              CustomPopMenuButton(
                                menus:_departmentCubit.departmentList.map((e) => e.name,).toList(),
                                onSelected: (p0) {
                                  String val=_departmentCubit.departmentList.map((e) => e.name,).toList()[p0];
                                  SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                                  model=model.copyWith(department: val);
                                  _semesterCubit.getSemesterLevel(model);

                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.department!=null? _semesterCubit.pickSemesterLevel.department??"": 'Select Department',
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ):InkWell(
                                onTap:  () async{
                                  await _departmentCubit.getDepartments();
                                },
                                child: DropDownFieldWidget(
                                  text: _semesterCubit.pickSemesterLevel.department!=null? _semesterCubit.pickSemesterLevel.department??"": 'Select Department',
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 PROGRAM
                      BlocBuilder(
                        bloc: _programCubit,
                        builder: (context,statebsk) {
                          return _buildField(
                            title: "Program",
                            child:  SizedBox(
                              width: mdWidth(context),
                              child:
                              _programCubit.programsList.isNotEmpty?
                              CustomPopMenuButton(
                                menus: _programCubit.programsList.map((e) => e.name,).toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.programsList.map((e) => e.name,).toList()[p0];
                                  SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                                  model=model.copyWith(programName: val,programId: _programCubit.programsList.map((e) => e.id,).toList()[p0]);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.programName!=null? _semesterCubit.pickSemesterLevel.programName??"": "Select Program",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ):InkWell(
                                onTap: () async{
                                  await _programCubit.getPrograms();
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.programName!=null? _semesterCubit.pickSemesterLevel.programName??"": "Select Program",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 AFFILIATION
                      BlocBuilder(
                        bloc: _profileCubit,
                        builder: (context,statesbkios) {
                          return _buildField(
                            title: "Affiliation",
                            child:  SizedBox(
                              width: mdWidth(context),
                              child:
                              _profileCubit.affiliationFilterList.isNotEmpty?
                              CustomPopMenuButton(
                                menus: _profileCubit.affiliationFilterList.map((e) => e.name,).toList(),
                                onSelected: (p0) {
                                  String val=_profileCubit.affiliationFilterList.map((e) => e.name,).toList()[p0];
                                  SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                                  model=model.copyWith(affiliation: val);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.affiliation!=null? _semesterCubit.pickSemesterLevel.affiliation??"": "Select Affiliation",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ):InkWell(
                                onTap: ()async {
                                 await _profileCubit.getUniversitySetup();
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.affiliation!=null? _semesterCubit.pickSemesterLevel.affiliation??"": "Select Affiliation",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 DEGREE
                      BlocBuilder(
                        bloc: _programCubit,
                        builder: (context,stateskbla) {
                          return _buildField(
                            title: "Degree",
                            child:  SizedBox(
                              width: mdWidth(context),
                              child:_programCubit.programsList.isNotEmpty? CustomPopMenuButton(
                                menus: _programCubit.programsList.map((e) => e.degree,).toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.programsList.map((e) => e.degree,).toList()[p0];
                                  SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                                  model=model.copyWith(degree: val);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.degree!=null? _semesterCubit.pickSemesterLevel.degree??"": "Select Degree",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ):InkWell(
                                onTap: () async{
                                await  _programCubit.getPrograms();
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.degree!=null? _semesterCubit.pickSemesterLevel.degree??"": "Select Degree",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 SESSION
                      BlocBuilder(
                        bloc: _programCubit,
                        builder: (context,statesbkl) {
                          return _buildField(
                            title: "Session",
                            child:  SizedBox(
                              width: mdWidth(context),
                              child:_programCubit.programsList.isNotEmpty? CustomPopMenuButton(
                                menus: _programCubit.programsList.map((e) => e.session,).toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.programsList.map((e) => e.session,).toList()[p0];
                                  SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                                  model=model.copyWith(session: val);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.session!=null? _semesterCubit.pickSemesterLevel.session??"": "Select Session",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ):InkWell(
                                onTap: () async{
                                 await _programCubit.getPrograms();
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.session!=null? _semesterCubit.pickSemesterLevel.session??"": "Select Session",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 SECTION
                      BlocBuilder(
                        bloc: _programCubit,
                        builder: (context,statesnlake) {

                          return _buildField(
                            title: "Section",
                            child:  SizedBox(
                              width: mdWidth(context),
                              child:
                              _programCubit.programsList.isNotEmpty?
                              CustomPopMenuButton(
                                menus: _programCubit.programsList.map((e) => e.section,).toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.programsList.map((e) => e.section,).toList()[p0];
                                  SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                                  model=model.copyWith(section: val);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.section!=null? _semesterCubit.pickSemesterLevel.section??"": "Select Section",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ):InkWell(
                                onTap: () async {
                                  await _programCubit.getPrograms();
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.section!=null? _semesterCubit.pickSemesterLevel.section??"": "Select Section",
                                  maxLine: 1,
                                  isFilled: false,
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 SEMESTER LEVEL
                      _buildField(
                        title: "Semester Level",
                        child:  SizedBox(
                          width: mdWidth(context),
                          child: CustomPopMenuButton(
                            menus: ConstantData.semesterList,
                            onSelected: (p0) {
                              String val=ConstantData.semesterList[p0];
                              SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                              model=model.copyWith(semesterName: val);
                              _semesterCubit.getSemesterLevel(model);
                            },
                            offset: Offset(0, 30),
                            widget: DropDownFieldWidget(
                              text:_semesterCubit.pickSemesterLevel.semesterName!=null? _semesterCubit.pickSemesterLevel.semesterName??"": "Select Level",
                              maxLine: 1,
                              isFilled: false,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(child: InkWell(
                            onTap: () async {
                              DateTime? pickedDate=await  AppDatePicker.pickCustomDate(context: context, initialDate: DateTime.now(), lastDate: DateTime(3000));
                              if(pickedDate!=null){
                                final currentEndDate =
                                    _semesterCubit.pickSemesterLevel.endDate;

                                if (currentEndDate != null &&
                                    pickedDate.isAfter(currentEndDate)) {
                                  showMessage(
                                    "Start date cannot be after end date",isError: true
                                  );
                                  return;
                                }
                                SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                                model=model.copyWith(startDate: pickedDate);
                                _semesterCubit.getSemesterLevel(model);
                              }
                              },
                            child: DropDownFieldWidget(
                              title: "Start Date",
                              text:_semesterCubit.pickSemesterLevel.startDate!=null?DateToStringHelper.dateMonthYearConvert(_semesterCubit.pickSemesterLevel.startDate!): "Start Date",
                              maxLine: 1,
                              isFilled: false,
                            ),
                          )),
                          SizedBox(width: 10,),
                          Expanded(child: InkWell(
                            onTap: () async {
                              DateTime? pickedDate=await  AppDatePicker.pickCustomDate(context: context, initialDate: DateTime.now(), lastDate: DateTime(3000));


                              if(pickedDate!=null){
                                final currentStartDate =
                                    _semesterCubit.pickSemesterLevel.startDate;

                                if (currentStartDate != null &&
                                    pickedDate.isBefore(currentStartDate)) {
                                  showMessage(
                                    "End date cannot be before start date",isError: true
                                  );
                                  return;
                                }
                                SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                                model=model.copyWith(endDate: pickedDate);
                                _semesterCubit.getSemesterLevel(model);
                              }
                            },
                            child: DropDownFieldWidget(
                              title: "End Date",
                              text:_semesterCubit.pickSemesterLevel.endDate!=null? DateToStringHelper.dateMonthYearConvert(_semesterCubit.pickSemesterLevel.endDate!): "End Date",
                              maxLine: 1,
                              isFilled: false,
                            ),
                          ))
                        ],
                      ),
                      SizedBox(height: 15),

                      /// 🔹 STATUS
                      _buildField(
                        title: "Status",
                        child:  SizedBox(
                          width: mdWidth(context),
                          child: CustomPopMenuButton(
                            menus: ['Active', 'Inactive'],
                            onSelected: (p0) {
                              String val=['Active', 'Inactive'][p0];
                              SemesterLevelsModel model=_semesterCubit.pickSemesterLevel;
                              model=model.copyWith(status: val);
                              _semesterCubit.getSemesterLevel(model);
                            },
                            offset: Offset(0, 30),
                            widget: DropDownFieldWidget(
                              text:_semesterCubit.pickSemesterLevel.status!=null? _semesterCubit.pickSemesterLevel.status??"":"Select Status",
                              maxLine: 1,
                              isFilled: false,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      /// 🔹 SAVE BUTTON
                      Center(
                        child: CustomElevatedButton(
                          width: mdWidth(context) * .7,
                          onPressed: () async{
                            if(_semesterCubit.pickSemesterLevel.department==null || _semesterCubit.pickSemesterLevel.affiliation==null||_semesterCubit.pickSemesterLevel.programName==null||_semesterCubit.pickSemesterLevel.degree==null||_semesterCubit.pickSemesterLevel.session==null||_semesterCubit.pickSemesterLevel.section==null||_semesterCubit.pickSemesterLevel.semesterName==null||_semesterCubit.pickSemesterLevel.status==null){
                              showMessage("Please fill all fields");
                              return;
                            }
                         bool val=widget.semesterLevelsModel!=null?
                              await _semesterCubit.editSemester(_semesterCubit.pickSemesterLevel)
                             : await _semesterCubit.addSemester(_semesterCubit.pickSemesterLevel);
                            if(val){
                              context.pop();
                            }
                          },
                          text:widget.semesterLevelsModel!=null? "Update Semester": "Create Semester",
                        ),
                      ),

                      SafeArea(
                          top: false,
                          child: SizedBox(height: 20)),
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

  /// 🔥 REUSABLE FIELD WIDGET
  Widget _buildField({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 12,
          color: AppColor.grey,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 6),
        child,
      ],
    );
  }
}