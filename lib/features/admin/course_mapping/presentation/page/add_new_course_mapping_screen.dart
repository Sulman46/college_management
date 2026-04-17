import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/custom_top_bar.dart';

class AddNewCourseMappingScreen extends StatefulWidget {
  const AddNewCourseMappingScreen({super.key});

  @override
  State<AddNewCourseMappingScreen> createState() => _AddNewCourseMappingScreenState();
}

class _AddNewCourseMappingScreenState extends State<AddNewCourseMappingScreen> {

  /// 🔹 Dropdown Values
  String affiliation = "Select..";
  String department = "Select..";
  String status ="Select...";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          CustomTopBar(text: "New Mapping"),


          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal:screenPaddingHori,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 HEADER TEXT
                  AppText(
                    text: "Create New Course Mapping",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),

                  SizedBox(height: 5),

                  AppText(
                    text: "Fill all required details to map course with program",
                    fontSize: 11,
                    color: AppColor.grey,
                  ),

                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Department :",
                              fontSize: 12,
                              color: AppColor.grey,
                            ),

                            SizedBox(height: 6),

                            CustomPopMenuButton(menus: ['Core','Supporting'],offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text: department,maxLine: 1, isFilled: false)),),
                          ],
                        ),
                      ),

                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Program :",
                              fontSize: 11,
                              color: AppColor.grey,
                            ),

                            SizedBox(height: 6),

                            CustomPopMenuButton(menus: ['Theory','Theory + Lab'],offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Affiliation :",
                              fontSize: 12,
                              color: AppColor.grey,
                            ),

                            SizedBox(height: 6),

                            CustomPopMenuButton(menus: ['Core','Supporting'],offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                          ],
                        ),
                      ),

                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Degree :",
                              fontSize: 11,
                              color: AppColor.grey,
                            ),

                            SizedBox(height: 6),

                            CustomPopMenuButton(menus: ['Theory','Theory + Lab'],offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Session :",
                              fontSize: 12,
                              color: AppColor.grey,
                            ),

                            SizedBox(height: 6),

                            CustomPopMenuButton(menus: ['Core','Supporting'],offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                          ],
                        ),
                      ),

                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Section :",
                              fontSize: 11,
                              color: AppColor.grey,
                            ),

                            SizedBox(height: 6),

                            CustomPopMenuButton(menus: ['Theory','Theory + Lab'],offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Semester :",
                              fontSize: 12,
                              color: AppColor.grey,
                            ),

                            SizedBox(height: 6),

                            CustomPopMenuButton(menus: ['Core','Supporting'],offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                          ],
                        ),
                      ),

                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Course :",
                              fontSize: 11,
                              color: AppColor.grey,
                            ),

                            SizedBox(height: 6),

                            CustomPopMenuButton(menus: ['Theory','Theory + Lab'],offset: Offset(0, 30),widget: SizedBox(
                                width: mdWidth(context),
                                child: DropDownFieldWidget(text: "Select..",maxLine: 1, isFilled: false)),),
                          ],
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 25),

                  /// 🔹 BUTTON
                  Center(
                    child: CustomElevatedButton(
                      width: mdWidth(context)*.6,
                      onPressed: () {},
                      text: "Save",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}