import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/helper/data_extractor.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../programs/presentation/controller/cubit.dart';

class StudentEnrollmentFilterDialog extends StatefulWidget {
  const StudentEnrollmentFilterDialog({super.key});

  @override
  State<StudentEnrollmentFilterDialog> createState() => _StudentEnrollmentFilterDialogState();
}

class _StudentEnrollmentFilterDialogState extends State<StudentEnrollmentFilterDialog> {
  final _studentEnrollCubit=DiContainer().sl<StudentEnrollmentCubit>();
  final _semesterCubit=DiContainer().sl<SemesterAdminCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.submittedData);
    },);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _studentEnrollCubit,
      builder: (context,statevsak) {
        return CustomAnimatedDialog(child: BlocBuilder(
          bloc: _semesterCubit,
          builder: (context,statebhake) {
            return  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(text: "Filter Students",fontSize: 15,color: AppColor.white,fontWeight: FontWeight.w600,),
                SizedBox(height: 15),
               if(_semesterCubit.semesterList.isNotEmpty)
               ...[
                 CustomPopMenuButton(menus: _semesterCubit.semesterList.map((e) => e.programModel?.affiliationName??"",).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(affiliation: _semesterCubit.semesterList.map((e) => e.programModel?.affiliationName??"",).toSet().toList()[p0]));
                   },
                   title: "Affiliation",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.affiliation?? "Select..",maxLine: 1, isFilled: _studentEnrollCubit.filterModel.affiliation!=null)),),

             SizedBox(height: 10),

                 CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation,).map((e) => e.programModel?.departmentName??"",).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(department: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation,).map((e) => e.programModel?.departmentName??"",).toSet().toList()[p0]));
                   },
                   title: "Department",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.department?? "Select..",maxLine: 1, isFilled: _studentEnrollCubit.filterModel.department!=null)),),
                 SizedBox(height: 10),
                 CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation && element.programModel!.departmentName==_studentEnrollCubit.filterModel.department,).map((e) => e.programModel?.name??"",).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(program: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation && element.programModel!.departmentName==_studentEnrollCubit.filterModel.department,).map((e) =>  e.programModel?.name??"",).toSet().toList()[p0]));
                   },
                   title: "Program",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.program?? "Select..",maxLine: 1, isFilled: _studentEnrollCubit.filterModel.program!=null)),),


                 SizedBox(height: 10),
                 CustomPopMenuButton(menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation && element.programModel!.departmentName==_studentEnrollCubit.filterModel.department&& element.programModel!.name==_studentEnrollCubit.filterModel.program,).map((e) => e.programModel?.section??"",).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(section: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation && element.programModel!.departmentName==_studentEnrollCubit.filterModel.department&& element.programModel!.name==_studentEnrollCubit.filterModel.program,).map((e) =>  e.programModel?.section??"",).toSet().toList()[p0]));
                   },
                   title: "Section",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.section?? "Select..",maxLine: 1, isFilled: _studentEnrollCubit.filterModel.section!=null)),),

                      SizedBox(height: 10),
                 CustomPopMenuButton(
                   menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation && element.programModel!.departmentName==_studentEnrollCubit.filterModel.department && element.programModel!.name==_studentEnrollCubit.filterModel.program && element.programModel!.section==_studentEnrollCubit.filterModel.section,).map((e) => e.programModel!.session,).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(session: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation&& element.programModel!.name==_studentEnrollCubit.filterModel.program && element.programModel!.departmentName==_studentEnrollCubit.filterModel.department && element.programModel!.section==_studentEnrollCubit.filterModel.section,).map((e) => e.programModel!.session,).toSet().toList()[p0]));
                   },
                   title: "Session",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.session?? "Select..",maxLine: 1, isFilled: _studentEnrollCubit.filterModel.session!=null)),),

                 SizedBox(height: 10),
                 CustomPopMenuButton(
                   menus: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation && element.programModel!.departmentName==_studentEnrollCubit.filterModel.department && element.programModel!.name==_studentEnrollCubit.filterModel.program&& element.programModel!.section==_studentEnrollCubit.filterModel.section && element.programModel!.session==_studentEnrollCubit.filterModel.session,).map((e) => "${e.semesterName??""} (${e.status})",).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(semester: _semesterCubit.semesterList.where((element) => element.programModel!.affiliationName==_studentEnrollCubit.filterModel.affiliation && element.programModel!.departmentName==_studentEnrollCubit.filterModel.department&& element.programModel!.name==_studentEnrollCubit.filterModel.program && element.programModel!.section==_studentEnrollCubit.filterModel.section && element.programModel!.session==_studentEnrollCubit.filterModel.session,).map((e) => "${e.semesterName??""} (${e.status})",).toSet().toList()[p0]));
                   },
                   title: "Semester",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.semester?? "Select..",maxLine: 1, isFilled: _studentEnrollCubit.filterModel.semester!=null)),),

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
                          if(_studentEnrollCubit.filterModel.isAnyNull){
                            showMessage("Please fill all fields",isError: true);
                            return;
                          }
                          _studentEnrollCubit.initFunction(_studentEnrollCubit.filterModel);
                       var response= await  _studentEnrollCubit.get();
                       if(DataExtractor.extractInt(_studentEnrollCubit.filterModel.semester)!=1){
                         var res=    await _studentEnrollCubit.getHistory(_studentEnrollCubit.submittedData.copyWith(semester:"${ DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)-1}"));
                       }
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
            );
          }
        ));
      }
    );
  }
}
