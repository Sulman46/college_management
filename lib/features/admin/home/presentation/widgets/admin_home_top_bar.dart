// ignore_for_file: must_be_immutable

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../announcements/presentation/page/announcement_screen.dart';


class AdminHomeTopBar extends StatelessWidget {
  AdminHomeTopBar({super.key,});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,),
      decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
      ),
      child: Column(
        children: [
          SafeArea(bottom: false,child: SizedBox(),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(onTap:() {
                Scaffold.of(context).openDrawer();
              },child:  FaIcon(FontAwesomeIcons.bars,size: 18,color: AppColor.white,)),
              AppText(text:"Dashboard",fontSize: 13,color: AppColor.white,),

              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnnouncementScreen()),
                    );
                  } ,
                  child: Icon(Icons.notifications_active,color: AppColor.white,size: 15,)),
            ],
          ),

          SizedBox(height: 10,),

        ],
      ),
    );
  }
}
