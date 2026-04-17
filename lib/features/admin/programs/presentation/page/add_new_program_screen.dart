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

class CreateProgramScreen extends StatefulWidget {
  const CreateProgramScreen({super.key});

  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  /// 🔹 Controllers
  final titleController = TextEditingController();
  final codeController = TextEditingController();
  final levelController = TextEditingController();
  final sectionController = TextEditingController();
  final sessionController = TextEditingController();

  final midsController = TextEditingController();
  final sessionalController = TextEditingController();
  final finalController = TextEditingController();
  final theoryPassController = TextEditingController();

  final practicalMarksController = TextEditingController();
  final practicalPassController = TextEditingController();

  /// 🔹 Dropdown Values
  String affiliation = "Select Uni";
  String department = "Select Dept";
  String status ="Status";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          CustomTopBar(text: "Create New Program"),


          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal:screenPaddingHori,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: AppText(text: "Fill in the details to create a new program.",fontSize: 12,color: AppColor.primary,fontWeight: FontWeight.w500,textAlign: TextAlign.center,)),
                  SizedBox(height: 10,),

                  CustomTextFormField(
                    controller: titleController,
                    subTitle: "Full Title",
                    
                  ),
                  SizedBox(height: 15,),
                  /// 🔹 TITLE + CODE
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: levelController,
                          subTitle: "Level / Degree",
                          
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextFormField(
                          controller: codeController,
                          subTitle: "Program Code",
                          
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  /// 🔹 LEVEL + AFFILIATION
                  Row(
                    children: [
                      Expanded(
                        child: CustomPopMenuButton(
                          onSelected: (p0) {
                            setState(() {
                              department=["CS", "IT", "SE"][p0];
                            });
                          },
                          menus: ["CS", "IT", "SE"],
                          widget:
                          DropDownFieldWidget(text: department,isFilled: department!="Select Dept",),

                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomPopMenuButton(
                          onSelected: (p0) {
                            setState(() {
                              affiliation=["BZU", "UET", "PU"][p0];
                            });
                          },
                          menus: ["BZU", "UET", "PU"],
                          widget:DropDownFieldWidget(text: affiliation,isFilled: affiliation!="Select Uni",),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  /// 🔹 DEPARTMENT + SECTION

                  CustomTextFormField(
                    controller: sessionController,
                    subTitle: "Session",
                    
                  ),
                  SizedBox(height: 15),

                  /// 🔹 SESSION + STATUS
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: sectionController,
                          subTitle: "Section",
                          
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomPopMenuButton(
                          onSelected: (p0) {
                            setState(() {
                              status=["CS", "IT", "SE"][p0];
                            });
                          },
                          menus: ["CS", "IT", "SE"],
                          widget:DropDownFieldWidget(text: status,isFilled: status!="Status",),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  /// 🔥 GRADING FRAMEWORK
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        text: "Grading Framework",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.primary.withOpacity(.8),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child: Divider(thickness: 1,color: AppColor.primary.withOpacity(.8),height: 1,))
                    ],
                  ),

                  SizedBox(height: 5),
                  AppText(
                    text: "Theory",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColor.grey.withOpacity(.8),
                  ),
                  SizedBox(height: 10),

                  /// 🔹 THEORY ROW 1
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: midsController,
                          
                          subTitle: "Mids",
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextFormField(
                          
                          controller: sessionalController,
                          subTitle: "Sessional",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  /// 🔹 THEORY ROW 2
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          
                          controller: finalController,
                          subTitle: "Final",
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextFormField(
                          
                          controller: theoryPassController,
                          subTitle: "Theory Pass %",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  /// 🔹 PRACTICAL
                  AppText(
                    text: "Practical",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColor.grey.withOpacity(.8),
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          
                          controller: practicalMarksController,
                          subTitle: "Max Marks",
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextFormField(
                          
                          controller: practicalPassController,
                          subTitle: "Pass %",
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
                      text: "Create Program",
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

  /// 🔥 REUSABLE POPUP FIELD
  Widget _popupField({
    required String title,
    required List<String> items,
    required Function(String) onSelected,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.greyLight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        onSelected: onSelected,
        itemBuilder: (context) => items
            .map((e) => PopupMenuItem(
          value: e,
          child: AppText(text: e),
        ))
            .toList(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: title,
              color: title.contains("Select")
                  ? AppColor.grey
                  : AppColor.black,
            ),
            Icon(Icons.keyboard_arrow_down, color: AppColor.grey),
          ],
        ),
      ),
    );
  }
}