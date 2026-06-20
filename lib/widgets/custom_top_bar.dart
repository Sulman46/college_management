// ignore_for_file: must_be_immutable

import 'package:college_management/core/constants/app_assets.dart';
import '../core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTopBar extends StatelessWidget {
   CustomTopBar({super.key,required this.text, this.onTap,this.prefix,this.suffix});
String text;
VoidCallback? onTap;
Widget? prefix;
Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenPaddingHori,),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.primary.withOpacity(.8),
            width: .5,
          ),
          color: AppColor.primary.withOpacity(.8),
          gradient: AppColor.topBarGradient,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
      ),
      child: Column(
        children: [
          SafeArea(child: SizedBox(),bottom: false,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prefix??  InkWell(
                splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap:onTap?? () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: AppColor.white,)),
              AppText(text:text,fontSize: 13,color: AppColor.white,),
              suffix?? SizedBox(width: 30,),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
