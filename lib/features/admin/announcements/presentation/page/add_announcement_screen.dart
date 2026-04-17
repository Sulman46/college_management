import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/semesters/presentation/page/add_semester_screen.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_description_text_field.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';

import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../widgets/custom_button.dart';

class AddAnnouncementScreen extends StatefulWidget {
  const AddAnnouncementScreen({super.key});

  @override
  State<AddAnnouncementScreen> createState() =>
      _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState
    extends State<AddAnnouncementScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController postedByController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController feeInfoController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          /// 🔹 TOP BAR
          CustomTopBar(text: "Faculty Management"),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                child: Column(
                  children: [
                    SizedBox(height: 20,),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(width: 1,color: AppColor.grey.withOpacity(.6)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: AppColor.blackShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Create Announcement",
                            fontSize: 16,
                            color: AppColor.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 5),
                          AppText(
                            text: "Add a new announcement to notify students and staff with important updates",
                            textAlign: TextAlign.center,
                            fontSize: 12,
                            color: AppColor.grey,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 10,),
                          CustomTextFormField(controller: titleController, subTitle: "Title..",title: "Title",),
                          SizedBox(height: 10,),
                          CustomPopMenuButton(menus: ['Academic','Urgent'],widget: DropDownFieldWidget(text: "Select..", isFilled: false),title: "Category",),
                          SizedBox(height: 10,),
                          CustomPopMenuButton(menus: ['Medium','High'],widget: DropDownFieldWidget(text: "Select..", isFilled: false),title: "Priority",),

                          SizedBox(height: 10,),
                          CustomDescriptionTextField(title: "Description",maxLines: 6,minLines: 3,textInputAction: TextInputAction.newline,keyboardType: TextInputType.multiline,controller: descriptionController, subTitle: "Description"),
                          SizedBox(height: 10,),

                          CustomTextFormField(controller: feeInfoController, subTitle: "info..",title: "Fee Info (Optional)",),

                          SizedBox(height: 10,),

                          CustomTextFormField(controller: postedByController, subTitle: "Posted By..",title: "Posted By",),
                          SizedBox(height: 10,),
                          CustomElevatedButton(onPressed: (){}, text: "Submit",width: mdWidth(context)*.6,),
                        ],),
                    ),
                    SafeArea(
                        top: false,
                        child: SizedBox(height: 30,)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}