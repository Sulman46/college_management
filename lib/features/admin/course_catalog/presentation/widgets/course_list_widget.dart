import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../programs/presentation/widgets/admin_program_widget.dart';

class CourseListWidget extends StatelessWidget {
  const CourseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15,left: 5,right: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppColor.blackShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 TOP ROW (CODE + STATUS)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AppText(
                  text: "CC - 01",
                  fontSize: 11,
                  color: AppColor.primary,
                ),
              ),


              CustomPopMenuButton(
                menus: ["Edit","Delete"],
                onSelected: (value) {

                },),
            ],
          ),

          SizedBox(height: 10),

          /// 🔹 TITLE
          AppText(
            text: "Cyber Security",
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),

          SizedBox(height: 4),

          /// 🔹 SUBTITLE
          AppText(
            text: "Dept. of Faculty Of Computing",
            fontSize: 11,
            color: AppColor.grey,
          ),


          SizedBox(height: 12),
          /// 🔹 INFO BOX
          Container(
            decoration: BoxDecoration(
              color: AppColor.whiteLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.greyLight1),
            ),
            child: Row(
              children: [
                infoItem("Credit Hours", "3⏰"),
                divider(),
                infoItem("Type", "Theory + Lab"),
                divider(),
                infoItem("Category", "Core"),
              ],
            ),
          ),


        ],
      ),
    );
  }

}