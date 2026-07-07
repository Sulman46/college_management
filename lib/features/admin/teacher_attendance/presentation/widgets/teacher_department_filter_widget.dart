import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class TeacherDepartmentFilterWidget extends StatelessWidget {
   TeacherDepartmentFilterWidget({super.key,required this.text,this.widget});
final String text;
Widget? widget;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      decoration: AppColor.containerNeon,
      child:widget?? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AppText(text:text,fontSize: 12,color: AppColor.white,overflow: TextOverflow.ellipsis,maxLines: 1,)),
          Icon(Icons.keyboard_arrow_down,size: 17,color: AppColor.white,)
        ],
      ),
    );
  }
}
