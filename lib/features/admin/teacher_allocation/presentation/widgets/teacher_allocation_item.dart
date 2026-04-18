import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/active_inactive_status_widget.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class TeacherAllocationItem extends StatelessWidget {
  const TeacherAllocationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 5, right: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColor.blackShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 TOP ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TITLE + MENU
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            text: "Ali Hassan",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        CustomPopMenuButton(
                          menus: ["Edit", "Delete"],
                          onSelected: (val) {},
                        )
                      ],
                    ),

                    SizedBox(height: 3),

                    /// SUBTITLE
                    AppText(
                      text: "Faculty of Computing",
                      fontSize: 11,
                      color: AppColor.grey,
                    ),

                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 5),

          AppText(text: "Course Details: ",fontSize: 9,color: AppColor.grey.withOpacity(.6),),
          /// ✅ 🔥 NEW SECTION (COURSE DETAILS)
          SizedBox(height: 5),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.bgPrimary
                ),
                child: AppText(
                  text: "OP-01",
                  fontSize: 11,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4),
              AppText(
                text: "OOP",
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.whiteLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.greyLight1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                AppText(
                  text: "BS. Cyber Security",
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Section: A",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.black.withOpacity(.7),
                    ),
                    AppText(
                      text: "Batch: 2022-2026",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.black.withOpacity(.7),
                    ),
                    smallTag("Sem 2"),

                  ],
                ),
                SizedBox(height: 3),
                AppText(
                  text: "Bahauddin Zakariya University (BZU)",
                  fontSize: 11,
                  color: AppColor.grey,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

Widget smallTag(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: AppColor.primary.withOpacity(.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: AppText(
      text: text,
      fontSize: 10,
      color: AppColor.primary,
      fontWeight: FontWeight.w500,
    ),
  );
}
Widget typeTag(String text, {bool isCore = true}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: isCore
          ? AppColor.purple.withOpacity(.1)
          : AppColor.teal.withOpacity(.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: AppText(
      text: text,
      fontSize: 10,
      color: isCore ? AppColor.purple : AppColor.teal,
      fontWeight: FontWeight.w600,
    ),
  );
}