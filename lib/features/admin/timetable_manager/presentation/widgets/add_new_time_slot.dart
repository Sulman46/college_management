import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_button.dart';

class AddNewTimeSlot extends StatelessWidget {
  const AddNewTimeSlot({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(text: "Add Time Slot",fontSize: 15,color: AppColor.black,fontWeight: FontWeight.w600,),
        SizedBox(height: 10,),
        CustomPopMenuButton(menus: ['11:00-12:00','13:00'],title: "Select..",widget: DropDownFieldWidget(text: "Lecture Time", isFilled: true),),
        SizedBox(height: 10,),
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
    );
  }
}
