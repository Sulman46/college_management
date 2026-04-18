import 'package:flutter/material.dart';

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class FacultyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColor.bgPrimary,
      padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          AppText(
            text: "Faculty Of Computing",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColor.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AppText(
              text: "1 Teachers",
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
