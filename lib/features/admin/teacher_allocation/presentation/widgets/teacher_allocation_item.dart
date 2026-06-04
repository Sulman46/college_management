import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/features/admin/teacher_allocation/models/teacher_allocation_model.dart';
import 'package:college_management/features/admin/teacher_allocation/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/active_inactive_status_widget.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class TeacherAllocationItem extends StatelessWidget {
   TeacherAllocationItem({super.key,required this.model});
  TeacherAllocationModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 5, right: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppColor.blackShadow,
      ),
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
                            text: model.teacherName??"",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        CustomPopMenuButton(
                          menus: ["Edit", "Delete"],
                          onSelected: (val) async {
                            if(val==0){
                              context.push("/Admin-add-teacher-allocation",extra: model);
                            }else{
                              var allocationCubit=DiContainer().sl<TeacherAllocationCubit>();
                             await allocationCubit.delete(model);
                            }
                          },
                        )
                      ],
                    ),

                    SizedBox(height: 3),

                    /// SUBTITLE
                    AppText(
                      text: model.department??"",
                      fontSize: 11,
                      color: AppColor.grey,
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
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.bgPrimary
                ),
                child: AppText(
                  text: model.courseCode??"",
                  fontSize: 11,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4),
              AppText(
                text: "Type: ${model.allocationType}",
                fontWeight: FontWeight.w600,
                color: AppColor.grey,
                fontSize: 10,
              ),
              SizedBox(width: 10),
              AppText(
                text: "Credit Hour: ${model.creditHours}",
                fontWeight: FontWeight.w600,
                color: AppColor.grey,
                fontSize: 10,
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.whiteLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.greyLight1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                model.combinedPrograms!=null&&model.combinedPrograms!.isNotEmpty?
                Wrap(
                  children: [
                    ...List.generate(model.combinedPrograms?.length??0, (index) => AppText(
                      text: model.combinedPrograms![index],
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),)
                  ],
                ): AppText(
    text: model.programName??"",
      fontWeight: FontWeight.w600,
      fontSize: 13,
    ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Section: ${model.section??""}",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.black.withOpacity(.7),
                    ),
                    AppText(
                      text: "Batch: ${model.batch}",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.black.withOpacity(.7),
                    ),
                    smallTag(model.semester??""),

                  ],
                ),
                SizedBox(height: 3),
                AppText(
                  text: model.affiliation??"",
                  fontSize: 11,
                  color: AppColor.grey,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

Widget smallTag(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: AppColor.primary.withOpacity(.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: AppText(
      text: text,
      fontSize: 10,
      color: AppColor.primary,
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