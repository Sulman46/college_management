// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:college_management/widgets/app_text.dart';

import '../core/constants/media_query.dart';

import '../core/theme/AppColor.dart';
import 'custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
   ConfirmationDialog({super.key, this.buttonWidget,this.onSubmit, this.title,required this.subText});
String? title;
String subText;
Widget? buttonWidget;
VoidCallback? onSubmit;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: "",fontSize: 12,),
              AppText(text: title??"Are you sure?",fontSize: 15,color: AppColor.white,),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1,color: AppColor.grey
                    ),
                  ),
                  child: Icon(Icons.close,size: 15,color: AppColor.grey,),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        AppText(text: subText,fontSize: 11,color: AppColor.greyLight1,),
        SizedBox(height: 20,),
        buttonWidget??Row(
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
            SizedBox(width: 40,),
            Expanded(
              child: CustomElevatedButton(onPressed:onSubmit??(){}, text: "Delete"),
            ),
          ],
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}
