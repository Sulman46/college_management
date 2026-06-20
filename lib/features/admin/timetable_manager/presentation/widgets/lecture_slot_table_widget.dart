// ignore_for_file: non_constant_identifier_names

import 'package:college_management/core/helper/key_generator/time_table_slot_key_generator.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/timetable_manager/data/models/time_period_model.dart';
import 'package:college_management/features/admin/timetable_manager/models/time_table_manger_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/add_lecture_time_slot_dialog.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

class LectureSlotTableWidget extends StatefulWidget {
   LectureSlotTableWidget({super.key,required this.model});
TimeTableManagerModel model;
  @override
  State<LectureSlotTableWidget> createState() => _LectureSlotTableWidgetState();
}

class _LectureSlotTableWidgetState extends State<LectureSlotTableWidget> {

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
          SheetNodeHeadingWidget( text:"Days", color:AppColor.primary,timePeriodList: widget.model.timeSlots??[]),
          ...List.generate(widget.model.days!.length, (index) =>
              SheetNodeSubTextWidget(
                  text: widget.model.days?[index]??"",
                  color: AppColor.primary.withOpacity(.7),
                  timeTableManagerModel: widget.model
              ),),
         ],
      ),
    );
  }
}

Widget SheetNodeHeadingWidget({required String text,required Color color,required List<String> timePeriodList}){
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
          child: AppText(text: "${timePeriodList[index]}",color: AppColor.white,fontSize: 12,),
        ),),
      ],
    ),
  );
}


class SheetNodeSubTextWidget extends StatelessWidget {
   SheetNodeSubTextWidget({super.key,required this.text,required this.color,required this.timeTableManagerModel});
  String text;Color color;
  TimeTableManagerModel timeTableManagerModel;
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
            ...List.generate(timeTableManagerModel.timeSlots?.length??0, (index) {
              String keyVal=generateKeyForTimeSlot(day: text, time: timeTableManagerModel.timeSlots?[index]??"");
              TimeTableCellModel? slotModel=timeTableManagerModel.data![keyVal];
              bool valueExist=slotModel!=null;
              return InkWell(
                onTap: () {
                  showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: AddLectureTimeSlotDialog(timeTableManagerModel: timeTableManagerModel,keyValue: keyVal,)),);
                },
                child: Container(
                  constraints: BoxConstraints(minHeight: 40),
                  width: 140,
                  alignment: Alignment.center,
                  padding: EdgeInsetsGeometry.symmetric(vertical: 5,horizontal: 5),
                  decoration: BoxDecoration(
                    border:index==timeTableManagerModel.timeSlots!.length-1?null: Border(right: BorderSide(color: AppColor.grey.withOpacity(.5),width: 1),),
                    color:!valueExist? AppColor.greyLight.withOpacity(.8): AppColor.white,
                  ),
                  child: !valueExist? Icon(Icons.add,color: AppColor.whiteLight,size: 17,):Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(text: slotModel.teacher??"",color: AppColor.secondaryColor,fontSize: 11,),
                      AppText(text: slotModel.subject??"",color: AppColor.secondaryColor,fontSize: 10,),
                      AppText(text: "R#${slotModel.room??""}",color: AppColor.secondaryColor,fontSize: 10,),
                    ],
                  ),
                ),
              );
            },),
          ],
        ),
      ),
    );
  }
}



