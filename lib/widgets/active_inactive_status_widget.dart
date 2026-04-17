import 'package:flutter/material.dart';

import '../core/theme/AppColor.dart';
import 'app_text.dart';

class ActiveInactiveStatusWidget extends StatelessWidget {
   ActiveInactiveStatusWidget({super.key,required this.isActive});
bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color:isActive? AppColor.green:AppColor.red,width: .5),
        color: isActive? AppColor.green.withOpacity(.1):AppColor.red.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text:isActive?  "Active":"Inactive",
        fontSize: 10,
        color:isActive? AppColor.green:AppColor.red,
      ),
    );
  }
}
