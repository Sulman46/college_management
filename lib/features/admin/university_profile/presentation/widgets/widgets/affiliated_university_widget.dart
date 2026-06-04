// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/theme/AppColor.dart';
import '../../../../../../widgets/active_inactive_status_widget.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_image_cache.dart';
import '../../../models/affil/affiliated_details_model.dart';
import '../../../models/affil/college_model.dart';
import '../../../models/affiliation_model.dart';
import '../../page/affiliation/affiliated_university_details_screen.dart';
import 'badge_widget.dart';


class AffiliatedUniversityWidget extends StatelessWidget {
AffiliatedUniversityWidget({super.key,required this.model});
AffiliationModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AffiliatedUniversityDetailsScreen(model: model),));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppColor.blackShadow,
        ),
        child: Row(
          children: [


            /// 🔹 NAME + STATUS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: model.name,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      BadgeWidget(text:model.sector, color:AppColor.grey),
                      SizedBox(width: 10,),
                      ActiveInactiveStatusWidget(isActive:  model.status == "Active"),
                    ],
                  ),
                ],
              ),
            ),

            /// 🔹 ARROW
            Icon(Icons.arrow_forward_ios,
                size: 14, color: AppColor.grey),
          ],
        ),
      ),
    );
  }

}