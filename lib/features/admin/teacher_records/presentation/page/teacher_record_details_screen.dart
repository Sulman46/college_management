import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_top_bar.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../models/teacher_model.dart';
import '../controller/cubit.dart';

class TeacherRecordDetailsScreen extends StatelessWidget {
   TeacherRecordDetailsScreen({super.key,required this.model});
  TeacherModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          CustomTopBar(text: "Faculty Details",suffix: CustomPopMenuButton(
            menus: ["Edit","Delete"],
            onSelected: (value) async{
              var teacherRecordCubit=DiContainer().sl<TeacherRecordsCubit>();
              if(value==0){
                context.push('/Admin-add-teacher-record',extra: model);
              }else{
                await  teacherRecordCubit.delete(model);
              }
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
                      _row("Name", model.teacherName??""),
                      _row("Job Type", model.teacherType??""),
                      _row("Gender", model.gender??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 ACADEMIC
                  _sectionCard(
                    "Academic Details",
                    [
                      _row("Education", model.specialization??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 ROLE
                  _sectionCard(
                    "Department Role",
                    [
                      _row("Department", model.department?.join(", ")??""),
                      _row("Designation", model.designation??""),
                      _row("Joining Date", model.joiningDate??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 CONTACT
                  _sectionCard(
                    "Contact Information",
                    [
                      _row("Email", model.email??""),
                      _row("Phone", model.phone??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 BANK
                  _sectionCard(
                    "Bank Details",
                    [
                      _row("Bank Name", model.bankName??""),
                      _row("Account No", model.accountNo??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 FINANCE
                  _sectionCard(
                    "Finance",
                    [
                      _row("Per Lecture", "${model.ratePerLecture??""} PKR"),
                      _row("Weekly Hours", "${model.targetWorkload??""} hrs/week"),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 STATUS
                  _sectionCard(
                    "Status",
                    [
                      _statusRow(model.status??""),
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
            child: AppText(text: model.teacherName?[0]??"",fontSize: 15,color: AppColor.primary,),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: model.teacherName??"",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 3),
              AppText(
                text: "${model.designation??""} • Faculty of ${model.department?.join(", ")??""}",
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



