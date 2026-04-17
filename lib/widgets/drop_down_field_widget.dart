// ignore_for_file: must_be_immutable

import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_text_style.dart';
import '../core/theme/AppColor.dart';

class DropDownFieldWidget extends StatelessWidget {
   DropDownFieldWidget({super.key,required this.text,this.maxLine,required this.isFilled});
String text;
bool isFilled;
int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
      decoration: BoxDecoration(
        color: AppColor.primary.withOpacity(.1),
          borderRadius: BorderRadius.circular(8),
          border:  Border.all(color:AppColor.primary.withOpacity(.5),width: .5)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AppText(text: text,maxLines: maxLine??1,style:isFilled? AppTextStyle.fieldTextStyle():AppTextStyle.hintTextStyle(),)),
          Icon(Icons.navigate_next,size: 20,color: AppColor.grey.withOpacity(.7),),
        ],
      ),
    );
  }
}
