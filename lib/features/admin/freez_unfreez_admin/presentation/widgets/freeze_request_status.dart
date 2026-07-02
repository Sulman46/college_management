import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';


class FreezeRequestStatus extends StatelessWidget {
  FreezeRequestStatus({super.key,required this.status});
  String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color:status=="Approved"? AppColor.green:status=="Pending"? AppColor.blueLight:AppColor.red,width: .5),
        color: status=="Approved"? AppColor.green.withOpacity(.1):status=="Pending"? AppColor.blueLight.withOpacity(.1):AppColor.red.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text:status,
        fontSize: 10,
        color:status=="Approved"? AppColor.green:status=="Pending"? AppColor.blueLight:AppColor.red,
      ),
    );
  }
}
