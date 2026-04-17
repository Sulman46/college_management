import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/semesters/presentation/page/add_semester_screen.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';

import '../../../../../core/app/myapp.dart';
import '../../../../../core/constants/media_query.dart';
import '../../../../../widgets/custom_button.dart';

class NeuralGeneratorScreen extends StatefulWidget {
  const NeuralGeneratorScreen({super.key});

  @override
  State<NeuralGeneratorScreen> createState() =>
      _NeuralGeneratorScreenState();
}

class _NeuralGeneratorScreenState
    extends State<NeuralGeneratorScreen> {
TextEditingController nameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController roleController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          /// 🔹 TOP BAR
          CustomTopBar(text: "Access Generator"),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:screenPaddingHori),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    
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
                        AppText(text: "Vortex Access Generator",fontSize: 16,color: AppColor.primary,fontWeight: FontWeight.w600,),
                        SizedBox(height: 5,),
                        AppText(text: "Provision new identity nodes with automated email dispatch",textAlign: TextAlign.center,fontSize: 12,color: AppColor.grey,fontWeight: FontWeight.w600,),
                        SizedBox(height: 10,),
                        CustomTextFormField(controller: nameController, subTitle: "Name..",title: "Full Name",),
                        SizedBox(height: 10,),
                        CustomTextFormField(controller: emailController, subTitle: "Email..",title: "Official Email",),
                        SizedBox(height: 10,),
                        CustomPopMenuButton(menus: ['Student','Admin','Teacher','Coordinator'],widget: DropDownFieldWidget(text: "Select..", isFilled: false),title: "Role",),
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
            ),
          )
        ],
      ),
    );
  }
}