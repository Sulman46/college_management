import 'package:flutter/material.dart';

import '../../../../../../core/theme/AppColor.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../models/affil/affiliated_details_model.dart';
import '../../../models/affiliation_model.dart';
import 'badge_widget.dart';

class TheoryFrameworkCard extends StatelessWidget {
  const TheoryFrameworkCard({super.key,required this.model});
  final AffiliationModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        // boxShadow: AppColor.blackShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Theory Framework",
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              BadgeWidget(text:"Pass: 50%", color:AppColor.primary),
            ],
          ),

          SizedBox(height: 15),

          /// VALUES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoColumn("Mids", model.theory.mids),
              _infoColumn("Sess",  model.theory.sessional),
              _infoColumn("Final",  model.theory.finalMarks),
            ],
          ),

          SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: AppText(
              text: "Total: ${ model.theory.totalTheory}",
              color: AppColor.grey,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}


Widget _infoColumn(String title, int value) {
  return Column(
    children: [
      AppText(
        text: title,
        color: AppColor.grey,
        fontSize: 12,
      ),
      SizedBox(height: 5),
      AppText(
        text: value.toString(),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ],
  );
}
