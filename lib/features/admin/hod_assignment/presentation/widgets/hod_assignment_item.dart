import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/teacher_records/presentation/page/teacher_record_details_screen.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/more_vert_pop_menu_button.dart';

class HodAssignmentItem extends StatelessWidget {
  const HodAssignmentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherRecordDetailsScreen(),));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: "ALi Hassan",fontSize: 12,color: AppColor.black,fontWeight: FontWeight.w600,),
            SizedBox(height: 3,),
            AppText(text: "Dept. Computer Science",fontSize: 11,color: AppColor.black,fontWeight: FontWeight.w500,),
            SizedBox(height: 3,),
            AppText(text: "Assigned Date: 25 Jun 2026",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActiveInactiveStatusWidget(isActive: true),
                CustomPopMenuButton(
                  menus: ["Edit","Delete"],
                  onSelected: (value) {

                  },),
              ],
            )
          ],
        ),
      ),
    );
  }
}
