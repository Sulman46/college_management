import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_button.dart';

class AddSheet extends StatelessWidget {
  const AddSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(text: "New Timetable Sheet",fontSize: 15,color: AppColor.primary,),
        SizedBox(height: 10,),
        CustomPopMenuButton(menus: ['Faculty of Computing','Faculty of English'],title: "Department",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
        SizedBox(height: 10,),

        CustomPopMenuButton(menus: ['BSIT','BS English'],title: "Program",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
        SizedBox(height: 10,),

        CustomPopMenuButton(menus: ['A','B'],title: "Section",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
        SizedBox(height: 10,),

        CustomPopMenuButton(menus: ['2024-2026','2025-2027'],title: "Session",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
        SizedBox(height: 10,),

        CustomPopMenuButton(menus: ['1','2'],title: "Active Semester",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
        SizedBox(height: 10,),

        DropDownFieldWidget(
          text: "Select..", isFilled: false,title: "W.E.F Date",),
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
