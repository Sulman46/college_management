import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/teacher_records/presentation/page/teacher_record_details_screen.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/more_vert_pop_menu_button.dart';
import 'approved_reject_widget.dart';

class LeaveItem extends StatefulWidget {
  const LeaveItem({super.key});

  @override
  State<LeaveItem> createState() => _LeaveItemState();
}

class _LeaveItemState extends State<LeaveItem> {
  bool showMore=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ApprovedRejectWidget(status: LeaveRequestStatusEnum.approved),
              CustomPopMenuButton(
                menus: ["Edit","Delete"],
                onSelected: (value) {

                },),
            ],
          ),
          SizedBox(height: 5,),
          AppText(text: "ALi Hassan",fontSize: 12,color: AppColor.black,fontWeight: FontWeight.w600,),
          SizedBox(height: 3,),
          AppText(text: "Dept. Computer Science",fontSize: 11,color: AppColor.black,fontWeight: FontWeight.w500,),
          SizedBox(height: 3,),
          AppText(text: "📅 25 Jun 2026 - 26 Jun 2026",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,),
          InkWell(
              onTap: () { 
                setState(() {
                  showMore=!showMore;
                });
              },
              child: AppText(text: "I am writing to request a one-day leave of absence on [Date] due to personal reasons. I have prepared my lesson plans and [mentioned if you've arranged a substitute, e.g., informed Mrs. Smith] to ensure a smooth day in my absence. ",maxLines: showMore==true?null:3,fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,textAlign: TextAlign.justify,overflow: showMore==true?null: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }
}
