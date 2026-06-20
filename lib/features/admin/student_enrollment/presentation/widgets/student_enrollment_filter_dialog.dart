import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/media_query.dart';
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
  final _programCubit=DiContainer().sl<AdminProgramsCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _studentEnrollCubit,
      builder: (context,statevsak) {
        return CustomAnimatedDialog(child: BlocBuilder(
          bloc: _programCubit,
          builder: (context,statebake) {
            return  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(text: "Filter Students",fontSize: 15,color: AppColor.primary,fontWeight: FontWeight.w600,),
                SizedBox(height: 15),
               if(_programCubit.programsList.isNotEmpty)
               ...[
                 CustomPopMenuButton(menus: _programCubit.programsList.map((e) => e.affiliation.name,).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(affiliation: _programCubit.programsList.map((e) => e.affiliation.name,).toSet().toList()[p0]));
                   },
                   title: "Affiliation",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.affiliation?? "Select..",maxLine: 1, isFilled: false)),),

             SizedBox(height: 10),

                 CustomPopMenuButton(menus: _programCubit.programsList.map((e) => "${e.department.name} (${e.department.code})",).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(department: _programCubit.programsList.map((e) => "${e.department.name} (${e.department.code})",).toSet().toList()[p0]));
                   },
                   title: "Department",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.department?? "Select..",maxLine: 1, isFilled: false)),),

                 SizedBox(height: 10),
                 CustomPopMenuButton(menus: _programCubit.programsList.map((e) => e.section,).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(section: _programCubit.programsList.map((e) => e.section,).toSet().toList()[p0]));
                   },
                   title: "Section",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.section?? "Select..",maxLine: 1, isFilled: false)),),

                 SizedBox(height: 10),
                 CustomPopMenuButton(menus: _programCubit.programsList.map((e) => e.session,).toSet().toList(),
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(session: _programCubit.programsList.map((e) => e.session,).toSet().toList()[p0]));
                   },
                   title: "Session",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.session?? "Select..",maxLine: 1, isFilled: false)),),

                 SizedBox(height: 10),
                 CustomPopMenuButton(menus: ConstantData.semesterList,
                   onSelected: (p0) {
                     _studentEnrollCubit.getStudentEnrollmentFilter(_studentEnrollCubit.filterModel.copyWith(semester: ConstantData.semesterList[p0]));
                   },
                   title: "Semester",offset: Offset(0, 30),widget: SizedBox(
                       width: mdWidth(context),
                       child: DropDownFieldWidget(text:_studentEnrollCubit.filterModel.semester?? "Select..",maxLine: 1, isFilled: false)),),

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
                          var model=_studentEnrollCubit.filterModel;
                          if(_studentEnrollCubit.filterModel.isAnyNull){
                            showMessage("Please fill all fields",isError: true);
                            return;
                          }
                       var response= await  _studentEnrollCubit.get(model);
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
                    await _programCubit.getPrograms();
                  },),
              ],
            );
          }
        ));
      }
    );
  }
}
