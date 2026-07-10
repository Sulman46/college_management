import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_filter_dialog.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_role_enrollment_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../core/helper/data_extractor.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/data_not_found_widget.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';
import '../../../semesters/presentation/controller/cubit.dart';
import '../../../student_registrations/presentation/controller/cubit.dart';
import '../../data/models/student_enrollment_filter_model.dart';
import '../controller/cubit.dart';
import 'enrolled_student_widget.dart';

class StudentEnrolledSection extends StatefulWidget {
  const StudentEnrolledSection({super.key});

  @override
  State<StudentEnrolledSection> createState() => _StudentEnrolledSectionState();
}

class _StudentEnrolledSectionState extends State<StudentEnrolledSection> {
  final _studentEnrollCubit = DiContainer().sl<StudentEnrollmentCubit>();
  final _authCubit=DiContainer().sl<AuthenticationCubit>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        if(_studentEnrollCubit.selectedEnrollment.isNotEmpty && (_authCubit.userModel!.role==UserRole.admin|| _authCubit.userModel!.role==UserRole.hod))
          ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)==1? SizedBox(): CustomElevatedButton(onPressed: () async {
                  showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                    child: ConfirmationDialog(
                      title: "Move Back?",
                      subText: "${_studentEnrollCubit.selectedEnrollment.length} student(s) will be moved from Sem-${DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)} back to Sem-${DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)-1}",
                      submitText: "Move",
                      onSubmit: () async {
                        var respo=await _studentEnrollCubit.demoteStudent();
                        Navigator.pop(context);
                      },),
                  ));
                },
                  bgColor: AppColor.secondaryColor.withOpacity(.5),
                  showBorder: true,
                  borderColor: AppColor.secondaryColor,
                  text: "Move Back",height: 23,width: 80,fontSize: 10,fontWeight: FontWeight.w500,),
                DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)==8?SizedBox():
                CustomElevatedButton(

                  onPressed: () async {
                  showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                    child: ConfirmationDialog(
                      title: "Move to Sem-${DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)+1}",
                      subText: "${_studentEnrollCubit.selectedEnrollment.length} student(s) will be moved to Sem-${DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)+1}",
                      submitText: "Move",
                      onSubmit: () async {
                        var respo=await _studentEnrollCubit.promoteStudent();
                        Navigator.pop(context);
                      },),
                  ));
                },
                  bgColor: AppColor.primary.withOpacity(.5),
                  showBorder: true,
                  borderColor: AppColor.primary,
                  text: "Move Next",height: 23,width: 80,fontSize: 10,fontWeight: FontWeight.w500,),
              ],
            ),
            SizedBox(height: 10,),],

        if(_authCubit.userModel!.role==UserRole.admin|| _authCubit.userModel!.role==UserRole.hod)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(text: "Students", fontSize: 12, color: AppColor.white),
            InkWell(
              onTap: () {
                _studentEnrollCubit.selectAllEnrollment(
                  _studentEnrollCubit.filterDataList,
                  selectAll: _studentEnrollCubit.selectedEnrollment.isEmpty,
                );
              },
              child: AppText(
                text: _studentEnrollCubit.selectedEnrollment.isNotEmpty
                    ? "Uncheck All (${_studentEnrollCubit.selectedEnrollment.length})"
                    : "Check All",
                fontSize: 12,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        if (_studentEnrollCubit.filterDataList.isNotEmpty)
          ...List.generate(_studentEnrollCubit.filterDataList.length, (index) {
            var model = _studentEnrollCubit.filterDataList.toList()[index];
            return
              _authCubit.userModel!.role!=UserRole.student?
              EnrolledStudentWidget(
              isChecked: _studentEnrollCubit.selectedEnrollment.contains(model),
              onTap: () {
                _studentEnrollCubit.selectEnrollmentStudent(model);
              },
              studentEnrollmentModel: model,
            ):
              StudentRoleEnrollmentWidget(
              isChecked: _studentEnrollCubit.selectedEnrollment.contains(model),
              onTap: () {
                _studentEnrollCubit.selectEnrollmentStudent(model);
              },
              studentEnrollmentModel: model,
            );
          })
        else
          DataNotFoundWidget(
            onTap: () async {
              if(_authCubit.userModel!.role!=UserRole.student){
                await _studentEnrollCubit.get();
                return;
              }

              if (_studentEnrollCubit.submittedData.isAnyNull) {
                showDialog(
                  context: context,
                  builder: (context) => StudentEnrollmentFilterDialog(),
                );
              } else {
                await _studentEnrollCubit.get();
              }
            },
          ),
      ],
    );
  }
}
