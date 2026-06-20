import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class CatalogDepartWidget extends StatelessWidget {
   CatalogDepartWidget({super.key,required this.text,required this.onTap});
String text;
VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 5,top: 5),
        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColor.primary.withOpacity(.3),
            border: Border.all(width: 1,color: AppColor.primary.withOpacity(.5))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close,color: AppColor.white,size: 13,),
            SizedBox(width: 2,),
            AppText(text: text,fontSize: 11,color: AppColor.white.withOpacity(.7),),
          ],
        ),
      ),
    );
  }
}
