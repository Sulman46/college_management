import 'package:college_management/features/admin/university_profile/presentation/widgets/widgets/practical_info_card.dart';
import 'package:college_management/features/admin/university_profile/presentation/widgets/widgets/university_info_card.dart';
import 'package:college_management/features/admin/university_profile/presentation/widgets/widgets/url_map.dart';
import 'package:flutter/material.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/affil/affiliated_details_model.dart';

import '../../../models/affiliation_model.dart';
import '../../widgets/widgets/theory_framework_card.dart';

class AffiliatedUniversityDetailsScreen extends StatelessWidget {
  final AffiliationModel model;
  const AffiliatedUniversityDetailsScreen({super.key, required this.model});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          CustomTopBar(text: "Details"),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 HEADER CARD
                  UniversityInfoCard(model: model,),

                  SizedBox(height: 15),

                  /// 🔹 THEORY
                  TheoryFrameworkCard(model: model,),

                  SizedBox(height: 15),

                  /// 🔹 PRACTICAL
                  PracticalInfoCard(model: model),

                  SizedBox(height: 20),

                  /// 🔹 FOOTER CARD
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(15),
                      // boxShadow: AppColor.blackShadow,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: AppColor.grey),
                                SizedBox(width: 5),
                                AppText(
                                  text: model.location,
                                  color: AppColor.grey,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async{
                                  final Uri uri = Uri.parse(model.website);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }

                                // open website
                              },
                              child: AppText(
                                text: "Website",
                                color: AppColor.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        UrlMap(mapUrl: "${model.location}", ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}