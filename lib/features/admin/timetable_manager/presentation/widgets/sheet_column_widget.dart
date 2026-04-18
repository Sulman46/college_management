// ignore_for_file: non_constant_identifier_names

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/timetable_manager/data/models/time_period_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/add_lecture_time_slot_dialog.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

class LectureSheet extends StatefulWidget {
  const LectureSheet({super.key});

  @override
  State<LectureSheet> createState() => _LectureSheetState();
}

class _LectureSheetState extends State<LectureSheet> {
  List<TimePeriodModel> timePeriodList=[
    TimePeriodModel("08:00", "09:00"),
    TimePeriodModel("09:00", "10:00"),
    TimePeriodModel("10:00", "11:00"),
    TimePeriodModel("11:00", "12:00"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(width: 1,color: AppColor.grey.withOpacity(.5)),
            right: BorderSide(width: 1,color: AppColor.grey.withOpacity(.5)),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetNodeHeadingWidget( text:"Days", color:AppColor.primary,timePeriodList: timePeriodList),
          SheetNodeSubTextWidget(text: "Monday",color: AppColor.primary.withOpacity(.7),listLength:timePeriodList.length),
          SheetNodeSubTextWidget(text: "Tuesday",color: AppColor.primary.withOpacity(.7),listLength:timePeriodList.length),
          SheetNodeSubTextWidget(text: "Wednesday",color: AppColor.primary.withOpacity(.7),listLength:timePeriodList.length),
          SheetNodeSubTextWidget(text: "Thursday",color: AppColor.primary.withOpacity(.7),listLength:timePeriodList.length),
          SheetNodeSubTextWidget(text: "Friday", color:AppColor.primary.withOpacity(.7),listLength:timePeriodList.length),
          SheetNodeSubTextWidget(text: "Saturday",color: AppColor.primary.withOpacity(.7),listLength:timePeriodList.length),
          SheetNodeSubTextWidget(text: "Monday", color:AppColor.primary.withOpacity(.7),listLength:timePeriodList.length),
        ],
      ),
    );
  }
}

Widget SheetNodeHeadingWidget({required String text,required Color color,required List<TimePeriodModel> timePeriodList}){
  return IntrinsicHeight(
    child: Row(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: 40),
          width: 140,
          alignment: Alignment.center,
          padding: EdgeInsetsGeometry.symmetric(vertical: 5,),
          decoration: BoxDecoration(
            color: color,
            border: Border(
                right: BorderSide(color: AppColor.grey.withOpacity(.5),width: 1),
                top: BorderSide(color: AppColor.grey.withOpacity(.5),width: 1),
            )
          ),
          child: AppText(text: text,color: AppColor.white,fontSize: 12,),
        ),
        ...List.generate(timePeriodList.length, (index) => Container(
          constraints: BoxConstraints(minHeight: 40),
          width: 140,
          alignment: Alignment.center,
          padding: EdgeInsetsGeometry.symmetric(vertical: 5,),
          decoration: BoxDecoration(
            border:index==timePeriodList.length-1?null: Border(
                right: BorderSide(color: AppColor.grey.withOpacity(.5),width: 1)),
            color: color,
          ),
          child: AppText(text: "${timePeriodList[index].startTime}-${timePeriodList[index].endTime}",color: AppColor.white,fontSize: 12,),
        ),),
      ],
    ),
  );
}


class SheetNodeSubTextWidget extends StatelessWidget {
   SheetNodeSubTextWidget({super.key,required this.text,required this.color,required this.listLength});
  String text;Color color;int listLength;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColor.grey.withOpacity(.5),width: 1))
        ),
        child: Row(
          children: [
            Container(
              constraints: BoxConstraints(minHeight: 40),
              width: 140,
              alignment: Alignment.center,
              padding: EdgeInsetsGeometry.symmetric(vertical: 5,),
              decoration: BoxDecoration(
                color: color,
              ),
              child: AppText(text: text,color: AppColor.white,fontSize: 12,),
            ),
            ...List.generate(listLength, (index) => InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: AddLectureTimeSlotDialog()),);
              },
              child: Container(
                constraints: BoxConstraints(minHeight: 40),
                width: 140,
                alignment: Alignment.center,
                padding: EdgeInsetsGeometry.symmetric(vertical: 5,),
                decoration: BoxDecoration(
                  border:index==listLength-1?null: Border(right: BorderSide(color: AppColor.grey.withOpacity(.5),width: 1),),
                  color:index!=0? AppColor.bgPrimary.withOpacity(.8): AppColor.white.withOpacity(.5),
                ),
                child:index!=0? Icon(Icons.add):Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: "Hassan Ali",color: AppColor.grey,fontSize: 11,),
                    AppText(text: "Physics",color: AppColor.grey,fontSize: 11,),
                    AppText(text: "R#5",color: AppColor.grey,fontSize: 11,),
                  ],
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}

