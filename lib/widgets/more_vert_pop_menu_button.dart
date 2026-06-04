// ignore_for_file: must_be_immutable

import 'package:college_management/core/helper/show_message.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/AppColor.dart';
import '../../../../widgets/app_text.dart';
import '../core/constants/media_query.dart';

class CustomPopMenuButton extends StatelessWidget {
  CustomPopMenuButton({super.key,this.title,this.hintSize=12,this.offset,this.widget,this.iconColor,required this.menus,this.onSelected});
  double? hintSize;
  Offset? offset;
  List<String> menus;
  final String? title;
  Color? iconColor;
  Widget? widget;
  void Function(int)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title!=null)
          ...[
            AppText(
              text: title??"",
              fontSize: 12,
              color: AppColor.grey,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 6),],
        PopupMenuButton(
          color: AppColor.white,
          padding: EdgeInsets.zero,
          offset: offset??Offset(0, 20),
          borderRadius: BorderRadius.circular(10),
          splashRadius: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColor.greyLight, width: 1),
          ),
          constraints: BoxConstraints(maxWidth: mdWidth(context)*1,minWidth: 100),

          itemBuilder: (context) => [
            ...List.generate(menus.length, (index) => PopupMenuItem(
                height: 30,
                padding: EdgeInsets.only(left: 10),
                value: index,child:AppText(text: "${menus[index]}",color:menus[index].toString().toLowerCase()=="delete"? AppColor.red:AppColor.black,fontWeight: FontWeight.w500,)),)
          ],
          onSelected:onSelected,
          child:menus.isEmpty? InkWell(
            onTap: () {
              showMessage("Data is not available");
            },
            child: widget,
          ):widget?? SizedBox(
              width: 20,
              child: Icon(Icons.more_vert,size: 20,color: iconColor??AppColor.grey,)),
        ),
      ],
    );
  }
}
