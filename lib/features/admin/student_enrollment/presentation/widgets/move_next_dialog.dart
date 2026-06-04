import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class MoveNextDialog extends StatelessWidget {
  const MoveNextDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDialog(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(text: "Move to Next",fontSize: 15,color: AppColor.primary,fontWeight: FontWeight.w600,),
        SizedBox(height: 15),
        CustomPopMenuButton(menus: ['Theory','Theory + Lab'],title: "Select Target Section",offset: Offset(0, 30),widget: SizedBox(
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
