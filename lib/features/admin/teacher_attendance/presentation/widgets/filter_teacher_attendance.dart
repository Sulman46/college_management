import 'package:flutter/material.dart';

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class FilterTeacherAttendance extends StatelessWidget {
  const FilterTeacherAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPopMenuButton(menus: ['BSCS','BSIT'],widget:Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1,color: AppColor.white),
                color: AppColor.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: "All Departments",fontSize: 13,color: AppColor.primary,),
                Icon(Icons.keyboard_arrow_down,size: 20,color: AppColor.primary,)
              ],
            ),
          ),),
        ],
      ),
    );
  }
}
