import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class AdminProgramWidget extends StatelessWidget {
  const AdminProgramWidget({super.key});

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
                infoItem("SECTION", "A"),
                divider(),
                infoItem("DEGREE", "BS"),
                divider(),
                infoItem("SESSION", "2022-2026"),
              ],
            ),
          ),

          SizedBox(height: 12),

          /// 🔹 MARKS ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Theory: 30/10/60",
                fontSize: 10,
                color: AppColor.grey,
              ),
              AppText(
                text: "Pass: 50%",
                fontSize: 11,
                color: AppColor.primary,
              ),
            ],
          ),

          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Practical: 100 Marks",
                fontSize: 10,
                color: AppColor.grey,
              ),
              AppText(
                text: "Pass: 50%",
                fontSize: 11,
                color: AppColor.primary,
              ),
            ],
          ),

          SizedBox(height: 12),

          Divider(color: AppColor.greyLight1),

          SizedBox(height: 8),

          /// 🔹 UNIVERSITY
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 6, color: AppColor.red),
                    SizedBox(width: 6),
                    Expanded(
                      child: AppText(
                        text: "Bahauddin Zakariya University (BZU)",
                        fontSize: 11,
                        color: AppColor.grey,
                      ),
                    ),
                  ],
                ),
              ),
              ActiveInactiveStatusWidget(isActive: true,),
            ],
          ),
        ],
      ),
    );
  }


}
/// 🔹 SMALL WIDGETS
Widget infoItem(String title, String value) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          AppText(
            text: title,
            fontSize: 9,
            color: AppColor.greyLight,
          ),
          SizedBox(height: 4),
          AppText(
            text: value,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    ),
  );
}

Widget divider() {
  return Container(
    height: 40,
    width: 1,
    color: AppColor.greyLight1,
  );
}
