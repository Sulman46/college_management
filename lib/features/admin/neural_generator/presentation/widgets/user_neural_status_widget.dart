import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';


class UserNeuralStatusWidget extends StatelessWidget {
  UserNeuralStatusWidget({super.key,required this.status});
  String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color:status=="Active"? AppColor.green:AppColor.red,width: .5),
        color: status=="Active"? AppColor.green.withOpacity(.1):AppColor.red.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text:status=="Active"?  "Active":status=="Inactive"?"Inactive":"Blocked",
        fontSize: 10,
        color:status=="Active"? AppColor.green:AppColor.red,
      ),
    );
  }
}
