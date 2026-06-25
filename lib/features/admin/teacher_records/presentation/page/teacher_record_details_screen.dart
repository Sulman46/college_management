import 'package:college_management/widgets/active_inactive_status_widget.dart';
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

class TeacherRecordDetailsScreen extends StatefulWidget {
   TeacherRecordDetailsScreen({super.key,required this.model});
  TeacherModel model;

  @override
  State<TeacherRecordDetailsScreen> createState() => _TeacherRecordDetailsScreenState();
}

class _TeacherRecordDetailsScreenState extends State<TeacherRecordDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Column(
        children: [
          CustomTopBar(text: "Teacher Details",suffix: CustomPopMenuButton(
            menus: ["Edit",widget.model.status=="Active"?"Inactive":"Active","Delete"],
            onSelected: (value) async{
              var teacherRecordCubit=DiContainer().sl<TeacherRecordsCubit>();
              if(value==0){
                context.push('/Admin-add-teacher-record',extra: widget.model);
              }else if(value==1){
                if(widget.model.status=="Active"){
                 var val= await  teacherRecordCubit.update(widget.model.copyWith(status: "Inactive"),message: "Status updated");
                 if(val){
                   context.pop();
                   await teacherRecordCubit.getTeachers();
                 }
                }else{
                  var val=  await  teacherRecordCubit.update(widget.model.copyWith(status: "Active"));
                  if(val){
                    context.pop();
                    await teacherRecordCubit.getTeachers();
                  }
                }
              }else{
             var val=   await  teacherRecordCubit.delete(widget.model);
                if(val){
                    context.pop();
                    await teacherRecordCubit.getTeachers();
                  }
              }
            },widget: Icon(Icons.more_vert,size: 20,color: AppColor.white,),
          ),),

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
                      _row("Name", widget.model.teacherName??""),
                      _row("Job Type", widget.model.teacherType??""),
                      _row("Gender", widget.model.gender??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 ACADEMIC
                  _sectionCard(
                    "Academic Details",
                    [
                      _row("Education", widget.model.specialization??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 ROLE
                  _sectionCard(
                    "Department Role",
                    [
                      _row("Department", widget.model.department?.map((e) => e.name,).join(", ")??""),
                      _row("Designation", widget.model.designation??""),
                      _row("Joining Date", widget.model.joiningDate??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 CONTACT
                  _sectionCard(
                    "Contact Information",
                    [
                      _row("Email", widget.model.email??""),
                      _row("Phone", widget.model.phone??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 BANK
                  _sectionCard(
                    "Bank Details",
                    [
                      _row("Bank Name", widget.model.bankName??""),
                      _row("Account No", widget.model.accountNo??""),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 FINANCE
                  _sectionCard(
                    "Finance",
                    [
                      _row("Per Lecture", "${widget.model.ratePerLecture??""} PKR"),
                      _row("Weekly Hours", "${widget.model.targetWorkload??""} hrs/week"),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// 🔷 STATUS
                  _sectionCard(
                    "Status",
                    [
                      _statusRow(widget.model.status??""),
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
      decoration: AppColor.containerNeon,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColor.white.withOpacity(.1),
            child: AppText(text: widget.model.teacherName?[0]??"",fontSize: 15,color: AppColor.white,),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: widget.model.teacherName??"",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 3),
              AppText(
                text: "${widget.model.designation??""}",
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
      decoration:  AppColor.containerNeon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
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
        ActiveInactiveStatusWidget(isActive: status=="Active")
      ],
    );
  }
}



