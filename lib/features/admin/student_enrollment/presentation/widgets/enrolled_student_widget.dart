import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';

class EnrolledStudentWidget extends StatelessWidget {
   EnrolledStudentWidget({super.key,required this.studentEnrollmentModel});
  StudentEnrollmentModel studentEnrollmentModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColor.shadowBlack,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: studentEnrollmentModel.name??"",fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w600,),
                  SizedBox(height: 5,),
                  AppText(text: "Reg-No: ${studentEnrollmentModel.srNo??""}",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),
                  SizedBox(height: 5,),
                  AppText(text: "Roll-No: ${studentEnrollmentModel.rollNo??""}",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),

                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.check_box_outline_blank,size: 20,color: AppColor.grey.withOpacity(.8),),
                ActiveInactiveStatusWidget(isActive: true),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
