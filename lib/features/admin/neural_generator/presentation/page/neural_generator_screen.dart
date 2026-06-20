import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/neural_generator/models/neural_generate_model.dart';
import 'package:college_management/features/admin/neural_generator/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/semesters/presentation/page/add_semester_screen.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
TextEditingController fullNameController=TextEditingController();
TextEditingController userNameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController password=TextEditingController();

var _neuralGeneratorCubit=DiContainer().sl<NeuralGeneratorCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _neuralGeneratorCubit,
        builder: (context,statesbkl) {
          return Column(
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
                            boxShadow: AppColor.shadowBlack,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            AppText(text: "Vortex Access Generator",fontSize: 16,color: AppColor.primary,fontWeight: FontWeight.w600,),
                            SizedBox(height: 5,),
                            AppText(text: "Provision new identity nodes with automated email dispatch",textAlign: TextAlign.center,fontSize: 12,color: AppColor.grey,fontWeight: FontWeight.w600,),
                            SizedBox(height: 10,),
                            CustomTextFormField(controller: fullNameController, subTitle: "Name..",title: "Full Name",isHintText: true,),
                            SizedBox(height: 10,),
                            CustomTextFormField(controller: userNameController, subTitle: "username..",title: "User Name",isHintText: true,),
                            SizedBox(height: 10,),
                            CustomTextFormField(controller: emailController, subTitle: "Email..",title: "Official Email",isHintText: true,),
                            SizedBox(height: 10,),
                            CustomTextFormField(controller: password, subTitle: "password..",title: "Password",isHintText: true,),
                            SizedBox(height: 10,),
                            CustomPopMenuButton(menus:
                            ConstantData.userRoles.map((e) => e.toJson(),).toList(),
                              onSelected: (p0) {
                                _neuralGeneratorCubit.getUserRole(ConstantData.userRoles.toList()[p0]);
                              },
                              widget: DropDownFieldWidget(text:_neuralGeneratorCubit.userRole !=null?_neuralGeneratorCubit.userRole!.toJson(): "Select..", isFilled: false),title: "Role",),
                            SizedBox(height: 10,),
                            CustomElevatedButton(onPressed: ()async{
                              if(fullNameController.text.isEmpty || userNameController.text.isEmpty || emailController.text.isEmpty ||password.text.isEmpty || _neuralGeneratorCubit.userRole==null){
                                showMessage("Please full all fields");
                                return;
                              }

                              NeuralGenerateModel model=NeuralGenerateModel(email: emailController.text,password: password.text,name: fullNameController.text,userName: userNameController.text,role: _neuralGeneratorCubit.userRole?.toJson()??"");
                              var response=await _neuralGeneratorCubit.post(model);

                              if(response){
                                userNameController.clear();
                                fullNameController.clear();
                                emailController.clear();
                                password.clear();
                                _neuralGeneratorCubit.getUserRole(null);
                              }
                            }, text: "Submit",width: mdWidth(context)*.6,),
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
          );
        }
      ),
    );
  }
}