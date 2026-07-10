import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/features/admin/departments/data/model/request_new_department_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../../data/model/department_model.dart';
import '../controller/cubit.dart';
import 'add_department_dialog.dart';

class DepartmentItemWidget extends StatelessWidget {
  final DepartmentModel model;
final bool canEdit;
  const DepartmentItemWidget({
    super.key,
    required this.model,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: AppColor.containerNeon,
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
              !canEdit?SizedBox():
              CustomPopMenuButton(
                menus: ["Edit",model.status==DepartmentStatus.Active?"Inactive":"Active","Delete"],
                onSelected: (value) async {
                if (value == 0){
                  showDialog(context: context, builder: (context) => AddDepartmentDialog(editDepartmentModel: model,),);

                }else if(value==1){
                  var _departmentCubit = DiContainer().sl<AdminDepartmentCubit>();
                  RequestNewDepartmentModel requestModel=RequestNewDepartmentModel(name: model.name, code: model.code, status:model.status==DepartmentStatus.Active?"Inactive":"Active",id: model.id);
                  var val= await  _departmentCubit.editDepartment( model: requestModel);
                }
                else{
                  showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                    child: ConfirmationDialog(
                      subText: "This Department will be deleted permanently.",
                      onSubmit: () async {
                        var _departmentCubit = DiContainer().sl<AdminDepartmentCubit>();
                        var val= await  _departmentCubit.deleteDepartment(model.id);
                        if(val){
                          Navigator.pop(context);
                          await _departmentCubit.getDepartments();
                        }
                      },
                    ),
                  ));

                }
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