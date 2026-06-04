import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/pay_roll_and_salary_management/presentation/page/teacher_salary_detail_screen.dart';
import 'package:college_management/features/admin/pay_roll_and_salary_management/presentation/widgets/salary_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

class UserSalaryWidget extends StatelessWidget {
  const UserSalaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyDetailsScreen(),));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.white,
          boxShadow: AppColor.blackShadow
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: "ALi Hassan",fontSize: 12,color: AppColor.black,),
            SizedBox(height: 3,),
            AppText(text: "Dept. Faculty of English",fontSize: 12,color: AppColor.grey,),
            SizedBox(height: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: "Gross: 0 Rs",fontSize: 11,fontWeight: FontWeight.w500,color: AppColor.black,),
                AppText(text: "Net: 0 Rs",fontSize: 11,fontWeight: FontWeight.w500,color: AppColor.primary,),
                AppText(text: "Deduction: 0 Rs",fontSize: 11,fontWeight: FontWeight.w500,color: AppColor.red,),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: "Courses: 1",fontSize: 12,color: AppColor.grey,),
                SalaryStatusWidget(),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
