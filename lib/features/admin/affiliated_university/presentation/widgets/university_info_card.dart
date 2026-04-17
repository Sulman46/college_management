import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/active_inactive_status_widget.dart';
import '../../../../../widgets/app_text.dart';
import '../../data/models/affiliated_university_details_model.dart';
import 'badge_widget.dart';

class UniversityInfoCard extends StatelessWidget {
  const UniversityInfoCard({super.key,required this.model});
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
      child: Row(
        children: [
          /// LOGO
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: AppText(
                text: model.name[0],
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
              ),
            ),
          ),

          SizedBox(width: 12),

          /// NAME + BADGES
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: model.name,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColor.primary,
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BadgeWidget(text:model.sector, color:AppColor.grey),
                    SizedBox(width: 8),
                    ActiveInactiveStatusWidget(isActive:  model.status == "Active"),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
