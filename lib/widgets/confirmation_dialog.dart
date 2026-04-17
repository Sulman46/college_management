// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:college_management/widgets/app_text.dart';

import '../core/constants/media_query.dart';

import '../core/theme/AppColor.dart';

class ConfirmationDialog extends StatelessWidget {
   ConfirmationDialog({super.key,required this.buttonWidget,required this.title,required this.subText});
String title;
String subText;
Widget buttonWidget;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColor.black,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: mdWidth(context),
          decoration: AppColor.decorationDialog,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(text: "",fontSize: 12,),
                    AppText(text: title,fontSize: 15,color: AppColor.primary,),
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
              AppText(text: subText,fontSize: 11,color: AppColor.black,),
              SizedBox(height: 20,),
              buttonWidget,
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
