import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class StudentEnrollmentFilterDialog extends StatelessWidget {
  const StudentEnrollmentFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDialog(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(text: "Filter Students",fontSize: 15,color: AppColor.primary,fontWeight: FontWeight.w600,),
        SizedBox(height: 15),
        CustomPopMenuButton(menus: ['dept1','dept2'],title: "Department",offset: Offset(0, 30),widget: SizedBox(
            width: mdWidth(context),
            child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),

     SizedBox(height: 10),
        CustomPopMenuButton(menus: ['program 1','program 2'],title: "Program",offset: Offset(0, 30),widget: SizedBox(
            width: mdWidth(context),
            child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),

     SizedBox(height: 10),
        CustomPopMenuButton(menus: ['Section 1','Section 2'],title: "Section",offset: Offset(0, 30),widget: SizedBox(
            width: mdWidth(context),
            child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),

     SizedBox(height: 10),
        CustomPopMenuButton(menus: ['Semester 1','Semester 2'],title: "Semester",offset: Offset(0, 30),widget: SizedBox(
            width: mdWidth(context),
            child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),

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
    ));
  }
}
