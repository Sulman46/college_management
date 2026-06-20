// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../core/theme/AppColor.dart';
import '../../../../widgets/app_text.dart';
import '../core/constants/media_query.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown({super.key,this.hintSize=12,required this.text,required this.menus,this.onSelected});
  String text;
  double? hintSize;
  List<String> menus;
  void Function(int)? onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColor.white,
      offset: Offset(0, 50),
      borderRadius: BorderRadius.circular(10),
      splashRadius: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColor.greyLight, width: 1),
      ),
      constraints: BoxConstraints(maxWidth: mdWidth(context)*1,minWidth: mdWidth(context)*.4),

      menuPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      itemBuilder: (context) => [
        ...List.generate(menus.length, (index) => PopupMenuItem(value: index,child:AppText(text: "${menus[index]}",color: AppColor.white,)),)
      ],
      onSelected:onSelected,
      child: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(8),),
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: AppText(text:"$text",fontSize: 12,color: AppColor.primary,)),
              // SvgPicture.asset(AppAssets.downBracketIcon,height: 10,width: 10,)
            ],
          )),
    );
  }
}
