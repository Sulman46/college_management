import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/faculty_workload/presentation/widgets/stat_card_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../course_catalog/presentation/controller/cubit.dart';
import '../../../teacher_allocation/presentation/controller/cubit.dart';
import '../../../teacher_records/presentation/controller/cubit.dart';
import '../widgets/animated_teacher_card_widget.dart';
import '../widgets/faculty_header_delegate.dart';


class FacultyWorkloadScreen extends StatefulWidget {
  const FacultyWorkloadScreen({super.key});
  @override
  State<FacultyWorkloadScreen> createState() =>
      _FacultyWorkloadScreenState();
}

class _FacultyWorkloadScreenState extends State<FacultyWorkloadScreen> {

  TextEditingController searchController = TextEditingController();

  final _courseCatalogCubit = DiContainer().sl<CourseCatalogAdminCubit>();
  final _allocationCubit=DiContainer().sl<TeacherAllocationCubit>();
  final _teacherRecordCubit=DiContainer().sl<TeacherRecordsCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await  _courseCatalogCubit.getCourseCatalogList();
      await _allocationCubit.get();
      await _teacherRecordCubit.getTeachers();
    },);
  }


  double top=mdHeight(navigatorKey.currentContext!)*.9;
  double left=mdWidth(navigatorKey.currentContext!)*.65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [

          /// 🔷 HEADER (KEEP SAME)
          /// 🔷 ANIMATED HEADER
          SliverAppBar(
            expandedHeight: 160,
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
                        "Real-time analysis of teaching hours across all departments. Benchmark: 16 contact hours/week",
                        fontSize: 11,
                        color: AppColor.white.withOpacity(.8),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AppText(
                          text: "Academic Session 2025-2026",
                          fontSize: 10,
                          color: AppColor.white,
                        ),
                      ),

                      Spacer(),
                      /// 🔷 LIVE + DATE ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          /// 🔷 LIVE STATUS
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColor.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6),
                              AppText(
                                text: "LIVE SYNC ACTIVE",
                                fontSize: 10,
                                color: AppColor.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),

                          /// 🔷 DATE
                          AppText(
                            text: "11 April 2026",
                            fontSize: 12,
                            color: AppColor.white,
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
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
                      StatCardWidget(title: "TOTAL FACULTY", value: "1", color: AppColor.blue),
                      StatCardWidget(title: "OVERLOADED", value: "0", color: AppColor.red),
                      StatCardWidget(title: "WITHIN TARGET", value: "1", color: AppColor.green),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenPaddingHori,
                    vertical: 6,
                  ),
                  child: AnimatedTeacherCardWidget(index: index,),
                );
              },
              childCount: 4,
            ),
          ),

          /// 🔷 BOTTOM SPACE
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}







