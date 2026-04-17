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



class AddSemesterScreen extends StatefulWidget {
  const AddSemesterScreen({super.key});

  @override
  State<AddSemesterScreen> createState() => _AddSemesterScreenState();
}

class _AddSemesterScreenState extends State<AddSemesterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          /// 🔷 TOP BAR (UPDATED)
          CustomTopBar(text: "Create Semester"),

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
                    text: "Semester Setup",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 5),
                  AppText(
                    text:
                    "Fill all required details to create a new semester record",
                    fontSize: 11,
                    color: AppColor.grey,
                  ),

                  SizedBox(height: 20),

                  /// 🔹 DEPARTMENT
                  _buildField(
                    title: "Department",
                    child: SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['Core', 'Supporting'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: 'Select Department',
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// 🔹 PROGRAM
                  _buildField(
                    title: "Program",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['Theory', 'Theory + Lab'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select Program",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// 🔹 AFFILIATION
                  _buildField(
                    title: "Affiliation",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['Core', 'Supporting'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select Affiliation",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// 🔹 DEGREE
                  _buildField(
                    title: "Degree",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['Theory', 'Theory + Lab'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select Degree",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// 🔹 SESSION
                  _buildField(
                    title: "Session",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['2024-2025', '2025-2026'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select Session",
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
                          text: "Select Section",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// 🔹 SEMESTER LEVEL
                  _buildField(
                    title: "Semester Level",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['1st', '2nd', '3rd', '4th'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select Level",
                          maxLine: 1,
                          isFilled: false,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  /// 🔹 STATUS
                  _buildField(
                    title: "Status",
                    child:  SizedBox(
                      width: mdWidth(context),
                      child: CustomPopMenuButton(
                        menus: ['Active', 'Inactive'],
                        offset: Offset(0, 30),
                        widget: DropDownFieldWidget(
                          text: "Select Status",
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
                      text: "Create Semester",
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