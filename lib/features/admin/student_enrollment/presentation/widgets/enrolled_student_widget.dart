import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';

class EnrolledStudentWidget extends StatelessWidget {
  const EnrolledStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColor.blackShadow,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "Ali Hassan",fontSize: 12,color: AppColor.black,fontWeight: FontWeight.w600,),
                  SizedBox(height: 5,),
                  AppText(text: "Reg-No: 3573543",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),
                  SizedBox(height: 5,),
                  AppText(text: "Roll-No: BCTYI-21-21",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),

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
