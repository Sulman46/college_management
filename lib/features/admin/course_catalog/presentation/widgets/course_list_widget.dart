import 'package:college_management/features/admin/course_catalog/models/course_catalog_model.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../programs/presentation/widgets/admin_program_widget.dart';
import '../controller/cubit.dart';
import 'add_new_course_catalog_dialog.dart';

class CourseListWidget extends StatelessWidget {
   const CourseListWidget({super.key,required this.courseCatalogModel});
final CourseCatalogModel courseCatalogModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15,left: 5,right: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppColor.blackShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 TOP ROW (CODE + STATUS)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AppText(
                  text:courseCatalogModel.courseCode??"Code not found",
                  fontSize: 11,
                  color: AppColor.primary,
                ),
              ),


              CustomPopMenuButton(
                menus: ["Edit","Delete", if(courseCatalogModel.status!=null) courseCatalogModel.status??""],
                onSelected: (value) async {
                  if(value==0){
                    showDialog(context: context, builder: (context) => AddNewCourseCatalogDialog(courseCatalogModel:courseCatalogModel,),);
                  }
                  else if(value==1){
                    showDialog(context: context, builder: (context) => ConfirmationDialog(buttonWidget: Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            text: "Discard",
                            bgColor: AppColor.white,
                            textColor: AppColor.red,
                            borderColor: AppColor.red,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: CustomElevatedButton(onPressed: () async {
                            var val= await  _courseCatalogCubit.deleteCatalog(val: courseCatalogModel);
                            if(val){
                              Navigator.pop(context);
                            }

                          }, text: "Delete"),
                        ),
                      ],
                    ), title: "${courseCatalogModel.courseCode}", subText: "Are you sure you want to delete this item? This action cannot be undone."),);
                  }
                  else{
                    CourseCatalogModel model=courseCatalogModel;
                    model.copyWith(status: model.status=="Active"? "Inactive":"Active");
                  await  _courseCatalogCubit.updateCatalog(val: model);
                  }
                },),
            ],
          ),

          SizedBox(height: 10),

          /// 🔹 TITLE
          AppText(
            text: courseCatalogModel.courseTitle??"",
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),

          SizedBox(height: 4),

          /// 🔹 SUBTITLE
          AppText(
            text: "Dept. of ${courseCatalogModel.departments!.isEmpty?courseCatalogModel.department:courseCatalogModel.departments!.join(", ")}",
            fontSize: 11,
            color: AppColor.grey,
          ),


          SizedBox(height: 12),
          /// 🔹 INFO BOX
          Container(
            decoration: BoxDecoration(
              color: AppColor.whiteLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.greyLight1),
            ),
            child: Row(
              children: [
                infoItem("Credit Hours", "${courseCatalogModel.creditHours}⏰"),
                divider(),
                infoItem("Type", courseCatalogModel.type??""),
                divider(),
                infoItem("Category", courseCatalogModel.category??""),
              ],
            ),
          ),


        ],
      ),
    );
  }

}

var _courseCatalogCubit = DiContainer().sl<CourseCatalogAdminCubit>();
