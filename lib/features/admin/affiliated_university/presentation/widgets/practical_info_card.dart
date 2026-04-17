import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../data/models/affiliated_university_details_model.dart';
import 'badge_widget.dart';

class PracticalInfoCard extends StatelessWidget {
  const PracticalInfoCard({super.key,required this.model});
  final AffiliatedUniversityDetailsModel model;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Practical Component",
                fontWeight: FontWeight.w600,
              ),
              BadgeWidget(text:"Pass: 50%", color:AppColor.primary),
            ],
          ),
          SizedBox(height: 10),

          AppText(
            text: "Max Marks: ${model.practicalMarks}",
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
