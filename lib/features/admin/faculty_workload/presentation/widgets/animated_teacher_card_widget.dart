import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class AnimatedTeacherCardWidget extends StatelessWidget {
  const AnimatedTeacherCardWidget({super.key,required this.index});
final int index;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: _teacherCard(),
    );
  }
}


Widget _teacherCard() {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 5,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔷 NAME + HOURS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Zainab Nasim",
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  text: "Professor",
                  fontSize: 11,
                  color: AppColor.grey,
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: AppText(
                text: "1/16h",
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        SizedBox(height: 15),

        /// 🔷 ENGAGEMENT BOX
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColor.grey.withOpacity(.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "ENGAGEMENT BREAKUP",
                fontSize: 10,
                color: AppColor.grey,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(text: "Faculty Of Computing"),
                  AppText(text: "1 hrs"),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 10),

        /// 🔷 PROGRESS BAR
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "Weekly Capacity Usage",
              fontSize: 10,
              color: AppColor.grey,
            ),
            SizedBox(height: 5),
            LinearProgressIndicator(
              value: 0.06,
              minHeight: 6,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
      ],
    ),
  );
}