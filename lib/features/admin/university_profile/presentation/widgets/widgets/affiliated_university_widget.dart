// ignore_for_file: must_be_immutable

import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/app/di_container.dart';
import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/theme/AppColor.dart';
import '../../../../../../widgets/active_inactive_status_widget.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/confirmation_dialog.dart';
import '../../../../../../widgets/custom_image_cache.dart';
import '../../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../models/affil/affiliated_details_model.dart';
import '../../../models/affil/college_model.dart';
import '../../../models/affiliation_model.dart';
import '../../../models/university_model.dart';
import '../../controller/cubit.dart';
import '../../page/affiliation/add_affiliation_screen.dart';
import '../../page/affiliation/affiliated_university_details_screen.dart';
import 'badge_widget.dart';


class AffiliatedUniversityWidget extends StatelessWidget {
AffiliatedUniversityWidget({super.key,required this.model});
AffiliationModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AffiliatedUniversityDetailsScreen(model: model),));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration:AppColor.containerNeon,
        child: Row(
          children: [
            /// 🔹 NAME + STATUS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: model.name,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      BadgeWidget(text:model.sector, color:AppColor.grey),
                      SizedBox(width: 10,),
                      ActiveInactiveStatusWidget(isActive:  model.status == "Active"),
                    ],
                  ),
                ],
              ),
            ),

            /// 🔹 ARROW
            CustomPopMenuButton(widget: Icon(Icons.more_vert,color: AppColor.white,size: 20,),
              menus: ["Edit",(model.status=="Active"?"Inactive":"Active"),"Delete"],onSelected: (p0) async {
                var universityProfileCubit=DiContainer().sl<UniversityProfileCubit>();
                if(p0==0){
                  universityProfileCubit.getUpdateModel(model);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddAffiliationScreen(),));
                }else if(p0==1){
                  model=model.copyWith(status:model.status=="Active"?"Inactive":"Active" );
                  bool val= await universityProfileCubit.updateAffiliation(model,message: "Status Updated");
                }else{
                  showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                    child: ConfirmationDialog(title: "Are you sure?", subText: 'This affiliation will be permanently removed.',onSubmit: () async {

                      bool val= await universityProfileCubit.deletedAffiliation(model);                            if(val){
                        Navigator.pop(context);
                      }
                    },),
                  ));

                }
              },),
          ],
        ),
      ),
    );
  }

}