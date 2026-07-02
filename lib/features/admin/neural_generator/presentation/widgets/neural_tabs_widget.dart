import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';



class NeuralTabsWidget extends StatelessWidget {
   NeuralTabsWidget({super.key,required this.text,required this.onTap,required this.isSelected});
   String text; bool isSelected; VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal:8,vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:isSelected? AppColor.primary:AppColor.transparent),
        child: AppText(text: text,fontSize: 11,color: isSelected?AppColor.white:AppColor.white,),
      ),
    );
  }
}
