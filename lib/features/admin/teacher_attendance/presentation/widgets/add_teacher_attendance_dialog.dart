import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class AddTeacherAttendanceDialog extends StatelessWidget {
  const AddTeacherAttendanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTopBar(text: "Manual Attendance Entry"),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsetsGeometry.symmetric(horizontal: screenPaddingHori),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  CustomPopMenuButton(menus: ['Faculty of Computing','Faculty of English'],title: "Department",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                  SizedBox(height: 10,),

                  CustomPopMenuButton(menus: ['BSIT','BS English'],title: "Program",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                  SizedBox(height: 10,),

                  CustomPopMenuButton(menus: ['Ali','Hassan'],title: "Teacher",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                  SizedBox(height: 10,),

                  CustomPopMenuButton(menus: ['Ali','Hassan'],title: "Subject",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                  SizedBox(height: 10,),

                  CustomPopMenuButton(menus: ['A','B'],title: "Degree",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                  SizedBox(height: 10,),

                  CustomPopMenuButton(menus: ['A','B'],title: "Affiliation",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Expanded(child: CustomPopMenuButton(menus: ['A','B'],title: "Section",widget: DropDownFieldWidget(text: "Select..", isFilled: false),)),
                      SizedBox(width: 10,),

                      Expanded(child: CustomPopMenuButton(menus: ['1','2'],title: "Semester",widget: DropDownFieldWidget(text: "Select..", isFilled: false),)),
                    ],
                  ),
                  SizedBox(height: 10,),

                  CustomPopMenuButton(menus: ['2024-2026','2025-2027'],title: "Session",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                  SizedBox(height: 10,),

                  CustomPopMenuButton(menus: ['Present','Absent'],title: "Status",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Expanded(child: DropDownFieldWidget(text: "Select..", isFilled: false,title: "Date",)),
                      SizedBox(width: 10,),
                      Expanded(child: DropDownFieldWidget(text: "Select..", isFilled: false,title: "Minutes (If Late)",)),

                    ],
                  ),
                  SizedBox(height: 20,),

                  CustomElevatedButton(
                    width: mdWidth(context)*.5,
                    height: 35,
                    onPressed: () {
                      // TODO: Submit logic
                    },
                    text: "Save",
                  ),

                  SafeArea(
                      top: false,
                      child: SizedBox(height: 30)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
