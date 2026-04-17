// ignore_for_file: must_be_immutable

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
   CustomListTile({super.key,this.suffixIcon,this.onTap,this.verticalPadding,this.prefixIcon,required this.text,this.subtext});
String? prefixIcon;
String text;
String? subtext;
String? suffixIcon;
double? verticalPadding;
VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColor.transparent,
      hoverColor: AppColor.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: verticalPadding??10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 2,color: AppColor.primary)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                prefixIcon==null? SizedBox():SizedBox(
                    width: 23,
                    child: SvgPicture.asset(prefixIcon??"")),
                SizedBox(width: prefixIcon!=null?10:0,),
                Column(
                  children: [
                    AppText(text: text,fontSize: 16,textAlign: TextAlign.center,color: AppColor.grey,fontWeight: FontWeight.w500,),
                    subtext==null? SizedBox():AppText(text: subtext??"",fontSize: 12,textAlign: TextAlign.center,color: AppColor.grey,fontWeight: FontWeight.w500,),
                  ],
                ),
              ],
            ),
            suffixIcon==null? SizedBox():SvgPicture.asset(suffixIcon??""),

          ],
        ),
      ),
    );
  }
}
