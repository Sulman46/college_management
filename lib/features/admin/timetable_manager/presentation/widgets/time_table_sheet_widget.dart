import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/timetable_manager/models/time_table_manger_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/add_new_time_slot.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/remove_slot_dialog.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/small_buttons_only_icon.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/confirmation_dialog.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../controller/cubit.dart';
import 'lecture_slot_table_widget.dart';

class TimeTableSheetWidget extends StatefulWidget {
   TimeTableSheetWidget({super.key,required this.model});
  TimeTableManagerModel model;

  @override
  State<TimeTableSheetWidget> createState() => _TimeTableSheetWidgetState();
}

class _TimeTableSheetWidgetState extends State<TimeTableSheetWidget> {
  final _timeTableCubit=DiContainer().sl<TimetableManagerCubit>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsetsGeometry.symmetric(horizontal: screenPaddingHori-4),
                decoration:AppColor.containerNeon,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          detailTextWidget(text1: "Dept.", text2:widget.model.department??""),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              detailTextWidget(text1: "Program.", text2: widget.model.programName??""),
                              SizedBox(width: 10,),
                              detailTextWidget(text1: "Semester.", text2: widget.model.semesterLevel.toString()),
                              SizedBox(width: 10,),
                              detailTextWidget(text1: "Section.", text2: widget.model.session??""),
                            ],
                          ),
                        SizedBox(height: 5,),
                          detailTextWidget(text1: "Affiliation.", text2:widget.model.affiliation??""),
                          SizedBox(height: 5,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: "w.e.f:",fontSize: 12,color: AppColor.greyLight,),
                              SizedBox(width: 5,),
                              AppText(text: DateToStringHelper.dateMonthYearConvert(widget.model.wefDate!),fontSize: 12,color: AppColor.greyLight,),

                            ],
                          ),


                        ],
                      ),
                    ),
                    LectureSlotTableWidget(model: widget.model,),

                    Container(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
                      child: Row(
                        children: [
                          SmallButtonsOnlyIcon(icon: Icons.add, onTap: () {
                            showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: AddNewTimeSlot(timeTableManagerModel: widget.model,)),);
                          }, color: AppColor.green),
                          if(widget.model.timeSlots!.isNotEmpty)
                          ...[SizedBox(width: 15,),
                          SmallButtonsOnlyIcon(icon: Icons.remove, onTap: () {
                            showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: RemoveSlotDialog(timeTableManagerModel: widget.model,)),);
                          }, color: AppColor.orange),],
                          SizedBox(width: 15,),
                          SmallButtonsOnlyIcon(icon: Icons.insert_drive_file_sharp, onTap: () {}, color: AppColor.blue),
                          SizedBox(width: 15,),
                          SmallButtonsOnlyIcon(icon: Icons.delete,

                              onTap: ()  async {

                                showDialog(context: context, builder: (context) => CustomAnimatedDialog(
                                  child: ConfirmationDialog(
                                    subText: "This Sheet will be deleted permanently.",
                                    onSubmit: () async {
                                   var val=   await _timeTableCubit.delete(widget.model);

                                      if(val){
                                        Navigator.pop(context);
                                      }
                                    },),
                                ));
                          }, color: AppColor.red),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget detailTextWidget({required String text1,required String text2}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText(text: text1,fontSize: 12,color: AppColor.grey,),
      SizedBox(width: 5,),
      AppText(text: text2,fontSize: 12,color: AppColor.white.withOpacity(.8),),

    ],
  );
}
