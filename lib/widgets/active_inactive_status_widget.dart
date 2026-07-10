import 'package:flutter/material.dart';

import '../core/theme/AppColor.dart';
import 'app_text.dart';

class ActiveInactiveStatusWidget extends StatelessWidget {
   ActiveInactiveStatusWidget({super.key,required this.isActive, this.text, this.color});
bool isActive;
String? text;
Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color:color??(isActive? AppColor.green:AppColor.red),width: .5),
        color:color!=null? color!.withOpacity(.1): (isActive? AppColor.green.withOpacity(.1):AppColor.red.withOpacity(.1)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: isActive?  text ??"Active":text ??"Inactive",
        fontSize: 10,
        color:color ?? (isActive? AppColor.green:AppColor.red),
      ),
    );
  }
}
