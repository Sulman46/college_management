// ignore_for_file: must_be_immutable

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

class FilterButtonWidget extends StatelessWidget {
   FilterButtonWidget({super.key,required this.text, this.onTap,required this.isSelected});
String text;
bool isSelected;
VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(width: .5,color:isSelected? AppColor.primary:AppColor.grey),
          color:isSelected? AppColor.primary.withOpacity(.2): AppColor.grey.withOpacity(.2)
        ),
        child: AppText(text: text,fontSize: 11,color: isSelected? AppColor.primary:AppColor.grey,),
      ),
    );
  }
}
