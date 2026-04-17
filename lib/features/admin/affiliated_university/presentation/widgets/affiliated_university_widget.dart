// ignore_for_file: must_be_immutable

import 'package:college_management/features/admin/affiliated_university/data/models/affiliated_university_details_model.dart';
import 'package:college_management/features/admin/affiliated_university/presentation/page/affiliated_university_details_screen.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_image_cache.dart';
import '../../data/models/affiliated_university_model.dart';

class AffiliatedUniversityWidget extends StatelessWidget {
   const AffiliatedUniversityWidget({super.key,required this.model});
 final CollegeModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AffiliatedUniversityDetailsScreen(model: AffiliatedUniversityDetailsModel(name: model.name, status: model.status, sector: "Public Sector", location: "Multan", website: "https://www.google.com/", mids: 20, sess: 30, finalMarks: 50, practicalMarks: 50)),));
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
            /// 🔹 IMAGE
            CustomImageCache(url: AppAssets.profileImage,height: 50,width: 50,),

            SizedBox(width: 12),

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
                  ActiveInactiveStatusWidget(isActive:  model.status == "Active"),
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
