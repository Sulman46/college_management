import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../data/model/department_model.dart';

class DepartmentItemWidget extends StatelessWidget {
  final DepartmentModel model;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DepartmentItemWidget({
    super.key,
    required this.model,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColor.blackShadow,
      ),
      child: Row(
        children: [
          /// 🔹 DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: model.name,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                SizedBox(height: 4),
                AppText(
                  text: "Code: ${model.code}",
                  fontSize: 12,
                  color: AppColor.grey,
                ),
                SizedBox(height: 2),
                AppText(
                  text: DateToStringHelper.dateMonthYearConvert(model.date??DateTime.now()),
                  fontSize: 11,
                  color: AppColor.greyLight,
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPopMenuButton(
                menus: ["Edit","Delete"],
                onSelected: (value) {
                if (value == 0) onEdit();
                if (value == 1) onDelete();
              },),
              SizedBox(height: 20,),
              ActiveInactiveStatusWidget(isActive: model.status==DepartmentStatus.Active),
            ],
          ),
        ],
      ),
    );
  }
}