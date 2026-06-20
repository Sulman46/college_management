// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class HomeCardsWidget extends StatelessWidget {
  HomeCardsWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  String title;
  IconData icon;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: AppColor.shadowBlack,
          borderRadius: BorderRadius.circular(20),
          color: AppColor.white,
        ),
        child: Stack(
          children: [
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              width: mdWidth(context)*.43,
              decoration: BoxDecoration(
                gradient:  LinearGradient(
                  stops: [.4,.5],
                  colors: [AppColor.primary, AppColor.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.white
                        ),
                        child: Icon(icon,color: AppColor.primary,size: 25,),
                      ),
                    ],
                  ),
                  SizedBox(height: 0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(text: title,fontSize: 13,color: AppColor.white.withOpacity(.5),),
                      // AppText(text: subTitle,fontSize: 10,color: AppColor.greyLight,fontFamily: 'pm',maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
