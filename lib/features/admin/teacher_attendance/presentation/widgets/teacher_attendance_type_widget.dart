import 'package:flutter/material.dart';

import '../../../../../core/constants/constant_data.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class TeacherAttendanceTypeWidget extends StatelessWidget {
   TeacherAttendanceTypeWidget({super.key,required this.text,required this.isSelected});
String text;
bool isSelected;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected?AppColor.primary.withOpacity(.3):AppColor.bgPrimary,
          border: Border.all(width: 1,color: AppColor.primary.withOpacity(.5))
      ),
      padding: EdgeInsets.symmetric(horizontal: 5,vertical:3),
      margin: EdgeInsets.only(right: 5),
      child: AppText(text: text),
    );
  }
}
