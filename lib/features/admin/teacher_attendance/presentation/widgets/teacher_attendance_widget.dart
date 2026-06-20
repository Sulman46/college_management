
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/features/admin/teacher_allocation/models/teacher_allocation_model.dart';
import 'package:college_management/features/admin/teacher_allocation/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/active_inactive_status_widget.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../models/teacher_attendance_model.dart';
import '../controller/cubit.dart';

class TeacherAttendanceWidget extends StatefulWidget {
  TeacherAttendanceWidget({super.key,required this.model});
  TeacherAttendanceModel model;

  @override
  State<TeacherAttendanceWidget> createState() => _TeacherAttendanceWidgetState();
}

class _TeacherAttendanceWidgetState extends State<TeacherAttendanceWidget> {

  bool showLess=true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 5, right: 5),
      padding: EdgeInsets.all(12),
      decoration: AppColor.containerNeon,
      child: InkWell(
        onTap: () {
          setState(() {
            showLess=!showLess;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 TOP ROW
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// TITLE + MENU
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText(
                              text: widget.model.teacher??"",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          CustomPopMenuButton(
                            menus: ["Edit", "Delete"],
                            onSelected: (val) async {
                              if(val==0){
                                context.push("/Admin-add-teacher-allocation",extra: widget.model);
                              }else{
                                final _teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();
                                await _teacherAttendanceCubit.delete(widget.model);
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 5),

            AppText(text: "Course Details: ",fontSize: 9,color: AppColor.grey.withOpacity(.6),),
            /// ✅ 🔥 NEW SECTION (COURSE DETAILS)

            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              decoration: AppColor.containerDecoration,
              margin: EdgeInsets.only(bottom:showLess? 0:5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: widget.model.subject??"",
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),

                  Row(
                    children: [
                      SizedBox(height: 3),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      AppText(
                        text: "Type: ${widget.model.attendanceType}",
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyLight,
                        fontSize: 10,
                      ),
                      SizedBox(width: 5),
                      AppText(
                        text: "Slot Time: ${widget.model.slotTime??""}",
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyLight,
                        fontSize: 10,
                      ),
                      SizedBox(width: 5),
                      AppText(
                        text: "Date: ${DateToStringHelper.dateMonthYearConvert(widget.model.date!)}",
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyLight,
                        fontSize: 10,
                      ),
                    ],
                  ),
                  if(!showLess)
                  ...[
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Section: ${widget.model.section??""}",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.white.withOpacity(.7),
                      ),
                      AppText(
                        text: "Batch: ${widget.model.session}",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.white.withOpacity(.7),
                      ),
                      smallTag("Sem. ${widget.model.semesterLevel??""}"),

                    ],
                  ),
                  SizedBox(height: 3),

                  /// SUBTITLE
                  AppText(
                    text: "Dept. ${widget.model.department??""}",
                    fontSize: 11,
                    color: AppColor.greyLight,
                  ),
                  widget.model.combinedPrograms!=null&&widget.model.combinedPrograms!.isNotEmpty?
                  Wrap(
                    children: [
                      ...List.generate(widget.model.combinedPrograms?.length??0, (index) => AppText(
                        text: widget.model.combinedPrograms![index],
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: AppColor.greyLight,
                      ),)
                    ],
                  ): AppText(
                    text: widget.model.programName??"",
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: AppColor.greyLight,
                  ),

                  SizedBox(height: 3),
                  AppText(
                    text: widget.model.affiliation??"",
                    fontSize: 11,
                    color: AppColor.greyLight,
                  ),]
                ],
              ),
            ),
            if(!showLess)
            ...[SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.primary.withOpacity(.3)
                  ),
                  child: AppText(
                    text: "Marked By: ${widget.model.markedBy??""}",
                    fontSize: 11,
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.green.withOpacity(.3)
                  ),
                  child: AppText(
                    text: "${widget.model.status??""}",
                    fontSize: 11,
                    color: AppColor.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )]


          ],
        ),
      ),
    );
  }
}

Widget smallTag(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: AppColor.white.withOpacity(.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: AppText(
      text: text,
      fontSize: 10,
      color: AppColor.white,
      fontWeight: FontWeight.w500,
    ),
  );
}
Widget typeTag(String text, {bool isCore = true}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: isCore
          ? AppColor.purple.withOpacity(.1)
          : AppColor.teal.withOpacity(.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: AppText(
      text: text,
      fontSize: 10,
      color: isCore ? AppColor.purple : AppColor.teal,
      fontWeight: FontWeight.w600,
    ),
  );
}