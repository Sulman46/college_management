import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/models/coordinator_register_model.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/widgets/coordinator_program_widget.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/widgets/coordinator_register_dialog.dart';
import 'package:college_management/features/admin/hod_assignment/models/hod_assign_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class RegisteredCoordinatorWidget extends StatelessWidget {
  RegisteredCoordinatorWidget({super.key,required this.model});
  CoordinatorRegisterModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: AppColor.containerNeon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        /// todo
        children: [
          AppText(text: model.coordinatorName??"",fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w600,),
          SizedBox(height: 3,),
          AppText(text: "${model.designation}",fontSize: 10,color: AppColor.white.withOpacity(.9),),
          SizedBox(height: 3,),
          AppText(text: "Programs:",fontSize: 10,color: AppColor.greyLight,fontWeight: FontWeight.w500,),
          if(model.programs?.isNotEmpty??false)
          ...[SizedBox(height: 3,),
          Wrap(
            children: [
              ...List.generate(model.programs?.length??0, (index) {
                var programModel=model.programs![index];

                return CoordinatorProgramWidget(text: "${programModel.name}, ${programModel.code}, ${programModel.degree}, ${programModel.section}, ${programModel.session}",
                      status: programModel.status=="Active",);
              },)
            ],
          ),
           SizedBox(height: 3,),
          AppText(text: "Departments:",fontSize: 10,color: AppColor.greyLight,fontWeight: FontWeight.w500),
          SizedBox(height: 3,),
          Wrap(
            children: [
              ...List.generate(model.programs?.map((e) => e.department?.name,).toSet().toList().length??0, (index) {
                String? text=model.programs?.map((e) => e.department?.name,).toSet().toList()[index];
                return CoordinatorProgramWidget(text: text??"");
              },)
            ],
          ),
          ],

          SizedBox(height: 5,),
          Divider(color: AppColor.grey.withOpacity(.5),height: .5,thickness: .5,),

          SizedBox(height: 3,),
          AppText(text: "Email: ${model.email}",fontSize: 11,color: AppColor.greyLight,fontWeight: FontWeight.w500,),

          SizedBox(height: 3,),
          AppText(text: "Phone: ${model.phone}",fontSize: 11,color: AppColor.greyLight,fontWeight: FontWeight.w500,),

          SizedBox(height: 3,),
          AppText(text: "CNIC: ${model.cnic}",fontSize: 11,color: AppColor.greyLight,fontWeight: FontWeight.w500,),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActiveInactiveStatusWidget(isActive:model.status=="Active",),
              CustomPopMenuButton(
                menus: ["Edit",model.status=="Active"?"Inactive":"Active","Delete"],
                onSelected: (value) async {
                  if(value==0){
                    showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: CoordinatorRegisterDialog(coordinatorRegisterModel: model,)),);
                  }else if(value==1){
                    final coordinatorCubit=DiContainer().sl<CoordinatorManagementCubit>();
                    model=model.copyWith(status:model.status=="Active"?"Inactive":"Active" );
                  var val=  await coordinatorCubit.update(model);
                  if(val){
                   await coordinatorCubit.get();
                  }
                  }
                  else{
                    final coordinatorCubit=DiContainer().sl<CoordinatorManagementCubit>();
                    showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                      child: ConfirmationDialog(
                        subText: "This Coordinator will be deleted permanently.",
                        onSubmit: () async {
                          var val=await  coordinatorCubit.delete(model);

                          if(val){
                            Navigator.pop(context);
                            await coordinatorCubit.get();
                          }
                        },),
                    ));
                  }
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

