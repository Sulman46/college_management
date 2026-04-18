import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/add_new_time_slot.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/sheet_column_widget.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/widgets/small_buttons_only_icon.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/custom_animated_dialog.dart';
import 'add_lecture_time_slot_dialog.dart';

class TimeTableSheetWidget extends StatelessWidget {
  const TimeTableSheetWidget({super.key});

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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: AppColor.blackShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          detailTextWidget(text1: "Dept.", text2: "Faculty of Computing"),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              detailTextWidget(text1: "Program.", text2: "BSIT"),
                              SizedBox(width: 10,),
                              detailTextWidget(text1: "Semester.", text2: "1"),
                              SizedBox(width: 10,),
                              detailTextWidget(text1: "Section.", text2: "A"),
                            ],
                          ),
                        SizedBox(height: 5,),
                          detailTextWidget(text1: "Affiliation.", text2: "Bahauddin Zakariya University (BZU)"),
                          SizedBox(height: 5,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: "w.e.f:",fontSize: 12,color: AppColor.primary,),
                              SizedBox(width: 5,),
                              AppText(text: "12 Jul 2026",fontSize: 12,color: AppColor.primary,),

                            ],
                          ),


                        ],
                      ),
                    ),
                        LectureSheet(),

                    Container(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
                      child: Row(
                        children: [
                          SmallButtonsOnlyIcon(icon: Icons.add, onTap: () {
                            showDialog(context: context, builder: (context) => CustomAnimatedDialog(child: AddNewTimeSlot()),);
                          }, color: AppColor.green),
                          SizedBox(width: 15,),
                          SmallButtonsOnlyIcon(icon: Icons.remove, onTap: () {}, color: AppColor.orange),
                          SizedBox(width: 15,),
                          SmallButtonsOnlyIcon(icon: Icons.insert_drive_file_sharp, onTap: () {}, color: AppColor.blue),
                          SizedBox(width: 15,),
                          SmallButtonsOnlyIcon(icon: Icons.delete, onTap: () {}, color: AppColor.red),
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
      AppText(text: text2,fontSize: 12,color: AppColor.black.withOpacity(.8),),

    ],
  );
}
