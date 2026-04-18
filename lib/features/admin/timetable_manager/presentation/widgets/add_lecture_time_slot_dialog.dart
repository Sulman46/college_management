import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../widgets/custom_button.dart';

class AddLectureTimeSlotDialog extends StatefulWidget {
  const AddLectureTimeSlotDialog({super.key});

  @override
  State<AddLectureTimeSlotDialog> createState() => _AddLectureTimeSlotDialogState();
}

class _AddLectureTimeSlotDialogState extends State<AddLectureTimeSlotDialog> {
  TextEditingController roomController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(text: "Add Slot",fontSize: 15,color: AppColor.black,fontWeight: FontWeight.w600,),
        SizedBox(height: 10,),
        CustomPopMenuButton(menus: ['Math','English'],title: "Subject",widget: DropDownFieldWidget(text: "Select..",isFilled: false,),),
        SizedBox(height: 10,),
        CustomPopMenuButton(menus: ['Ali','Asghar'],title: "Instructor",widget: DropDownFieldWidget(text: "Select..",isFilled: false,),),
        SizedBox(height: 10,),
        CustomTextFormField(controller: roomController,
          keyboardType: TextInputType.number,
          subTitle: "e.g. 5",title: "Room",inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],),
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
        )
      ],
    );
  }
}
