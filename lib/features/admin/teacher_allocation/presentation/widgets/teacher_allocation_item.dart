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
   TeacherAllocationItem({super.key,required this.model,required this.canEdit});
  TeacherAllocationModel model;
  bool canEdit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 5, right: 5),
      padding: EdgeInsets.all(12),
      decoration: AppColor.containerNeon,
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
                            fontSize: 12,
                          ),
                        ),
                        if(canEdit)
                        CustomPopMenuButton(
                          menus: ["Edit",model.status=="Active"?"Inactive":"Active", "Delete"],
                          onSelected: (val) async {
                            if(val==0){
                              context.push("/Admin-add-teacher-allocation",extra: model);
                            }else if(val==1){
                              var allocationCubit=DiContainer().sl<TeacherAllocationCubit>();
                              var newModel=model.copyWith(status:model.status=="Active"?"Inactive":"Active");
                              var respos=await allocationCubit.update(newModel);
                              if(respos){
                                await allocationCubit.get();
                              }
                            }
                            else{
                              var allocationCubit=DiContainer().sl<TeacherAllocationCubit>();
                             var respos= await allocationCubit.delete(model);
                              if(respos){
                                await allocationCubit.get();
                              }
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

          Row(
            children: [
              AppText(text: "Course Details: ",fontSize: 9,color: AppColor.white.withOpacity(.6),),
             Spacer(),
              ActiveInactiveStatusWidget(isActive: model.status=="Active"),
            ],
          ),
          /// ✅ 🔥 NEW SECTION (COURSE DETAILS)
          SizedBox(height: 5),
          AppText(
            text: "Name: ${model.courseName}",
            fontWeight: FontWeight.w600,
            color: AppColor.white,
            fontSize: 11,
          ),
          SizedBox(height: 3),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.white.withOpacity(.1)
                ),
                child: AppText(
                  text: model.courseCode??"",
                  fontSize: 11,
                  color: AppColor.greyLight,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(width: 4),
              AppText(
                text: "Credit Hour: ${model.creditHours}",
                fontWeight: FontWeight.w600,
                color: AppColor.grey,
                fontSize: 10,
              ),
              // AppText(
              //   text: " | Type: ${model.allocationType}",
              //   fontWeight: FontWeight.w600,
              //   color: AppColor.grey,
              //   fontSize: 10,
              // ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: AppColor.containerDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                model.combinedPrograms!=null&&model.combinedPrograms!.isNotEmpty?
                Wrap(
                  children: [
                    ...List.generate(model.combinedPrograms?.length??0, (index) => AppText(
                      text: model.combinedPrograms![index],
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),)
                  ],
                ): AppText(
    text: model.programName??"",
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),

                SizedBox(height: 1),

                /// SUBTITLE
                AppText(
                  text: model.department??"",
                  fontSize: 11,
                  color: AppColor.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Section: ${model.section??""}",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.white.withOpacity(.7),
                    ),
                    AppText(
                      text: "Batch: ${model.batch}",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.white.withOpacity(.7),
                    ),
                    smallTag("S${model.semester??""}"),

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
      color: AppColor.whiteLight,
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