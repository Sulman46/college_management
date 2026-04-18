import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/teacher_records/presentation/page/add_teacher_record_screen.dart';
import 'package:college_management/features/admin/teacher_records/presentation/widgets/teacher_record_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../widgets/custom_button.dart';
import '../widgets/teacher_allocation_item.dart';
import 'new_allocation_screen.dart';


class TeacherAllocationScreen extends StatefulWidget {
  const TeacherAllocationScreen({super.key});

  @override
  State<TeacherAllocationScreen> createState() =>
      _TeacherAllocationScreenState();
}

class _TeacherAllocationScreenState extends State<TeacherAllocationScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              /// 🔹 TOP BAR
              CustomTopBar(text: "Teacher Allocation"),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),

                        /// 🔹 SEARCH
                        CustomTextFormField(
                          controller: searchController,
                          subTitle: "Search...",
                          isHintText: true,
                          onChanged: (p0) {},
                          borderSize: 1,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                        ),

                        SizedBox(height: 15,),

                        /// 🔹 LIST
                        ...List.generate(5, (index) => TeacherAllocationItem(),),
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
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            top: top,
            left: left,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  top += details.delta.dy;
                  left += details.delta.dx;
                });
              },
              child: CustomElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewAllocationScreen(),));
                },
                text: "Add New",
                fontSize: 15,
                width: 110,
                height: 50,
              ),
            ),
          ),

        ],
      ),
    );
  }
}