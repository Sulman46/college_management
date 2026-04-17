import 'dart:ui';
import 'package:college_management/core/constants/app_assets.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/AppColor.dart';
import '../../../../widgets/custom_button.dart';

class LogoutAppSheet extends StatelessWidget {
  const LogoutAppSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX:5,sigmaY:5 ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: screenPaddingHori),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30,),
            Image.asset(AppAssets.appLogo,width: 100,height: 100,),
            SizedBox(height: 30,),
            AppText(text: "Logout",fontSize: 25,fontWeight: FontWeight.w600,color: AppColor.black,),
            AppText(text: "Are you sure you want to log out?",fontSize: 22,textAlign: TextAlign.center,color: AppColor.grey,),

            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  height: 40,
                  width: 120,
                  onPressed: (){
                    Navigator.pop(context);
                  }, text: "Cancel",textColor: AppColor.white,bgColor: AppColor.greyLight1,fontWeight: FontWeight.w600,),

                CustomElevatedButton(
                  height: 40,
                  width: 120,
                  onPressed: ()async{}, text: "Logout",textColor: AppColor.white,fontWeight: FontWeight.w600,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

