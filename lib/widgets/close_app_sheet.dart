import 'dart:io';
import 'dart:ui';

import 'package:college_management/core/constants/app_assets.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/AppColor.dart';
import '../../../../widgets/custom_button.dart';
import '../core/constants/app_widgets_size.dart';

class CloseAppSheet extends StatelessWidget {
  const CloseAppSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX:5,sigmaY:5 ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: screenPaddingHori),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColor.grey,width: 1)),
            color: AppColor.bgPrimary,
            borderRadius: BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.appLogo,height: 70,fit: BoxFit.fitHeight,),
            // AppText(text: "Close The App",fontSize: 25,fontWeight: FontWeight.w600,color: AppColor.white,),
            AppText(text: "Do you want to close and exit app",fontSize: 13,textAlign: TextAlign.center,color: AppColor.grey,),

            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 35,
                    fontSize: 12,
                    onPressed: (){
                    Navigator.pop(context);
                    }, text: "CANCEL",textColor: AppColor.white,bgColor: AppColor.greyLight1.withOpacity(.3),fontWeight: FontWeight.w600,),
                ),
                SizedBox(width: 40,),
                Expanded(
                  child: CustomElevatedButton(
                    height: 35,
                    fontSize: 12,
                    onPressed: (){
                    exit(0);
                  }, text: "CONTINUE",textColor: AppColor.white,fontWeight: FontWeight.w600,),
                ),
              ],
            ),
            SafeArea(child: SizedBox(height: 0,)),

          ],
        ),
      ),
    );
  }
}

