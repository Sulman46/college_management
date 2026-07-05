import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
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
import '../../../programs/presentation/controller/cubit.dart';
import '../../models/add_semester_model.dart';

class AddSemesterScreen extends StatefulWidget {
   AddSemesterScreen({super.key,this.semesterLevelsModel});
SemesterLevelsModel? semesterLevelsModel;
  @override
  State<AddSemesterScreen> createState() => _AddSemesterScreenState();
}

class _AddSemesterScreenState extends State<AddSemesterScreen> {

  final _programCubit = DiContainer().sl<AdminProgramsCubit>();
  final _semesterCubit = DiContainer().sl<SemesterAdminCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(widget.semesterLevelsModel!=null){
        AddSemesterModel semesterModel=AddSemesterModel(id:widget.semesterLevelsModel!.id,semesterName: widget.semesterLevelsModel!.semesterName,endDate: widget.semesterLevelsModel!.endDate,startDate: widget.semesterLevelsModel!.startDate,programId: widget.semesterLevelsModel!.programId,status: widget.semesterLevelsModel!.status,section: widget.semesterLevelsModel!.programModel!.section,session: widget.semesterLevelsModel!.programModel!.session,degree: widget.semesterLevelsModel!.programModel!.degree,affiliation: widget.semesterLevelsModel!.programModel!.affiliationName,programName: widget.semesterLevelsModel!.programModel!.name,department: widget.semesterLevelsModel!.programModel!.departmentName );
        _semesterCubit.getSemesterLevel(semesterModel);
      }else{
        _semesterCubit.getSemesterLevel(AddSemesterModel());
      }
      await _programCubit.getPrograms();
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
                        bloc: _programCubit,
                        builder: (context,statesbknk) {
                          return _buildField(
                            title: "Department",
                            child: SizedBox(
                              width: mdWidth(context),
                              child:
                              _programCubit.activePrograms.isNotEmpty?
                              CustomPopMenuButton(
                                menus:_programCubit.activePrograms.map((e) => e.department!.name,).toSet().toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.activePrograms.map((e) => e.department!.name,).toSet().toList()[p0];
                                  AddSemesterModel pickedModel=_semesterCubit.pickSemesterLevel;
                                  AddSemesterModel model=AddSemesterModel(department: val,status: pickedModel.status,semesterName: pickedModel.semesterName,endDate: pickedModel.endDate,startDate: pickedModel.startDate);
                                  _semesterCubit.getSemesterLevel(model);

                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.department!=null? _semesterCubit.pickSemesterLevel.department??"": 'Select Department',
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.department!=null,
                                ),
                              ):InkWell(
                                onTap:  () async{
                                  await _programCubit.getPrograms();
                                },
                                child: DropDownFieldWidget(
                                  text: _semesterCubit.pickSemesterLevel.department!=null? _semesterCubit.pickSemesterLevel.department??"": 'Select Department',
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.department!=null,
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
                              _programCubit.activePrograms.isNotEmpty && _semesterCubit.pickSemesterLevel.department!=null?
                              CustomPopMenuButton(
                                menus: _programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department,).map((e) => e.name!,).toSet().toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department,).map((e) => e.name!,).toSet().toList()[p0];
                                  String programId=_programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department,).map((e) => e.id!,).toSet().toList()[p0];
                                  AddSemesterModel pickedModel=_semesterCubit.pickSemesterLevel;
                                  AddSemesterModel model=AddSemesterModel(programName: val,programId: programId,department: pickedModel.department,status: pickedModel.status,semesterName: pickedModel.semesterName,endDate: pickedModel.endDate,startDate: pickedModel.startDate);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.programName!=null? _semesterCubit.pickSemesterLevel.programName??"": "Select Program",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.programName!=null,
                                ),
                              ):InkWell(
                                onTap: () async{
                                  if(_semesterCubit.pickSemesterLevel.department!=null && _programCubit.activePrograms.isEmpty){
                                    await _programCubit.getPrograms();
                                  }else{
                                    showMessage("Select Department");
                                  }
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.programName!=null? _semesterCubit.pickSemesterLevel.programName??"": "Select Program",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.programName!=null,
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                      SizedBox(height: 15),

                      /// 🔹 AFFILIATION
                      BlocBuilder(
                        bloc: _programCubit,
                        builder: (context,statesbkios) {
                          return _buildField(
                            title: "Affiliation",
                            child:  SizedBox(
                              width: mdWidth(context),
                              child:
                              _programCubit.activePrograms.isNotEmpty && _semesterCubit.pickSemesterLevel.department!=null?
                              CustomPopMenuButton(
                                menus: _programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department && element.id==_semesterCubit.pickSemesterLevel.programId,).map((e) => e.affiliationName!,).toSet().toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department && element.id==_semesterCubit.pickSemesterLevel.programId,).map((e) => e.affiliationName!,).toSet().toList()[p0];
                                  AddSemesterModel pickedModel=_semesterCubit.pickSemesterLevel;
                                  AddSemesterModel model=AddSemesterModel(affiliation: val,programName: pickedModel.programName,programId: pickedModel.programId,department: pickedModel.department,status: pickedModel.status,semesterName: pickedModel.semesterName,endDate: pickedModel.endDate,startDate: pickedModel.startDate);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.affiliation!=null? _semesterCubit.pickSemesterLevel.affiliation??"": "Select Affiliation",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.affiliation!=null,
                                ),
                              ):InkWell(
                                onTap: ()async {
                                  if(_semesterCubit.pickSemesterLevel.department!=null && _programCubit.activePrograms.isEmpty){
                                    await _programCubit.getPrograms();
                                  }else{
                                    showMessage("Select Program");
                                  }
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.affiliation!=null? _semesterCubit.pickSemesterLevel.affiliation??"": "Select Affiliation",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.affiliation!=null,
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
                              child:_programCubit.activePrograms.isNotEmpty &&  _semesterCubit.pickSemesterLevel.affiliation!=null?
                              CustomPopMenuButton(
                                menus: _programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department && element.id==_semesterCubit.pickSemesterLevel.programId && element.affiliationName==_semesterCubit.pickSemesterLevel.affiliation).map((e) => e.degree!,).toSet().toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department && element.id==_semesterCubit.pickSemesterLevel.programId && element.affiliationName==_semesterCubit.pickSemesterLevel.affiliation).map((e) => e.degree!,).toSet().toList()[p0];
                                  AddSemesterModel pickedModel=_semesterCubit.pickSemesterLevel;
                                  AddSemesterModel model=AddSemesterModel(degree: val,affiliation: pickedModel.affiliation,programName: pickedModel.programName,programId: pickedModel.programId,department: pickedModel.department,status: pickedModel.status,semesterName: pickedModel.semesterName,endDate: pickedModel.endDate,startDate: pickedModel.startDate);

                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.degree!=null? _semesterCubit.pickSemesterLevel.degree??"": "Select Degree",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.degree!=null,
                                ),
                              ):InkWell(
                                onTap: () async{
                                  if( _semesterCubit.pickSemesterLevel.affiliation!=null &&_programCubit.activePrograms.isEmpty){
                                    await  _programCubit.getPrograms();
                                  }else{
                                    showMessage("Select Affiliation");
                                  }
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.degree!=null? _semesterCubit.pickSemesterLevel.degree??"": "Select Degree",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.degree!=null,
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
                              child:_programCubit.activePrograms.isNotEmpty &&_semesterCubit.pickSemesterLevel.degree!=null? CustomPopMenuButton(
                                menus: _programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department && element.id==_semesterCubit.pickSemesterLevel.programId && element.affiliationName==_semesterCubit.pickSemesterLevel.affiliation && element.degree==_semesterCubit.pickSemesterLevel.degree).map((e) => e.session!,).toSet().toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department && element.id==_semesterCubit.pickSemesterLevel.programId && element.affiliationName==_semesterCubit.pickSemesterLevel.affiliation && element.degree==_semesterCubit.pickSemesterLevel.degree).map((e) => e.session!,).toSet().toList()[p0];
                                  AddSemesterModel pickedModel=_semesterCubit.pickSemesterLevel;
                                  AddSemesterModel model=AddSemesterModel(session: val,degree: pickedModel.degree,affiliation: pickedModel.affiliation,programName: pickedModel.programName,programId: pickedModel.programId,department: pickedModel.department,status: pickedModel.status,semesterName: pickedModel.semesterName,endDate: pickedModel.endDate,startDate: pickedModel.startDate);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.session!=null? _semesterCubit.pickSemesterLevel.session??"": "Select Session",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.session!=null,
                                ),
                              ):InkWell(
                                onTap: () async{
                                  if(_semesterCubit.pickSemesterLevel.degree!=null && _programCubit.activePrograms.isEmpty){
                                    await _programCubit.getPrograms();

                                  }else{
                                    showMessage("Select Degree");
                                  }
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.session!=null? _semesterCubit.pickSemesterLevel.session??"": "Select Session",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.session!=null,
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
                              _programCubit.activePrograms.isNotEmpty && _semesterCubit.pickSemesterLevel.session!=null?
                              CustomPopMenuButton(
                                menus: _programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department && element.id==_semesterCubit.pickSemesterLevel.programId && element.affiliationName==_semesterCubit.pickSemesterLevel.affiliation && element.degree==_semesterCubit.pickSemesterLevel.degree&& element.session==_semesterCubit.pickSemesterLevel.session).map((e) => e.section!,).toSet().toList(),
                                onSelected: (p0) {
                                  String val=_programCubit.activePrograms.where((element) => element.department!.name==_semesterCubit.pickSemesterLevel.department && element.id==_semesterCubit.pickSemesterLevel.programId && element.affiliationName==_semesterCubit.pickSemesterLevel.affiliation && element.degree==_semesterCubit.pickSemesterLevel.degree&& element.session==_semesterCubit.pickSemesterLevel.session).map((e) => e.section!,).toSet().toList()[p0];
                                  AddSemesterModel pickedModel=_semesterCubit.pickSemesterLevel;
                                  AddSemesterModel model=AddSemesterModel(section: val,session: pickedModel.session,degree: pickedModel.degree,affiliation: pickedModel.affiliation,programName: pickedModel.programName,programId: pickedModel.programId,department: pickedModel.department,status: pickedModel.status,semesterName: pickedModel.semesterName,endDate: pickedModel.endDate,startDate: pickedModel.startDate);
                                  _semesterCubit.getSemesterLevel(model);
                                },
                                offset: Offset(0, 30),
                                widget: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.section!=null? _semesterCubit.pickSemesterLevel.section??"": "Select Section",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.section!=null,
                                ),
                              ):InkWell(
                                onTap: () async {
                                   if(_semesterCubit.pickSemesterLevel.session!=null && _programCubit.activePrograms.isEmpty){
                                    await _programCubit.getPrograms();
                                  }else{
                                     showMessage("Select Session");
                                   }
                                },
                                child: DropDownFieldWidget(
                                  text:_semesterCubit.pickSemesterLevel.section!=null? _semesterCubit.pickSemesterLevel.section??"": "Select Section",
                                  maxLine: 1,
                                  isFilled: _semesterCubit.pickSemesterLevel.section!=null,
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
                            // menus: ConstantData.semesterList,
                            menus: ["1"],
                            onSelected: (p0) {
                              String val=ConstantData.semesterList[p0];
                              AddSemesterModel model=_semesterCubit.pickSemesterLevel;
                              model=model.copyWith(semesterName: val);
                              _semesterCubit.getSemesterLevel(model);
                            },
                            offset: Offset(0, 30),
                            widget: DropDownFieldWidget(
                              text:_semesterCubit.pickSemesterLevel.semesterName!=null? _semesterCubit.pickSemesterLevel.semesterName??"": "Select Level",
                              maxLine: 1,
                              isFilled: _semesterCubit.pickSemesterLevel.semesterName!=null,
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
                                AddSemesterModel model=_semesterCubit.pickSemesterLevel;
                                model=model.copyWith(startDate: pickedDate);
                                _semesterCubit.getSemesterLevel(model);
                              }
                              },
                            child: DropDownFieldWidget(
                              title: "Start Date",
                              text:_semesterCubit.pickSemesterLevel.startDate!=null?DateToStringHelper.dateMonthYearConvert(_semesterCubit.pickSemesterLevel.startDate!): "Start Date",
                              maxLine: 1,
                              isFilled: _semesterCubit.pickSemesterLevel.startDate!=null,
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
                                AddSemesterModel model=_semesterCubit.pickSemesterLevel;
                                model=model.copyWith(endDate: pickedDate);
                                _semesterCubit.getSemesterLevel(model);
                              }
                            },
                            child: DropDownFieldWidget(
                              title: "End Date",
                              text:_semesterCubit.pickSemesterLevel.endDate!=null? DateToStringHelper.dateMonthYearConvert(_semesterCubit.pickSemesterLevel.endDate!): "End Date",
                              maxLine: 1,
                              isFilled: _semesterCubit.pickSemesterLevel.endDate!=null,
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
                              AddSemesterModel model=_semesterCubit.pickSemesterLevel;
                              model=model.copyWith(status: val);
                              _semesterCubit.getSemesterLevel(model);
                            },
                            offset: Offset(0, 30),
                            widget: DropDownFieldWidget(
                              text:_semesterCubit.pickSemesterLevel.status!=null? _semesterCubit.pickSemesterLevel.status??"":"Select Status",
                              maxLine: 1,
                              isFilled: _semesterCubit.pickSemesterLevel.status!=null,
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
                              showMessage("Please fill all fields",isError: true);
                              return;
                            }
                            var model=_semesterCubit.pickSemesterLevel;
                            if(widget.semesterLevelsModel!=null){
                              model=model.copyWith(id: widget.semesterLevelsModel?.id??"");
                            }

                            int index=_programCubit.programsList.indexWhere((element) => element.name==model.programName && element.department!.name==model.department && element.affiliationName==model.affiliation && element.degree==model.degree && element.session==model.session && element.section==model.section);

                            var programModel=_programCubit.programsList[index];

                            SemesterLevelsModel semesterLevelModel=SemesterLevelsModel(status: model.status, programId:programModel.id,startDate: model.startDate,endDate: model.endDate,semesterName: model.semesterName,id: model.id,);

                         bool val=widget.semesterLevelsModel!=null?
                              await _semesterCubit.editSemester(semesterLevelModel)
                             : await _semesterCubit.addSemester(semesterLevelModel);
                            if(val){
                              context.pop();
                              await _semesterCubit.getSemesterList();
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