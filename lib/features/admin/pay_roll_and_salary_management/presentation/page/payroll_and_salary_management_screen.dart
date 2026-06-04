import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/features/admin/faculty_workload/presentation/widgets/stat_card_widget.dart';
import 'package:college_management/features/admin/pay_roll_and_salary_management/presentation/widgets/payroll_and_salary_management_appbar.dart';
import 'package:college_management/features/admin/pay_roll_and_salary_management/presentation/widgets/payroll_stats_section.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../faculty_workload/presentation/widgets/animated_teacher_card_widget.dart';
import '../../../faculty_workload/presentation/widgets/faculty_header_delegate.dart';
import '../widgets/payroll_filter_section_delegate.dart';
import '../widgets/user_salary_widget.dart';


class PayrollAndSalaryManagementScreen extends StatefulWidget {
  const PayrollAndSalaryManagementScreen({super.key});

  @override
  State<PayrollAndSalaryManagementScreen> createState() =>
      _PayrollAndSalaryManagementScreenState();
}

class _PayrollAndSalaryManagementScreenState extends State<PayrollAndSalaryManagementScreen> {

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
      body: CustomScrollView(
        slivers: [

          /// 🔷 HEADER (KEEP SAME)
          /// 🔷 ANIMATED HEADER
          PayrollAndSalaryManagementAppbar(),

          /// 🔷 STATS ONLY (NO COLUMN)
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),

                Container(
                    margin: EdgeInsetsGeometry.symmetric(horizontal: screenPaddingHori,),
                    child: PayrollStatsSection()),

              ],
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: PayrollFilterSectionDelegate(),
          ),

          /// 🔷 TEACHER LIST (IMPORTANT FIX)
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenPaddingHori,
                  ),
                  child: UserSalaryWidget(),
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







