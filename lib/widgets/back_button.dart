import 'package:college_management/core/theme/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/app_assets.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? icon;
  const BackButtonWidget({this.onTap, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColor.transparent,
      hoverColor: AppColor.transparent,
      onTap: onTap ??
          () {
            // context.router.maybePop();
          },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: .5,color: AppColor.grey)
        ),
        child:Icon(Icons.arrow_back_ios_new,size: 15,)
        // SvgPicture.asset(
        //   icon ?? AppAssets.backArrow,
        // ),
      ),
    );
  }
}
