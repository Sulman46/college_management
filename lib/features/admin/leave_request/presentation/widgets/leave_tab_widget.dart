// ignore_for_file: must_be_immutable

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LeaveTabWidget extends StatelessWidget {
   LeaveTabWidget({super.key,required this.isSelected, this.borderRadius,required this.text});

  bool isSelected;
  String text;
   BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isSelected?50:0),
        color:isSelected?  AppColor.primary:AppColor.transparent,
      ),
      child: AppText(text: text,fontSize: 13,color: isSelected? AppColor.white:AppColor.grey,fontWeight: FontWeight.w600,),
    );
  }
}
