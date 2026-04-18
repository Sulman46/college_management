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



class NewAllocationScreen extends StatefulWidget {
  const NewAllocationScreen({super.key});

  @override
  State<NewAllocationScreen> createState() => _NewAllocationScreenState();
}

class _NewAllocationScreenState extends State<NewAllocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          /// 🔷 TOP BAR (UPDATED)
          CustomTopBar(text: "New Allocation"),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenPaddingHori,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  AppText(
                    text: "Assign Teacher to Course",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 5),
                  AppText(
                    text:
                    "Select details below to allocate a teacher to a specific course and class",
                    fontSize: 11,
                    color: AppColor.grey,
                  ),

                  SizedBox(height: 10),

                  /// 🔹 DEPARTMENT
                  _buildField(
                    title: "Department",
                    child: SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['Core', 'Supporting'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: 'Select..',
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// 🔹 PROGRAM
                  _buildField(
                    title: "Program/Affiliation",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['Theory', 'BS'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select..",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 15),

                  /// 🔹 SESSION
                  _buildField(
                    title: "Batch/Session",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['2024-2025', '2025-2026'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select..",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),



                  /// 🔹 SEMESTER LEVEL
                  _buildField(
                    title: "Semester",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['1st', '2nd', '3rd', '4th'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select..",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// 🔹 SECTION
                  _buildField(
                    title: "Section",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['A', 'B', 'C'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select..",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  /// 🔹 STATUS
                  _buildField(
                    title: "Course",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['Java', 'OOP'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select..",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  _buildField(
                    title: "Teacher",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['ALi', 'Hassan'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  /// 🔹 SAVE BUTTON
                  Center(
                    child: CustomElevatedButton(
                      width: mdWidth(context) * .7,
                      onPressed: () {},
                      text: "Save",
                    ),
                  ),

                  SafeArea(
                      top: false,
                      child: SizedBox(height: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 REUSABLE FIELD WIDGET
  Widget _buildField({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 12,
          color: AppColor.grey,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 6),
        child,
      ],
    );
  }
}