import 'package:college_management/core/app/myapp.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../data/model/department_model.dart';
import '../widgets/add_department_dialog.dart';
import '../widgets/department_item_widget.dart';
import '../widgets/department_summary_section.dart';

class AdminDepartmentScreen extends StatefulWidget {
  const AdminDepartmentScreen({super.key});

  @override
  State<AdminDepartmentScreen> createState() => _AdminDepartmentScreenState();
}

class _AdminDepartmentScreenState extends State<AdminDepartmentScreen> {
  TextEditingController searchController = TextEditingController();
  double       top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  List<DepartmentModel> departmentList = [
    DepartmentModel(
        code: "CS101",
        name: "Computer Science",
        date: "12 Jan 2024",
        status: "Operational"),
    DepartmentModel(
        code: "ENG201",
        name: "English",
        date: "05 Feb 2024",
        status: "Suspended"),
    DepartmentModel(
        code: "MTH301",
        name: "Mathematics",
        date: "20 Mar 2024",
        status: "Operational"),
  ];

  List<DepartmentModel> filteredList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    },);
    filteredList = departmentList;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// 🔹 MAIN UI
          Column(
            children: [
              CustomTopBar(
                text: "Departments",
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      /// 🔹 SUMMARY
                      Row(
                        children: [
                          DepartmentSummaryBox(
                            title: "Total",
                            count: 3,
                            color: AppColor.blue,
                          ),
                          DepartmentSummaryBox(
                            title: "Operational",
                            count: 2,
                            color: AppColor.primary,
                          ),
                          DepartmentSummaryBox(
                            title: "Suspended",
                            count: 1,
                            color: AppColor.red,
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      /// 🔹 SEARCH
                      CustomTextFormField(
                        controller: searchController,
                        subTitle: "Search department...",
                        isHintText: true,
                        onChanged: (p0) {},
                        borderSize: 1,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      ),

                      SizedBox(height: 20),

                      /// 🔹 LIST
                      filteredList.isEmpty
                          ? Center(
                        child: AppText(
                          text: "No department found",
                          color: AppColor.grey,
                        ),
                      )
                          :
                      Column(
                      children: [...List.generate(
                                            filteredList.length,
                         (index) {
                          final item = filteredList[index];
                          return DepartmentItemWidget(
                            model: item,
                            onEdit: () {},
                            onDelete: () {},
                          );
                        },
                      )
                      ]
                      ),
                      SafeArea(
                          top: false,
                          child: SizedBox(height: 30,)),
                    ],
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
                  showDialog(context: context, builder: (context) => AddDepartmentDialog(),);
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