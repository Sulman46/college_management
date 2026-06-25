import 'package:college_management/core/enums/status_enum.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/university_profile/models/affiliation_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../models/program_request_model.dart';
import '../controller/cubit.dart';

class AdminProgramWidget extends StatelessWidget {
   AdminProgramWidget({super.key,required this.model});
ProgramModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15,left: 5,right: 5),
      padding: EdgeInsets.all(15),
      decoration: AppColor.containerNeon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 TOP ROW (CODE + STATUS)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AppText(
                  text: model.code??"",
                  fontSize: 11,
                  color: AppColor.greyLight,
                ),
              ),


              CustomPopMenuButton(
                menus: ["Edit",model.status==StatusEnum.Active?"Inactive":"Active","Delete"],
                onSelected: (value) async {
                  if(["Edit",model.status==StatusEnum.Active?"Inactive":"Active","Delete"][value]=="Edit"){
                    context.push("/Admin-program-create",extra: model);
                  }else if(value==1){

                    ProgramRequestModel
                    programRequestModel = ProgramRequestModel(
                      name: model.name!,
                      code: model.code!,
                      degree: model.degree!,
                      session: model.session!,
                      section: model.section!,
                      department: model.department!,
                      mids: model.mids!,
                      sessional: model.sessional!,
                      finalMarks: model.finalMarks!,
                      affiliation:AffiliationModel(id: model.affiliationId),
                      practicalMax: model.practicalMax!,
                      practicalPassPercentage: model.practicalPassPercentage!,
                      theoryPassPercentage: model.theoryPassPercentage!,
                      totalTheory: model.totalTheory!,
                      status:model.status==StatusEnum.Active?"Inactive":"Active",
                      id: model.id,
                    );
                    await _programsCubit.updateProgram(programRequestModel);
                  } else{
                    showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                      child: ConfirmationDialog(
                        subText: "This Program will be deleted permanently.",
                        onSubmit: () async {
                        var val=await  _programsCubit.deletePrograms(model);

                          if(val){
                            Navigator.pop(context);
                          }
                        },),
                    ));
                  }
                },),
            ],
          ),

          SizedBox(height: 10),

          /// 🔹 TITLE
          AppText(
            text: model.name!,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),

          SizedBox(height: 4),

          /// 🔹 SUBTITLE
          AppText(
            text: "Dept. of ${model.department!.name}",
            fontSize: 11,
            color: AppColor.grey,
          ),

          SizedBox(height: 12),

          /// 🔹 INFO BOX
          Container(
            decoration: AppColor.containerDecoration,
            child: Row(
              children: [
                infoItem("SECTION", model.section!),
                divider(),
                infoItem("DEGREE", model.degree!),
                divider(),
                infoItem("SESSION", model.session!),
              ],
            ),
          ),

          SizedBox(height: 12),

          /// 🔹 MARKS ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Theory: ${model.mids}(Mid)+${model.sessional}(Sessional)+${model.finalMarks}(Final)=${model.totalTheory}",
                fontSize: 10,
                color: AppColor.greyLight,
              ),
              AppText(
                text: "Pass: ${model.theoryPassPercentage}%",
                fontSize: 11,
                color: AppColor.greyLight,
              ),
            ],
          ),

          SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Practical: ${model.practicalMax} Marks",
                fontSize: 10,
                color: AppColor.greyLight,
              ),
              AppText(
                text: "Pass: ${model.practicalPassPercentage}%",
                fontSize: 11,
                color: AppColor.greyLight,
              ),
            ],
          ),

          SizedBox(height: 12),

          Divider(color: AppColor.greyLight1),

          SizedBox(height: 8),

          /// 🔹 UNIVERSITY
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 6, color: AppColor.red),
                    SizedBox(width: 6),
                    Expanded(
                      child: AppText(
                        text: model.affiliationName!,
                        fontSize: 11,
                        color: AppColor.grey,
                      ),
                    ),
                  ],
                ),
              ),
              ActiveInactiveStatusWidget(isActive:model.status== StatusEnum.Active,),
            ],
          ),
        ],
      ),
    );
  }


}
/// 🔹 SMALL WIDGETS
Widget infoItem(String title, String value) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          AppText(
            text: title,
            fontSize: 9,
            color: AppColor.greyLight,
          ),
          SizedBox(height: 4),
          AppText(
            text: value,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    ),
  );
}

Widget divider() {
  return Container(
    height: 40,
    width: 1,
    color: AppColor.greyLight1,
  );
}
var _programsCubit=DiContainer().sl<AdminProgramsCubit>();
