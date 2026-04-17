// ignore_for_file: must_be_immutable

import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';


class AppButton extends StatelessWidget {
  AppButton(
      {required this.onPressed,
      required this.text,
      this.textColor,
      this.bgColor,
        this.icon,
        this.widget,
        this.fontSize,
      this.borderColor,
      this.radius,
      this.borderRadius,
      this.textStyle,
      this.height,
      this.width,
      this.fontFamily,
      this.isLoading,
      this.mainAxisSize,
      this.loaderSize,
      this.mainAxisAlignment,
      super.key});
  final VoidCallback onPressed;
  final String text;
   String? fontFamily;
  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  double? borderWidth;
  double? loaderSize;
  bool? isLoading;
  String? icon;
  double? radius;
  TextStyle? textStyle;
  MainAxisAlignment? mainAxisAlignment;
  double? height;
  MainAxisSize? mainAxisSize;
  double? fontSize;
  double? width;
  double? borderRadius;
  Widget? widget;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width??mdWidth(context)*1,
        height:height ??50,
        decoration: BoxDecoration(
          color: bgColor??AppColor.primary,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            border: Border.all(width: 1, color: borderColor ??AppColor.primary)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:mainAxisAlignment?? MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget??SizedBox(),
            isLoading==true? SizedBox(
                height: loaderSize,
                width: loaderSize,
                child: CircularProgressIndicator(color: AppColor.white)): AppText(
              text: text,
              color: textColor,
              fontWeight: FontWeight.w400,
              
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}
