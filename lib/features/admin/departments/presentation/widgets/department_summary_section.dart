import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class DepartmentSummaryBox extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const DepartmentSummaryBox({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: color.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(.4)),
        ),
        child: Column(
          children: [
            AppText(
              text: "$count",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            SizedBox(height: 5),
            AppText(
              text: title,
              fontSize: 12,
              color: AppColor.grey,
            ),
          ],
        ),
      ),
    );
  }
}