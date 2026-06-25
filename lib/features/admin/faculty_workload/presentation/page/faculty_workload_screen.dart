import 'dart:math';

import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/faculty_workload/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/faculty_workload/presentation/widgets/stat_card_widget.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../model/workload_card_model.dart';
import '../widgets/animated_teacher_card_widget.dart';
import '../widgets/faculty_header_delegate.dart';


class FacultyWorkloadScreen extends StatefulWidget {
  const FacultyWorkloadScreen({super.key});
  @override
  State<FacultyWorkloadScreen> createState() =>
      _FacultyWorkloadScreenState();
}

class _FacultyWorkloadScreenState extends State<FacultyWorkloadScreen> {


  final _facultyWorkload = DiContainer().sl<FacultyWorkLoadCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await _facultyWorkload.get();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _facultyWorkload,
        builder: (context,sytetvak) {
          List<WorkloadCardModel> filteredList =
          _facultyWorkload.workloadResponseModel == null
              ? []
              : _facultyWorkload.workloadResponseModel!.workloadList.where(
                (workload) {
              final matchDepartment =
                  _facultyWorkload.selectedDpt == "All Dept" ||
                      workload.teacherWorkloadModel.departments.any(
                            (dept) => dept.name == _facultyWorkload.selectedDpt,
                      );

              final matchName = workload
                  .teacherWorkloadModel
                  .teacherName
                  .toString()
                  .toLowerCase()
                  .contains(_facultyWorkload.filterName.toLowerCase());

              return matchDepartment && matchName;
            },
          ).toList();
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 92,
                pinned: true,
                backgroundColor: AppColor.primary,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColor.white),
                  onPressed: () => Navigator.pop(context),
                ),

                /// 🔷 COLLAPSED TITLE (WHEN SCROLLED UP)
                title: AppText(
                  text: "Faculty Workload",
                  color: AppColor.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                centerTitle: true,

                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.primary,
                          AppColor.primary.withOpacity(.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),

                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SafeArea(
                              bottom: false,
                              child: SizedBox(height: 50)),


                          /// 🔷 DESCRIPTION
                          AppText(
                            text:
                            "One row per teacher · all departments shown as tags · workload calculated from Active Allocations",
                            fontSize: 10,
                            color: AppColor.white.withOpacity(.8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// 🔷 STATS ONLY (NO COLUMN)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatCardWidget(title: "TOTAL FACULTY", value: "${_facultyWorkload.workloadResponseModel!=null?_facultyWorkload.workloadResponseModel?.workloadList.length:0}", color: AppColor.blue),
                          StatCardWidget(title: "OVERLOADED", value: "${_facultyWorkload.workloadResponseModel!=null?_facultyWorkload.workloadResponseModel?.workloadList.where((e) => e.completedCr>e.targetCH,).length:0}", color: AppColor.red),
                          StatCardWidget(title: "WITHIN TARGET", value: "${_facultyWorkload.workloadResponseModel!=null?_facultyWorkload.workloadResponseModel?.workloadList.where((e) => e.completedCr<=e.targetCH,).length:0}", color: AppColor.green),
                        ],
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              /// 🔷 STICKY FACULTY HEADER
              SliverPersistentHeader(
                pinned: true,
                delegate: FacultyHeaderDelegate(),
              ),

              /// 🔷 TEACHER LIST (IMPORTANT FIX)
             if(_facultyWorkload.workloadResponseModel!=null && filteredList.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount:  filteredList.length,
                      (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenPaddingHori,
                        vertical: 6,
                      ),
                      child: AnimatedTeacherCardWidget(index: index,model: filteredList[index],),
                    );
                  },
                ),
              ),

              /// 🔷 BOTTOM SPACE
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    if(_facultyWorkload.workloadResponseModel==null || filteredList.isEmpty)
                      DataNotFoundWidget(onTap: () async{
                       await _facultyWorkload.get();
                      },),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}







