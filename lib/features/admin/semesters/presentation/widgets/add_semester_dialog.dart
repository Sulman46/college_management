import 'package:college_management/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';



class AddSemesterDialog extends StatefulWidget {
  const AddSemesterDialog({super.key});

  @override
  State<AddSemesterDialog> createState() => _AddSemesterDialogState();
}

class _AddSemesterDialogState extends State<AddSemesterDialog> {
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
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Department :",
                        fontSize: 12,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 6),

                      CustomPopMenuButton(menus: ['Core','Supporting'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text: 'Select..',maxLine: 1, isFilled: false)),),
                    ],
                  ),
                ),

                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Program :",
                        fontSize: 11,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 6),

                      CustomPopMenuButton(menus: ['Theory','Theory + Lab'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Affiliation :",
                        fontSize: 12,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 6),

                      CustomPopMenuButton(menus: ['Core','Supporting'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                    ],
                  ),
                ),

                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Degree :",
                        fontSize: 11,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 6),

                      CustomPopMenuButton(menus: ['Theory','Theory + Lab'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Session :",
                        fontSize: 12,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 6),

                      CustomPopMenuButton(menus: ['Core','Supporting'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                    ],
                  ),
                ),

                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Section :",
                        fontSize: 11,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 6),

                      CustomPopMenuButton(menus: ['Theory','Theory + Lab'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Semester Level :",
                        fontSize: 12,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 6),

                      CustomPopMenuButton(menus: ['Core','Supporting'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                    ],
                  ),
                ),

                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Status :",
                        fontSize: 11,
                        color: AppColor.grey,
                      ),

                      SizedBox(height: 6),

                      CustomPopMenuButton(menus: ['Active','Inactive'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                    ],
                  ),
                ),
              ],
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
