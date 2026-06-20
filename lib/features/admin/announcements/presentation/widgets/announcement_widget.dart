import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/announcements/models/announcement_model.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../course_mapping/presentation/widgets/course_mapping_widget.dart';
import '../controller/cubit.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key,required this.model});
final AnnouncementModel model;
  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  var _announcementCubit=DiContainer().sl<AnnouncementsCubit>();
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
              smallTag(widget.model.priority??""),
              CustomPopMenuButton(
                menus: ["Edit",widget.model.isArchived==true?"Unarchive":"Archive", "Delete"],
                onSelected: (val) async {
                   if(val==0){
                    context.push("/Admin-add-announcement",extra: widget.model);
                  }else if(val==1){
                     AnnouncementModel val= widget.model;
                    if(widget.model.isArchived==true){
                      val=val.copyWith(isArchived: false);
                    }else{
                      val=val.copyWith(isArchived: true);
                    }
                     await _announcementCubit.update(val);
                  } else if(val==2){
                  await _announcementCubit.delete(widget.model);
                  }
                },
              )
            ],
          ),
          SizedBox(height: 8,),
          AppText(text: widget.model.title??"",fontSize: 13,color: AppColor.white,fontWeight: FontWeight.w700,),
          SizedBox(height: 3,),
          InkWell(
              onTap: () {
                setState(() {
                  showFullMessage=!showFullMessage;
                });
              },
              child: AppText(text:widget.model.content??"",maxLines: showFullMessage?null:3,fontSize: 12,color: AppColor.white.withOpacity(.7),textAlign: TextAlign.justify,overflow: showFullMessage?null:TextOverflow.ellipsis,)),
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
                child: AppText(text: widget.model.postedBy?.toUpperCase()[0]??"",fontSize: 13,color: AppColor.white,),
              ),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: widget.model.postedBy??"",fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w600,),
                  AppText(text: widget.model.date??"",fontSize: 10,color: AppColor.grey,fontWeight: FontWeight.w500,),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
