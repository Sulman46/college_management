import 'package:flutter/material.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/active_inactive_status_widget.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_image_cache.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../models/student_model.dart';
import '../controller/cubit.dart';
import '../page/add_new_student_screen.dart';

class RegisteredStudentItem extends StatelessWidget {
   RegisteredStudentItem({super.key,required this.studentModel,required this.canEdit});
  StudentModel studentModel;
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
              CustomImageCache(url: studentModel.image??"",width: 40,height: 40,radius: 10,),
              SizedBox(width: 5,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TITLE + MENU
                    AppText(
                      text: studentModel.name??"",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),

                    SizedBox(height: 3),

                    /// SUBTITLE
                    AppText(
                      text: "${studentModel.gender=="male"?"S/O":"D/O"} ${studentModel.fatherName??""}",
                      fontSize: 11,
                      color: AppColor.grey,
                    ),

                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 5),

          /// ✅ 🔥 NEW SECTION (COURSE DETAILS)
          SizedBox(height: 5),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(text: "Reg No.",fontSize: 11,color: AppColor.grey,),
                  SizedBox(width: 5,),
                  AppText(
                    text: studentModel.registrationNumber??"",
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ],
              ),
              SizedBox(width: 20,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(text: "Roll No.",fontSize: 11,color: AppColor.grey,),
                  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.white.withOpacity(.1)
                    ),
                    child: AppText(
                      text: studentModel.rollNo??"",
                      fontSize: 11,
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: AppColor.containerDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                AppText(
                  text: studentModel.programName??"",
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),

                SizedBox(height: 3),
                AppText(
                  text: "Dep. ${studentModel.department??""}",
                  fontSize: 11,
                  color: AppColor.grey,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Section: ${studentModel.section}",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.white.withOpacity(.7),
                    ),
                    AppText(
                      text: "Batch: ${studentModel.session??""}",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.white.withOpacity(.7),
                    ),

                  ],
                ),
                SizedBox(height: 3),
                AppText(
                  text: studentModel.affiliation??"",
                  fontSize: 11,
                  color: AppColor.grey,
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActiveInactiveStatusWidget(isActive: studentModel.status=="Active"),
              if(canEdit)
              CustomPopMenuButton(
                menus: ["Edit", "Delete"],
                onSelected: (val) async {
                  if(val==0){
                    var studentRegisterCubit = DiContainer().sl<StudentRegistrationCubit>();
                    studentRegisterCubit.getStudentUpdateModel(studentModel);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewStudentScreen(studentModel: studentModel,),));
                  }else if (val==1){
                    var studentRegisterCubit = DiContainer().sl<StudentRegistrationCubit>();
                    await studentRegisterCubit.delete(studentModel);
                  }
                },
              )
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