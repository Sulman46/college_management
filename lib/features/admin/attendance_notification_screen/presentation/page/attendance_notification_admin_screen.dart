import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';

class AttendanceNotificationAdminScreen extends StatelessWidget {
  const AttendanceNotificationAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTopBar(text: "Attendance"),
          Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: screenPaddingHori),
          child: Column(
            children: [
              SizedBox(height: 20,),

              Align(
                  alignment: AlignmentGeometry.center,
                  child: AppText(text: "Attendance Escalation",fontSize: 15,color: AppColor.primary,fontWeight: FontWeight.w600,)),

              Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: AppText(text: "Manage Automated trigger for attendance warnings and terminations.",fontSize: 12,color: AppColor.grey)),
              SizedBox(height: 19,),

              Container(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.white,
                  boxShadow: AppColor.blackShadow
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.primary.withOpacity(.2),
                        border: Border.all(width: 1,color: AppColor.primary),

                      ),
                      child: AppText(text: "Initials",fontSize: 11,color: AppColor.primary,),
                    ),
                    SizedBox(height: 10,),
                    AppText(text: "First Warning Notification",fontSize: 12,color: AppColor.black,fontWeight: FontWeight.w600,),
                   SizedBox(height: 3,),
                    Row(
                      children: [
                        AppText(text: "Action triggers when attendance false:  ",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w600,),
                        AppText(text: "75%",fontSize: 12,color: AppColor.red,fontWeight: FontWeight.w600,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Align(
                        alignment: Alignment.centerRight,
                        child: CustomElevatedButton(onPressed: (){}, text: "Send To Student",height: 30,width: 150,fontSize: 12,bgColor: AppColor.red.withOpacity(.6),showBorder: true,borderWidth: 1,borderColor: AppColor.red,))
                  ],
                ),
              ),

              SafeArea(
                  top: false,
                  child: SizedBox(height: 20,)),
            ],
          ),),
        ],
      ),
    );
  }
}
