import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_model.dart';
import 'package:college_management/features/admin/student_registrations/models/student_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/enums/user_enums.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../Authentication/presentation/controller/cubit.dart';

class StudentRoleEnrollmentWidget extends StatelessWidget {
  StudentRoleEnrollmentWidget({super.key, this.studentEnrollmentModel, this.studentModel, this.onTap, this.isChecked, this.canCheck=true});
  StudentEnrollmentModel? studentEnrollmentModel;
  StudentModel? studentModel;
  bool? isChecked;
  VoidCallback? onTap;
  bool canCheck;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: AppColor.containerNeon,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text:studentModel?.name?? studentEnrollmentModel?.name??"",fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w600,),
                  SizedBox(height: 5,),
                  AppText(text: "Reg-No: ${studentModel?.registrationNumber?? studentEnrollmentModel?.srNo??""}",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
                  SizedBox(height: 5,),
                  AppText(text: "Roll-No: ${studentModel?.rollNo?? studentEnrollmentModel?.rollNo??""}",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
                  SizedBox(height: 5,),
                  AppText(text: "Program: ${studentEnrollmentModel?.programName??""}",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
                  SizedBox(height: 5,),
                  AppText(text: "Sem: ${studentEnrollmentModel?.semester??""} | Sec: ${studentEnrollmentModel?.section??""}| Sess: ${studentEnrollmentModel?.session??""}",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),

                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if(_authCubit.userModel!.role==UserRole.admin|| _authCubit.userModel!.role==UserRole.hod)
                  canCheck? InkWell(
                      onTap: onTap,
                      child: Icon(isChecked==true? Icons.check_box_rounded:Icons.check_box_outline_blank,size: 20,color:isChecked==true? AppColor.white.withOpacity(.8):AppColor.grey.withOpacity(.8),)
                  ):SizedBox()
                else
                  SizedBox(),
                ActiveInactiveStatusWidget(isActive: studentEnrollmentModel!.status=="Active",color:studentEnrollmentModel!.status=="Active" || studentEnrollmentModel!.status=="Inactive"?null:AppColor.blueLight ,text: studentEnrollmentModel?.status??"Active",),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
final _authCubit=DiContainer().sl<AuthenticationCubit>();

