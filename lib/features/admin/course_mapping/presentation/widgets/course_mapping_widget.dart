import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/active_inactive_status_widget.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class CourseMappingWidget extends StatelessWidget {
   CourseMappingWidget({super.key,required this.model});
CourseMappingModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 5, right: 5),
      padding: EdgeInsets.all(12),
      decoration:AppColor.containerNeon,
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
                            text: model.program??"",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        CustomPopMenuButton(
                          menus: ["Edit",model.status=="Active"?"Inactive":"Active", "Delete"],
                          onSelected: (val) async {
                            if(val==0){
                              context.push('/Admin-add-course-mapping',extra: model);
                            }else if(val==1){
                              var courseMapping=DiContainer().sl<CourseMappingCubit>();
                              model=model.copyWith(status:model.status=="Active"?"Inactive":"Active" );
                             await courseMapping.update(model);
                            }
                            else{
                              var courseMapping=DiContainer().sl<CourseMappingCubit>();
                              await courseMapping.delete(model);
                            }
                          },
                        )
                      ],
                    ),

                    SizedBox(height: 3),

                    /// SUBTITLE
                    AppText(
                      text: "Faculty of ${model.department??""}",
                      fontSize: 11,
                      color: AppColor.grey,
                    ),

                    SizedBox(height: 6),

                    /// INLINE INFO
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: [
                        smallTag("${model.degree??""}"),
                        smallTag("${model.session??""}"),
                        smallTag("Section ${model.section??""}"),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// COURSE NAME
                AppText(
                  text: model.courseTitle??"",
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),

                SizedBox(height: 4),

                /// CODE + CH
                AppText(
                  text: model.courseCode??"",
                  fontSize: 11,
                  color: AppColor.greyLight,
                  fontWeight: FontWeight.w500,
                ),

                SizedBox(height: 3),

                /// TYPE + CATEGORY
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: model.courseType??"",
                      fontSize: 10,
                      color: AppColor.grey,
                    ),
                    typeTag(model.courseCategory??"", isCore: true),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Divider(color: AppColor.greyLight1),

          SizedBox(height: 3),

          /// 🔹 UNIVERSITY
          Container(
            margin: EdgeInsets.only(top: 3,bottom: 3),
            child: AppText(
              text: model.affiliation??"",
              fontSize: 11,
              color: AppColor.grey,
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smallTag("S${model.semesterName??""}"),
              ActiveInactiveStatusWidget(isActive: model.status=="Active"),
            ],
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
      color: AppColor.greyLight,
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