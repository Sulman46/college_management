import 'package:flutter/material.dart';

import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class StatCardWidget extends StatelessWidget {
  StatCardWidget({super.key,required this.title,required this.color,required this.value});
  String title; String value; Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mdWidth(context) * .28,
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 5),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            textAlign: TextAlign.center,
            text: title,
            fontSize: 10,
            color: AppColor.grey,
          ),
          SizedBox(height: 5),
          AppText(
            text: value,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ],
      ),
    );
  }
}
