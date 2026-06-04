import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

class SalaryStatusWidget extends StatelessWidget {
  const SalaryStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1,color: AppColor.primary)
      ),
      child: AppText(text: "Pending",fontSize:10,color: AppColor.primary,),
    );
  }
}
