import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class NeuralUserStatus extends StatelessWidget {
  NeuralUserStatus({super.key,required this.isGenerated});
  bool isGenerated;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color:isGenerated? AppColor.green:AppColor.grey,width: .5),
        color: isGenerated? AppColor.green.withOpacity(.1):AppColor.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text:isGenerated?  "Generated":"Pending",
        fontSize: 10,
        color:isGenerated? AppColor.green:AppColor.whiteLight.withOpacity(.6),
      ),
    );
  }
}
