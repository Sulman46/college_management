import 'package:college_management/core/app/myapp.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/widgets/confirmation_dialog.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../data/model/department_model.dart';
import '../controller/cubit.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await _departmentCubit.getDepartments();
    },);
    super.initState();
  }
  var _departmentCubit=DiContainer().sl<AdminDepartmentCubit>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _departmentCubit,
        builder: (context,statebsjhbj) {
          return Stack(
            children: [
              /// 🔹 MAIN UI
              Column(
                children: [
                  CustomTopBar(
                    onTap: () {
                      context.pop();
                    },
                    text: "Departments",
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            /// 🔹 SUMMARY
                            Row(
                              children: [
                                DepartmentSummaryBox(
                                  title: "Total",
                                  count: _departmentCubit.departmentList.length,
                                  color: AppColor.blue,
                                ),
                                DepartmentSummaryBox(
                                  title: "Active",
                                  count: _departmentCubit.departmentList.where((element) => element.status==DepartmentStatus.Active,).toList().length,
                                  color: AppColor.primary,
                                ),
                                DepartmentSummaryBox(
                                  title: "Inactive",
                                  count: _departmentCubit.departmentList.where((element) => element.status==DepartmentStatus.Inactive,).toList().length,
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
                              onChanged: (p0) {
                                _departmentCubit.filterList(p0);
                              },
                              borderSize: 1,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            ),

                            SizedBox(height: 20),

                            /// 🔹 LIST
                            if (_departmentCubit.filterDepartmentList.isEmpty) Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    text: "No department found",
                                    color: AppColor.grey,
                                  ),
                                  SizedBox(height: 10,),
                                  InkWell(
                                      onTap: ()async {
                                       await _departmentCubit.getDepartments();
                                      },
                                      child: Icon(Icons.refresh,size: 20,color: AppColor.primary,)),
                                ],
                              ),
                            ) else Column(
                            children: [...List.generate(
                              _departmentCubit.filterDepartmentList.length,
                               (index) {
                                final item = _departmentCubit.filterDepartmentList[index];
                                return DepartmentItemWidget(
                                  model: item,

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
                    ),
                  )
                ],
              ),


              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                top: _departmentCubit.top,
                right: _departmentCubit.right,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    _departmentCubit.getButtonPosition(topVal:details.delta.dy, rightVal: details.delta.dx);
                      // top += details.delta.dy;
                      // left += details.delta.dx;
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
          );
        }
      ),
    );
  }
}