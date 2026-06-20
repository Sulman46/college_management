import 'package:flutter/material.dart';

import '../../../../../../core/theme/AppColor.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../models/affil/affiliated_details_model.dart';
import '../../../models/affiliation_model.dart';
import 'badge_widget.dart';

class PracticalInfoCard extends StatelessWidget {
  const PracticalInfoCard({super.key,required this.model});
  final AffiliationModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration:AppColor.containerNeon,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Practical Component",
                fontWeight: FontWeight.w600,
              ),
              BadgeWidget(text:"Pass: ${model.practical.passPercentage}%", color:AppColor.primary),
            ],
          ),
          SizedBox(height: 10),

          AppText(
            text: "Max Marks: ${model.practical.maxMarks}",
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
