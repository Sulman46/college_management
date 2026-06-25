import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_model.dart';
import 'package:college_management/features/admin/student_registrations/models/student_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';

class EnrolledStudentWidget extends StatelessWidget {
   EnrolledStudentWidget({super.key, this.studentEnrollmentModel, this.studentModel, this.onTap, this.isChecked, this.canCheck=true});
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
                  AppText(text: "Reg-No: ${studentModel?.registrationNumber?? studentEnrollmentModel?.srNo??""}",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),
                  SizedBox(height: 5,),
                  AppText(text: "Roll-No: ${studentModel?.rollNo?? studentEnrollmentModel?.rollNo??""}",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),

                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                canCheck? InkWell(
                    onTap: onTap,
                    child: Icon(isChecked==true? Icons.check_box_rounded:Icons.check_box_outline_blank,size: 20,color:isChecked==true? AppColor.white.withOpacity(.8):AppColor.grey.withOpacity(.8),)):SizedBox(),
                ActiveInactiveStatusWidget(isActive: true),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
