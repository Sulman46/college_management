
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/app_widgets_size.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? bgColor;
  String? icon;
  double? radius;
  double? height;
  double? iconHeight;
  double? width;
   String text;
  double? fontSize;
  FontWeight? fontWeight;
  bool? showBorder;
  Color? borderColor;
  double? borderWidth;
  double? loaderSize;
  bool? isLoading;
  Color? iconColor;
  IconData? iconData;
  bool? isActive;

  CustomElevatedButton(
      {required this.onPressed,
      required this.text,
        this.textColor,
  this.showBorder,
  this.isActive=true,
  this.iconHeight,
  this.isLoading,
  this.borderColor,
  this.iconColor,
  this.borderWidth,
        this.fontWeight,
        this.loaderSize,
        this.fontSize,
      this.bgColor,
      this.iconData,
      this.icon,
      this.radius,
      this.height,
      this.width,

      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 35,
      width: width ?? mdWidth(context),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 0),
          backgroundColor: bgColor !=null?bgColor:AppColor.buttonColor,
          shape: RoundedRectangleBorder(
            side:showBorder==true? BorderSide(width: borderWidth??1,color: borderColor??AppColor.black):BorderSide.none,
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
        ),
        onPressed: onPressed,
        icon:icon!=null? SvgPicture.asset(icon ?? '' , color:iconColor??  textColor,):null,
        label:isLoading==true? SizedBox(
            height: loaderSize,
            width: loaderSize,
            child: CircularProgressIndicator(color: AppColor.white)):Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData!=null?Icon(iconData,color:iconColor??  textColor,size: iconHeight,):SizedBox(),
            SizedBox(width: iconData!=null?5:0,),
            AppText(text: text,fontWeight: fontWeight,fontSize: fontSize??14,color: textColor??AppColor.white,),
          ],
        ),
      ),
    );
  }
}

