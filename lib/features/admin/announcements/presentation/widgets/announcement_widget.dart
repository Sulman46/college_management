import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../course_mapping/presentation/widgets/course_mapping_widget.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  bool showFullMessage=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5,vertical:10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide(color: AppColor.primary,width: 1.5),
        ),
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smallTag("Urgent"),
              CustomPopMenuButton(
                menus: ["Edit",'Download PDF', "Delete"],
                onSelected: (val) {},
              )
            ],
          ),
          SizedBox(height: 8,),
          AppText(text: "Scholarship Applications",fontSize: 13,color: AppColor.black,fontWeight: FontWeight.w700,),
          SizedBox(height: 3,),
          InkWell(
              onTap: () {
                setState(() {
                  showFullMessage=!showFullMessage;
                });
              },
              child: AppText(text: "We are pleased to inform all students that important academic updates have been released. Please check your student portal regularly to stay informed about schedules, deadlines, and upcoming activities.",maxLines: showFullMessage?null:3,fontSize: 12,color: AppColor.black.withOpacity(.7),textAlign: TextAlign.justify,overflow: showFullMessage?null:TextOverflow.ellipsis,)),
          SizedBox(height: 10,),
          Divider(height: 1,color: AppColor.greyLight1,),
          SizedBox(height: 7,),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.purple,
                ),
                child: AppText(text: "M",fontSize: 13,color: AppColor.white,),
              ),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "Muneeba Hameed",fontSize: 12,color: AppColor.black,fontWeight: FontWeight.w600,),
                  AppText(text: "Mar 18,2026",fontSize: 10,color: AppColor.grey,fontWeight: FontWeight.w500,),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
