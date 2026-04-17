import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_description_text_field.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';

class AddTeacherRecordScreen extends StatefulWidget {
  const AddTeacherRecordScreen({super.key});

  @override
  State<AddTeacherRecordScreen> createState() => _AddTeacherRecordScreenState();
}

class _AddTeacherRecordScreenState extends State<AddTeacherRecordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController teacherNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController specialization = TextEditingController();
  final TextEditingController rateLecture = TextEditingController();
  final TextEditingController weeklyWorkLoad = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTopBar(text: "Add Faculty"),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(width: 1,color: AppColor.grey.withOpacity(.6)),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: AppColor.blackShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          text: "Personal Details",
                          fontSize: 12,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 5,),
                        CustomTextFormField(
                          isHintText: true,
                          controller: teacherNameController, subTitle: "Name..",title: "Teacher Name",),
                        SizedBox(height: 10,),
                        CustomTextFormField(
                          isHintText: true,
                          controller: emailController, subTitle: "Email..",title: "Email",),
                        SizedBox(height: 10,),
                        CustomTextFormField(
                          isHintText: true,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          subTitle: "03XX..",title: "Phone Number",inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11)
                        ],),
                        SizedBox(height: 10,),
                        CustomPopMenuButton(menus: ['Male','Female'],widget: DropDownFieldWidget(text: "Gender..", isFilled: false),title: "Gender",),
                        SizedBox(height: 10,),
                        AppText(
                          text: "Academic Background",
                          fontSize: 12,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 5,),
                        CustomTextFormField(
                          isHintText: true,
                          controller: specialization, subTitle: "Computer Network..",title: "Specialization",),
                        SizedBox(height: 10,),
                        CustomPopMenuButton(menus: ['MPHIL','PHD'],widget: DropDownFieldWidget(text: "Select", isFilled: false),title: "Qualification",),
                        SizedBox(height: 10,),
                        AppText(
                          text: "Job Assignment",
                          fontSize: 12,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 5,),
                        CustomPopMenuButton(menus: ['MPHIL','PHD'],widget: DropDownFieldWidget(text: "Select", isFilled: false),title: "Department",),
                        SizedBox(height: 10,),
                        CustomPopMenuButton(menus: ['MPHIL','PHD'],widget: DropDownFieldWidget(text: "Select", isFilled: false),title: "Designation",),
                        SizedBox(height: 10,),
                AppText(
                  text: "Contract & Finance",
                  fontSize: 12,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w600,
                ),
                    SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(child: CustomPopMenuButton(menus: ['Contract','Permanent Staff'],widget: DropDownFieldWidget(text: "Select", isFilled: false),title: "Job Type",)),
                            SizedBox(width: 10,),
                            Expanded(child: CustomTextFormField(
                              isHintText: true,
                              controller: joiningDateController,readOnly: true, subTitle: "Date",title: "Joining Date",onTap: () async {
                              DateTime? val = await AppDatePicker.pickCustomDate(
                                context: context,
                                initialDate: DateTime.now(),
                                lastDate: DateTime.now(),
                                firstDate: DateTime(2000),
                              );                            if(val!=null){
                              joiningDateController.text= intl.DateFormat('dd/MMM/yyyy').format(val);
                            }

                            },),),
                          ],
                        ),

                        SizedBox(height: 10,),
                        CustomTextFormField(
                          isHintText: true,
                          controller: rateLecture, subTitle: "e.g. 1500",title: "Rate/Lecture(Rs)",),
                        SizedBox(height: 10,),
 CustomTextFormField(
                          isHintText: true,
                          controller: weeklyWorkLoad, subTitle: "e.g. 18",title: "Weekly Workload",),


                        SizedBox(height: 10,),
                        AppText(
                          text: "Bank Details",
                          fontSize: 12,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 5,),
                        CustomTextFormField(
                          isHintText: true,
                          controller: bankNameController, subTitle: "e.g. HBL",title: "Bank Name",),
                        SizedBox(height: 10,),
                        CustomTextFormField(
                          isHintText: true,
                          controller: accountNumberController, subTitle: "PK00XXXXX...",title: "Account No/IBAN",),
                        SizedBox(height: 10,),
                        CustomElevatedButton(onPressed: (){}, text: "Submit",width: mdWidth(context)*.6,),

                      ],),
                  ),
                  SafeArea(
                      top: false,
                      child: SizedBox(height: 30,)),
                 ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
