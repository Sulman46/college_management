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
import '../../../marking_student/presentation/controller/cubit.dart';
import '../../../programs/presentation/controller/cubit.dart';
import '../controller/cubit.dart';

class FilterExamScheduleDialog extends StatefulWidget {
  const FilterExamScheduleDialog({super.key});

  @override
  State<FilterExamScheduleDialog> createState() => _FilterExamScheduleDialogState();
}

class _FilterExamScheduleDialogState extends State<FilterExamScheduleDialog> {
  final _examScheduleCubit=DiContainer().sl<ExamScheduleCubit>();
  final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _examScheduleCubit.getExamScheduleFilter(_examScheduleCubit.submittedData);
    },);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _examScheduleCubit,
        builder: (context,statevsak) {
          return CustomAnimatedDialog(child: BlocBuilder(
              bloc: _semesterCubit,
              builder: (context,statebhake) {
                return  SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(text: "Exam Schedule",fontSize: 15,color: AppColor.white,fontWeight: FontWeight.w600,),
                      SizedBox(height: 15),
                      if(_semesterCubit.semesterList.isNotEmpty)
                        ...[
                          CustomPopMenuButton(menus: _semesterCubit.semesterList.map((e) => e.programModel?.affiliationName??"",).toSet().toList(),
                            onSelected: (p0) async {
                              String val=_semesterCubit.semesterList.map((e) => e.programModel?.affiliationName??"",).toSet().toList()[p0];
                              _examScheduleCubit.getExamScheduleFilter(_examScheduleCubit.filterModel.copyWith(affiliation: val));
                              // await  Clipboard.setData(ClipboardData(text: val));
                            },
                            title: "Affiliation",offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text:_examScheduleCubit.filterModel.affiliation?? "Select..",maxLine: 1, isFilled: _examScheduleCubit.filterModel.affiliation!=null)),),

                          SizedBox(height: 10),

                          CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation,).map((e) => e.programModel?.departmentName??"",).toSet().toList(),
                            onSelected: (p0) async {
                              String val=_semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation,).map((e) => e.programModel?.departmentName??"",).toSet().toList()[p0];
                              _examScheduleCubit.getExamScheduleFilter(_examScheduleCubit.filterModel.copyWith(department: val));
                              // await  Clipboard.setData(ClipboardData(text: val));
                            },
                            title: "Department",offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text:_examScheduleCubit.filterModel.department?? "Select..",maxLine: 1, isFilled: _examScheduleCubit.filterModel.department!=null)),),
                          SizedBox(height: 10),
                          CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation && element.programModel!.departmentName==_examScheduleCubit.filterModel.department,).map((e) => e.programModel?.name??"",).toSet().toList(),
                            onSelected: (p0)async {
                              String val=_semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation && element.programModel!.departmentName==_examScheduleCubit.filterModel.department,).map((e) =>  e.programModel?.name??"",).toSet().toList()[p0];
                              _examScheduleCubit.getExamScheduleFilter(_examScheduleCubit.filterModel.copyWith(program:val ));
                              // await  Clipboard.setData(ClipboardData(text: val));
                            },
                            title: "Program",offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text:_examScheduleCubit.filterModel.program?? "Select..",maxLine: 1, isFilled: _examScheduleCubit.filterModel.program!=null)),),


                          SizedBox(height: 10),
                          CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation && element.programModel!.departmentName==_examScheduleCubit.filterModel.department&& element.programModel!.name==_examScheduleCubit.filterModel.program,).map((e) => e.programModel?.section??"",).toSet().toList(),
                            onSelected: (p0) async {
                              String val= _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation && element.programModel!.departmentName==_examScheduleCubit.filterModel.department&& element.programModel!.name==_examScheduleCubit.filterModel.program,).map((e) =>  e.programModel?.section??"",).toSet().toList()[p0];
                              _examScheduleCubit.getExamScheduleFilter(_examScheduleCubit.filterModel.copyWith(section:val));
                              // await  Clipboard.setData(ClipboardData(text: val));
                            },
                            title: "Section",offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text:_examScheduleCubit.filterModel.section?? "Select..",maxLine: 1, isFilled: _examScheduleCubit.filterModel.section!=null)),),

                          SizedBox(height: 10),
                          CustomPopMenuButton(
                            menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation && element.programModel!.departmentName==_examScheduleCubit.filterModel.department && element.programModel!.name==_examScheduleCubit.filterModel.program && element.programModel!.section==_examScheduleCubit.filterModel.section,).map((e) => e.programModel!.session,).toSet().toList(),
                            onSelected: (p0) async {
                              String val=_semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation&& element.programModel!.name==_examScheduleCubit.filterModel.program && element.programModel!.departmentName==_examScheduleCubit.filterModel.department && element.programModel!.section==_examScheduleCubit.filterModel.section,).map((e) => e.programModel!.session,).toSet().toList()[p0];
                              _examScheduleCubit.getExamScheduleFilter(_examScheduleCubit.filterModel.copyWith(session: val));
                              // await  Clipboard.setData(ClipboardData(text: val));
                            },
                            title: "Session",offset: Offset(0, 30),widget: SizedBox(
                              width: mdWidth(context),
                              child: DropDownFieldWidget(text:_examScheduleCubit.filterModel.session?? "Select..",maxLine: 1, isFilled: _examScheduleCubit.filterModel.session!=null)),),

                          SizedBox(height: 10),
                          CustomPopMenuButton(
                            menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation && element.programModel!.departmentName==_examScheduleCubit.filterModel.department && element.programModel!.name==_examScheduleCubit.filterModel.program&& element.programModel!.section==_examScheduleCubit.filterModel.section && element.programModel!.session==_examScheduleCubit.filterModel.session,).map((e) => "${e.semesterName??""} (${e.status})",).toSet().toList(),
                            onSelected: (p0) async {
                              var list=_semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_examScheduleCubit.filterModel.affiliation && element.programModel!.departmentName==_examScheduleCubit.filterModel.department&& element.programModel!.name==_examScheduleCubit.filterModel.program && element.programModel!.section==_examScheduleCubit.filterModel.section && element.programModel!.session==_examScheduleCubit.filterModel.session,);
                              String value=list.map((e) => "${e.semesterName??""} (${e.status})",).toSet().toList()[p0];
                              String semId=list.where((e) => "${e.semesterName??""} (${e.status})"==value,).map((e) => e.id,).first??"";
                              String programId=list.where((e) => e.id==semId).map((e) => e.programId,).first??"";
                             // await  Clipboard.setData(ClipboardData(text: semId));
                              _examScheduleCubit.getExamScheduleFilter(_examScheduleCubit.filterModel.copyWith(programId: programId,semester: value,semesterId:semId));
                            },
                            title: "Semester",offset: Offset(0, 30),widget: SizedBox(
                              width: mdWidth(context),
                              child: DropDownFieldWidget(text:_examScheduleCubit.filterModel.semester?? "Select..",maxLine: 1, isFilled: _examScheduleCubit.filterModel.semester!=null)),),



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
                                    if(_examScheduleCubit.filterModel.isAnyNull){
                                      showMessage("Please fill all fields",isError: true);
                                      return;
                                    }
                                    _examScheduleCubit.getSubmittedData(_examScheduleCubit.filterModel);
                                    var response= await  _examScheduleCubit.get();
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
