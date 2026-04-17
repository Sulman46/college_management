import 'package:flutter/material.dart';

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class TeacherRecordDetailsScreen extends StatelessWidget {
  const TeacherRecordDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          CustomTopBar(text: "Teacher Details",suffix: CustomPopMenuButton(
            menus: ["Edit","Delete"],
            onSelected: (value) {

            },widget: Icon(Icons.more_vert,size: 20,color: AppColor.white,),),),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
              child: Column(
                children: [
                  SizedBox(height: 15),

                  /// 🔷 PROFILE HEADER
                  _profileHeader(),

                  SizedBox(height: 15),

                  /// 🔷 BASIC INFO
                  _sectionCard(
                    "Basic Information",
                    [
                      _row("Name", "Ali Raza"),
                      _row("Job Type", "Permanent"),
                      _row("Gender", "Male"),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 ACADEMIC
                  _sectionCard(
                    "Academic Details",
                    [
                      _row("Education", "MPhil AI"),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 ROLE
                  _sectionCard(
                    "Department Role",
                    [
                      _row("Department", "Faculty of Computing"),
                      _row("Designation", "Professor"),
                      _row("Joining Date", "12 Jan 2022"),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 CONTACT
                  _sectionCard(
                    "Contact Information",
                    [
                      _row("Email", "ali@gmail.com"),
                      _row("Phone", "+92 300 1234567"),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 BANK
                  _sectionCard(
                    "Bank Details",
                    [
                      _row("Bank Name", "HBL"),
                      _row("Account No", "1234567890"),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 FINANCE
                  _sectionCard(
                    "Finance",
                    [
                      _row("Per Lecture", "500 PKR"),
                      _row("Weekly Hours", "10 hrs/week"),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 STATUS
                  _sectionCard(
                    "Status",
                    [
                      _statusRow("Active"),
                    ],
                  ),

                  SafeArea(
                      top: false,
                      child: SizedBox(height: 20)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 🔷 PROFILE HEADER
  Widget _profileHeader() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColor.blackShadow,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.primary.withOpacity(.1),
            child: Icon(Icons.person, color: AppColor.primary),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "Ali Raza",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 3),
              AppText(
                text: "Professor • Faculty of Computing",
                fontSize: 11,
                color: AppColor.grey,
              ),
            ],
          )
        ],
      ),
    );
  }

  /// 🔷 SECTION CARD
  Widget _sectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColor.blackShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColor.primary,
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  /// 🔷 NORMAL ROW
  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(text: title, fontSize: 11, color: AppColor.grey),
          Flexible(
            child: AppText(
              text: value,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔷 STATUS ROW (Styled)
  Widget _statusRow(String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(text: "Status", fontSize: 11, color: AppColor.grey),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColor.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AppText(
            text: status,
            fontSize: 11,
            color: AppColor.primary,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}



