import 'package:college_management/features/admin/pay_roll_and_salary_management/presentation/widgets/payroll_tabs_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class PayrollAndSalaryManagementAppbar extends StatelessWidget {
  const PayrollAndSalaryManagementAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 105,
      pinned: true,
      backgroundColor: AppColor.primary,
      elevation: 0,

      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColor.white),
        onPressed: () => Navigator.pop(context),
      ),

      /// 🔷 COLLAPSED TITLE (WHEN SCROLLED UP)
      title: AppText(
        text: "Payroll & Salary Management",
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


                Spacer(),
                /// 🔷 LIVE + DATE ROW
                PayrollTabsWidgets(),

                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
