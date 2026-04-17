import 'package:college_management/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';



class AddDepartmentDialog extends StatefulWidget {
  const AddDepartmentDialog({super.key});

  @override
  State<AddDepartmentDialog> createState() => _AddDepartmentDialogState();
}

class _AddDepartmentDialogState extends State<AddDepartmentDialog> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String status = "Active";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 13),
      backgroundColor: AppColor.bgPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:10,vertical: 15),
        decoration: AppColor.decorationDialog,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "Register Academic Unit",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: AppColor.grey),
                )
              ],
            ),

            SizedBox(height: 20),

            /// 🔹 DEPARTMENT CODE
            AppText(
              text: "DEPARTMENT ID CODE :",
              fontSize: 11,
              color: AppColor.grey,
            ),
            SizedBox(height: 6),

            CustomTextFormField(
              controller: codeController,
              subTitle: "e.g., CS-IQ",
              isHintText: true,
            ),

            SizedBox(height: 5),

            /// 🔹 ERROR TEXT
            AppText(
              text:
              "Provide a unique identifier (e.g., CS, MATH, PHY)",
              fontSize: 11,
              color: AppColor.red,
            ),

            SizedBox(height: 15),

            /// 🔹 NAME
            AppText(
              text: "OFFICIAL DEPARTMENT NAME :",
              fontSize: 11,
              color: AppColor.grey,
            ),
            SizedBox(height: 6),

            CustomTextFormField(
              controller: nameController,
              subTitle: "e.g., Faculty of Computing",
              isHintText: true,
            ),

            SizedBox(height: 15),
            AppText(
              text: "STATUS :",
              fontSize: 11,
              color: AppColor.grey,
            ),

            SizedBox(height: 6),

            /// 🔹 STATUS
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color:AppColor.primary.withOpacity(.5),width: .5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: PopupMenuButton<String>(
                offset: Offset(1, 30),
                color: AppColor.white,
                padding: EdgeInsets.zero,
                onSelected: (val) {
                  setState(() {
                    status = val;
                  });
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    height: 30,
                    padding: EdgeInsets.only(left: 10),
                    value: "Active",
                    child: AppText(text: "Active"),
                  ),
                  PopupMenuItem(
                    height: 30,
                    padding: EdgeInsets.only(left: 10),
                    value: "Inactive",
                    child: AppText(text: "Inactive"),
                  ),
                ],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(text: status,style: AppTextStyle.hintTextStyle(),),
                    Icon(Icons.keyboard_arrow_down, color: AppColor.primary),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25),

            /// 🔹 BUTTONS
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    text: "Discard",
                    bgColor: AppColor.white,
                    textColor: AppColor.red,
                    borderColor: AppColor.red,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      // TODO: Submit logic
                    },
                    text: "Save",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
