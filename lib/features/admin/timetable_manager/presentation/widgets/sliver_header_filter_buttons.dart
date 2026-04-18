import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class SliverHeaderFilterButtons extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 49;

  @override
  double get maxExtent => 49;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: AppColor.bgPrimary
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColor.white,
              borderRadius: BorderRadius.circular(8)
            ),
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: screenPaddingHori-5),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(child: CustomPopMenuButton(menus: ['Sheet 1','Sheet 2','Sheet 3'],widget: DropDownFieldWidget(text:"Sheet..", isFilled: true),)),
                SizedBox(width: 10,),
                Expanded(child: CustomPopMenuButton(menus: ['Sheet 1','Sheet 2','Sheet 3'],widget: DropDownFieldWidget(text:"Dept..", isFilled: true),)),
                SizedBox(width: 10,),
                Expanded(child: CustomPopMenuButton(menus: ['Sheet 1','Sheet 2','Sheet 3'],widget: DropDownFieldWidget(text:"Session..", isFilled: true),)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}