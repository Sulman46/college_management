import 'package:college_management/features/admin/university_profile/models/attendance_policy_model.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/app/di_container.dart';
import '../../../../../../core/theme/AppColor.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/confirmation_dialog.dart';
import '../../../../../../widgets/custom_animated_dialog.dart';
import '../../../models/university_model.dart';
import '../../controller/cubit.dart';
import 'add_attendance_alert_dialog.dart';

class AttendanceAlertCardWidget extends StatelessWidget {
   AttendanceAlertCardWidget({super.key,required this.model});
AttendancePolicyModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
      decoration: AppColor.containerNeon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.primary.withOpacity(.2),
                  border: Border.all(width: 1,color: AppColor.primary),

                ),
                child: AppText(text: model.tag,fontSize: 11,color: AppColor.greyLight,),
              ),
              SizedBox(width: 5,),
              CustomPopMenuButton(menus: ["Edit","Delete"],widget: Icon(Icons.more_vert,size: 15,
                color: AppColor.white,),onSelected: (p0) {
                if(p0==0){
                  showDialog(context: context, builder: (context) => AddAttendanceAlertDialog(attendancePolicyModel:model,),);
                }else{
                  var universitySetupCubit = DiContainer().sl<UniversityProfileCubit>();
                  showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                    child: ConfirmationDialog(title: "Are you sure?", subText: 'This attendance rule will be deleted permanently.',onSubmit: () async {
                      var  temp=universitySetupCubit.universityModel!.attendancePolicyModel??[];
                      temp.removeWhere((element) => element.id==model.id,);
                      UniversityModel uniModel=UniversityModel(attendancePolicyModel: temp);
                      bool val= await universitySetupCubit.addUniversitySetup(uniModel,message: "Data Deleted");                            if(val){
                        Navigator.pop(context);
                      }
                    },),
                  ));



                }
              },)
            ],
          ),
          SizedBox(height: 10,),
          AppText(text: model.title,fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w600,),
          SizedBox(height: 3,),
          Row(
            children: [
              AppText(text: "Action triggers when attendance false: ",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w600,),
              AppText(text: "${model.val}%",fontSize: 12,color: AppColor.red,fontWeight: FontWeight.w600,),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:model.type=="safe"? AppColor.blueLight.withOpacity(.2):model.type=="caution"?AppColor.fieldYellowBorder.withOpacity(.2):AppColor.red.withOpacity(.2),
              border: Border.all(width: 1,color:model.type=="safe"?  AppColor.blueLight:model.type=="caution"?AppColor.fieldYellowBorder:AppColor.red),
            ),
            child: AppText(text: "${model.action}",fontSize: 11,color:model.type=="safe"?  AppColor.blueLight:model.type=="caution"?AppColor.fieldYellowBorder:AppColor.red,),
          ),
         ],
      ),
    );
  }
}
