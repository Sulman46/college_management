import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/helper/data_extractor.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../programs/presentation/controller/cubit.dart';
import '../controller/cubit.dart';

class FilterMarkingStudentDialog extends StatefulWidget {
  const FilterMarkingStudentDialog({super.key});

  @override
  State<FilterMarkingStudentDialog> createState() => _FilterMarkingStudentDialogState();
}

class _FilterMarkingStudentDialogState extends State<FilterMarkingStudentDialog> {
  final _markingCubit=DiContainer().sl<MarkingStudentCubit>();
  final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();
  final _courseMapping=DiContainer().sl<CourseMappingCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _markingCubit.getMarkingStudentFilter(_markingCubit.submittedData);
    },);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _markingCubit,
        builder: (context,statevsak) {
          return CustomAnimatedDialog(child: BlocBuilder(
              bloc: _semesterCubit,
              builder: (context,statebhake) {
                return  SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: "Filter Students",fontSize: 15,color: AppColor.white,fontWeight: FontWeight.w600,),
                      SizedBox(height: 15),
                      if(_semesterCubit.semesterList.isNotEmpty)
                        ...[
                          CustomPopMenuButton(menus: _semesterCubit.semesterList.map((e) => e.programModel?.affiliationName??"",).toSet().toList(),
                            onSelected: (p0) {
                              _markingCubit.getMarkingStudentFilter(_markingCubit.filterModel.copyWith(affiliation: _semesterCubit.semesterList.map((e) => e.programModel?.affiliationName??"",).toSet().toList()[p0]));
                            },
                            title: "Affiliation",offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text:_markingCubit.filterModel.affiliation?? "Select..",maxLine: 1, isFilled: _markingCubit.filterModel.affiliation!=null)),),

                          SizedBox(height: 10),

                          CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation,).map((e) => e.programModel?.departmentName??"",).toSet().toList(),
                            onSelected: (p0) {
                              _markingCubit.getMarkingStudentFilter(_markingCubit.filterModel.copyWith(department: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation,).map((e) => e.programModel?.departmentName??"",).toSet().toList()[p0]));
                            },
                            title: "Department",offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text:_markingCubit.filterModel.department?? "Select..",maxLine: 1, isFilled: _markingCubit.filterModel.department!=null)),),
                          SizedBox(height: 10),
                          CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation && element.programModel!.departmentName==_markingCubit.filterModel.department,).map((e) => e.programModel?.name??"",).toSet().toList(),
                            onSelected: (p0) {
                              _markingCubit.getMarkingStudentFilter(_markingCubit.filterModel.copyWith(program: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation && element.programModel!.departmentName==_markingCubit.filterModel.department,).map((e) =>  e.programModel?.name??"",).toSet().toList()[p0]));
                            },
                            title: "Program",offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text:_markingCubit.filterModel.program?? "Select..",maxLine: 1, isFilled: _markingCubit.filterModel.program!=null)),),


                          SizedBox(height: 10),
                          CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation && element.programModel!.departmentName==_markingCubit.filterModel.department&& element.programModel!.name==_markingCubit.filterModel.program,).map((e) => e.programModel?.section??"",).toSet().toList(),
                            onSelected: (p0) {
                              _markingCubit.getMarkingStudentFilter(_markingCubit.filterModel.copyWith(section: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation && element.programModel!.departmentName==_markingCubit.filterModel.department&& element.programModel!.name==_markingCubit.filterModel.program,).map((e) =>  e.programModel?.section??"",).toSet().toList()[p0]));
                            },
                            title: "Section",offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text:_markingCubit.filterModel.section?? "Select..",maxLine: 1, isFilled: _markingCubit.filterModel.section!=null)),),

                          SizedBox(height: 10),
                          CustomPopMenuButton(
                            menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation && element.programModel!.departmentName==_markingCubit.filterModel.department && element.programModel!.name==_markingCubit.filterModel.program && element.programModel!.section==_markingCubit.filterModel.section,).map((e) => e.programModel!.session,).toSet().toList(),
                            onSelected: (p0) {
                              _markingCubit.getMarkingStudentFilter(_markingCubit.filterModel.copyWith(session: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation&& element.programModel!.name==_markingCubit.filterModel.program && element.programModel!.departmentName==_markingCubit.filterModel.department && element.programModel!.section==_markingCubit.filterModel.section,).map((e) => e.programModel!.session,).toSet().toList()[p0]));
                            },
                            title: "Session",offset: Offset(0, 30),widget: SizedBox(
                              width: mdWidth(context),
                              child: DropDownFieldWidget(text:_markingCubit.filterModel.session?? "Select..",maxLine: 1, isFilled: _markingCubit.filterModel.session!=null)),),

                          SizedBox(height: 10),
                          CustomPopMenuButton(
                            menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation && element.programModel!.departmentName==_markingCubit.filterModel.department && element.programModel!.name==_markingCubit.filterModel.program&& element.programModel!.section==_markingCubit.filterModel.section && element.programModel!.session==_markingCubit.filterModel.session,).map((e) => "${e.semesterName??""} (${e.status})",).toSet().toList(),
                            onSelected: (p0) async {
                              var list=_semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_markingCubit.filterModel.affiliation && element.programModel!.departmentName==_markingCubit.filterModel.department&& element.programModel!.name==_markingCubit.filterModel.program && element.programModel!.section==_markingCubit.filterModel.section && element.programModel!.session==_markingCubit.filterModel.session,);
                              String value=list.map((e) => "${e.semesterName??""} (${e.status})",).toSet().toList()[p0];
                             String semId=list.where((e) => "${e.semesterName??""} (${e.status})"==value,).map((e) => e.id,).first??"";
                             String programId=list.where((e) => e.id==semId).map((e) => e.programId,).first??"";
                            // await  Clipboard.setData(ClipboardData(text: semId));
                              _markingCubit.getMarkingStudentFilter(_markingCubit.filterModel.copyWith(programId: programId,semester: value,semesterId:semId));
                            },
                            title: "Semester",offset: Offset(0, 30),widget: SizedBox(
                              width: mdWidth(context),
                              child: DropDownFieldWidget(text:_markingCubit.filterModel.semester?? "Select..",maxLine: 1, isFilled: _markingCubit.filterModel.semester!=null)),),


                          SizedBox(height: 10),
                          BlocBuilder(
                            bloc: _courseMapping,
                            builder: (context,stateMapping) {
                              return _courseMapping.courseMappingList.where((element) => element.semesterId==_markingCubit.filterModel.semesterId,).isNotEmpty? CustomPopMenuButton(
                                menus: _courseMapping.courseMappingList.where((element) => element.semesterId==_markingCubit.filterModel.semesterId,).map((e) => e.courseTitle??"",).toSet().toList(),
                                onSelected: (p0) async {
                                  var list=_courseMapping.courseMappingList.where((element) => element.semesterId==_markingCubit.filterModel.semesterId,);
                                  String courseName=list.map((e) => e.courseTitle??"",).toSet().toList()[p0];
                                  String mappingId=list.where((element) => element.courseName==courseName,).first.id??"";
                                  await Clipboard.setData(ClipboardData(text: mappingId));
                                  _markingCubit.getMarkingStudentFilter(_markingCubit.filterModel.copyWith(courseName:courseName,mappingId: mappingId));
                                },
                                offset: Offset(0, 30),widget: SizedBox(
                                  width: mdWidth(context),
                                  child: DropDownFieldWidget(
                                      title: "Course Name",
                                      text:_markingCubit.filterModel.courseName?? "Select..",maxLine: 1, isFilled: _markingCubit.filterModel.semester!=null)),)
                                  : InkWell(
                                  onTap: () async {
                                    await _courseMapping.getMappingData();
                                   },
                                  child: DropDownFieldWidget(
                                      title: "Course Name",
                                      text:_markingCubit.filterModel.courseName?? "Select..",maxLine: 1, isFilled: _markingCubit.filterModel.semester!=null));
                            }
                          ),

                          SizedBox(height: 25),

                          /// 🔹 BUTTONS
                          Row(
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: "Discard",
                                  bgColor: AppColor.white,
                                  textColor: AppColor.red,
                                  borderColor: AppColor.red,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomElevatedButton(
                                  onPressed: () async{
                                    if(_markingCubit.filterModel.isAnyNull){
                                      showMessage("Please fill all fields",isError: true);
                                      return;
                                    }
                                    _markingCubit.initFunction(_markingCubit.filterModel);
                                    var response= await  _markingCubit.getMarksStudent();
                                    // if(DataExtractor.extractInt(_markingCubit.filterModel.semester)!=1){
                                    //   var res=    await _markingCubit.getHistory(_markingCubit.submittedData.copyWith(semester:"${ DataExtractor.extractInt(_markingCubit.submittedData.semester)-1}"));
                                    // }
                                    if(response){
                                      Navigator.pop(context);
                                    }
                                  },
                                  text: "Save",
                                ),
                              ),
                            ],
                          )]
                      else
                        DataNotFoundWidget(onTap: () async{
                          await _semesterCubit.getSemesterList();
                        },),
                    ],
                  ),
                );
              }
          ));
        }
    );
  }
}
