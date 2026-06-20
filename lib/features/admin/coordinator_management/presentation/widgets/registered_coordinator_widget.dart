import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/hod_assignment/models/hod_assign_model.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class RegisteredCoordinatorWidget extends StatelessWidget {
  RegisteredCoordinatorWidget({super.key,required this.model});
  HodAssignModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: model.teacherName??"",fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w600,),
          SizedBox(height: 3,),
          AppText(text: model.departmentName??"",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
          SizedBox(height: 3,),
          AppText(text: "Assigned Date: ${DateToStringHelper.dateMonthYearConvert(model.assignedDate!)}",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusHodAssignment(text: model.status??"",color: model.status=="Active"?AppColor.green:model.status=="On Leave"? AppColor.red:AppColor.secondaryColor,),
              CustomPopMenuButton(
                menus: ["Edit","Delete"],
                onSelected: (value) async {
                  // if(value==0){
                  //   showDialog(context: context, builder: (context) => AssignHodDepartmentDialog(hodAssignModel: model,),);
                  // }else{
                  //   var hodAssignmentCubit=DiContainer().sl<HODAssignmentCubit>();
                  //   var resp=  await hodAssignmentCubit.delete(model);
                  // }
                },),
            ],
          )
        ],
      ),
    );
  }
}


class StatusHodAssignment extends StatelessWidget {
  StatusHodAssignment({super.key,required this.color,required this.text});
  Color color;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color:color,width: .5),
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text:text,
        fontSize: 10,
        color:color,
      ),
    );
  }
}

