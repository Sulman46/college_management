import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
class FacultyDetailsScreen extends StatelessWidget {
  const FacultyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          CustomTopBar(text: "Faculty Details"),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal:screenPaddingHori),
                child: Column(
                  children: [
                    SizedBox(height: 15,),

                    /// 🔷 TEACHER CARD
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: AppColor.shadowBlack,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.purple,
                            child: AppText(text: "F", color: Colors.white),
                          ),
                          SizedBox(width: 10),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: "Fatima",
                                fontWeight: FontWeight.w600,
                              ),
                              AppText(
                                text: "Faculty of English",
                                fontSize: 11,
                                color: AppColor.grey,
                              ),
                              SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: AppText(
                                  text: "Permanent",
                                  fontSize: 10,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    /// 🔷 COURSE CARD
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppText(
                                text: "Course Details",
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          AppText(text: "Physics", fontWeight: FontWeight.w600),
                          AppText(
                            text: "NP-01 • Nuclear Physics",
                            fontSize: 11,
                            color: AppColor.grey,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    /// 🔷 LECTURE STATS
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(text: "Lecture Stats", fontWeight: FontWeight.w600),
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _statBox("P", "0", Colors.green),
                              _statBox("L", "0", Colors.orange),
                              _statBox("EL", "0", Colors.blue),
                              _statBox("A", "0", Colors.red),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    /// 🔷 FINANCIAL SUMMARY
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          _row("Gross", "Rs 0"),
                          _row("Deductions", "None"),
                          Divider(),
                          _row("Net", "Rs 0", isBold: true),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    /// 🔷 BANK INFO
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.account_balance, color: AppColor.primary),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: "Allied Bank"),
                              AppText(
                                text: "098976654533221",
                                fontSize: 11,
                                color: AppColor.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    /// 🔷 STATUS + ACTIONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        /// STATUS
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: AppText(
                            text: "Pending",
                            color: Colors.orange,
                          ),
                        ),

                        /// ACTIONS
                        Row(
                          children: [
                            _actionBtn(Icons.copy, Colors.blue),
                            SizedBox(width: 10),
                            _actionBtn(Icons.download, Colors.green),
                            SizedBox(width: 10),
                            _actionBtn(Icons.picture_as_pdf, Colors.red),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// 🔷 SMALL WIDGETS

Widget _row(String title, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(text: title, color: AppColor.grey),
        AppText(
          text: value,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        ),
      ],
    ),
  );
}

Widget _statBox(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        AppText(text: label, color: color, fontSize: 10),
        AppText(text: value, fontWeight: FontWeight.w600),
      ],
    ),
  );
}

Widget _actionBtn(IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withOpacity(.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, color: color, size: 18),
  );
}