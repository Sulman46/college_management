import 'package:college_management/features/admin/pay_roll_and_salary_management/presentation/widgets/payroll_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class PayrollFilterSectionDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColor.bgPrimary,
      padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(text: "Billings",fontSize: 13,color: AppColor.grey,),
          InkWell(
            onTap: () {
              showModalBottomSheet(context: context, builder: (context) => PayrollFilterBottomSheet(),);
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: AppColor.primary),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.filter_list,size: 15,color: AppColor.primary,),
                  // SizedBox(width: 5,),
                  // AppText(text: "Filter",fontSize: 10,color: AppColor.grey,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
