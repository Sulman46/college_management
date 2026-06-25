import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/models/coordinator_register_model.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CoordinatorProgramWidget extends StatelessWidget {
   CoordinatorProgramWidget({super.key,required this.text,this.status=true});
String  text;
bool status;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
      decoration: BoxDecoration(
        color:AppColor.bgPrimary.withOpacity(.5), // glass tint
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color:status? AppColor.primary.withOpacity(.5):AppColor.red.withOpacity(.5),
          width: .5,
        ),
      ),
      child: AppText(text:text ,fontSize: 10,color: AppColor.greyLight,),
    );
  }
}
