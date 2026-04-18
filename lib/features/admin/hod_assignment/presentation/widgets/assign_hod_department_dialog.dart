import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';

class AssignHodDepartmentDialog extends StatefulWidget {
  const AssignHodDepartmentDialog({super.key});

  @override
  State<AssignHodDepartmentDialog> createState() =>
      _AssignHodDepartmentDialogState();
}

class _AssignHodDepartmentDialogState extends State<AssignHodDepartmentDialog> {
  String date = "DD/MM/YYYY";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: screenPaddingHori - 3),
      backgroundColor: AppColor.bgPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                  text: "Assign Dept HOD",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: AppColor.grey),
                ),
              ],
            ),

            SizedBox(height: 10),
            CustomPopMenuButton(
              menus: ['Hassan', 'Ali', 'Bilal', 'Kashif'],
              offset: Offset(0, 30),
              widget: DropDownFieldWidget(
                text: "Select..",
                maxLine: 1,
                isFilled: false,
              ),
              title: "Faculty Teacher",
            ),

            SizedBox(height: 10),
            CustomPopMenuButton(
              menus: ['BSIT', 'English', 'Eco'],
              offset: Offset(0, 30),
              widget: DropDownFieldWidget(
                text: "Select..",
                maxLine: 1,
                isFilled: false,
              ),
              title: "Assign to Department",
            ),

            SizedBox(height: 10),
            InkWell(
              onTap: () async {
                DateTime? val = await AppDatePicker.pickCustomDate(
                  context: context,
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now(),
                  firstDate: DateTime(2000),
                );
                if (val != null) {
                  date = intl.DateFormat('dd/MMM/yyyy').format(val);
                }
              },
              child: DropDownFieldWidget(
                text: date,
                maxLine: 1,
                isFilled: false,
                title: "Date of Assignment",
              ),
            ),
            SizedBox(height: 10),
            CustomPopMenuButton(
              menus: ['Active', 'InActive'],
              offset: Offset(0, 30),
              widget: DropDownFieldWidget(
                text: "Select..",
                maxLine: 1,
                isFilled: false,
              ),
              title: "Status",
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
            ),
          ],
        ),
      ),
    );
  }
}
