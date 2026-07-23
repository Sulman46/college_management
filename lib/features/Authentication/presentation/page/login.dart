import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/constants/get_ip_dialog/get_ip_dialog.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/Authentication/models/login_request_model.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/home/presentation/page/admin_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:college_management/core/constants/app_assets.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/media_query.dart';
import '../../../../core/controllers/screen_resizing/screen_resize_cubit.dart';
import '../../../../widgets/drop_down_field_widget.dart';
import '../../../../widgets/more_vert_pop_menu_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationCubit _authCubit=DiContainer().sl<AuthenticationCubit>();
 ScreenResizeCubit screenSizeCubit=DiContainer().sl<ScreenResizeCubit>();


  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

@override
  void initState() {


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: BlocBuilder(
        bloc: _authCubit,
        builder: (context,statesjj) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.white,
                        boxShadow: AppColor.shadowBlack,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(500),
                          child: Image.asset(AppAssets.appLogo,height: 100,width: 100,)),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Center(child: AppText(text: "Welcome Back!",fontSize: 14,color: AppColor.white,)),
                  SizedBox(height: 2,),
                  Center(child: InkWell(
                      onLongPress: () async{
                       await ServerConfigDialog.show(context);
                      },
                      child: AppText(text: "Login to your Portal",fontSize: 12,color: AppColor.greyLight,))),

                  SizedBox(height: 30,),


                  Container(
                    margin: EdgeInsets.symmetric(horizontal:screenSizeCubit.isLargeScreen? 150:20),
                    padding: EdgeInsets.all(20),
                    decoration:AppColor.containerNeon,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(text: "Email/Name",color: AppColor.greyLight,),
                        SizedBox(height: 5,),
                        CustomTextFormField(controller: emailController,isNeedLabelText: false,isHintText:true, subTitle: "Email"),
                        SizedBox(height: 10,),
                        AppText(text: "Password",color: AppColor.greyLight,),
                        SizedBox(height: 5,),
                        CustomTextFormField(controller: passwordController, subTitle: "Password",isHintText: true,isObSecure: true,),
                        SizedBox(height: 10,),
                        CustomPopMenuButton(
                          onSelected: (p0) {
                            _authCubit.getUserRoleLoginScreen(ConstantData.userRoles.map((e) => e.toJson(),).toList()[p0]);
                          },
                          menus: ConstantData.userRoles.map((e) => e.toJson(),).toList(),
                          offset: Offset(0, 30),
                          widget: DropDownFieldWidget(
                            text:_authCubit.selectedRole==null? "Select..":_authCubit.selectedRole??"",
                            maxLine: 1,
                            isFilled: _authCubit.selectedRole!=null,
                          ),
                          title: "Role",
                        ),

                        SizedBox(height: 10,),
                        Center(
                          child: CustomElevatedButton(onPressed: () async {
                            if(_authCubit.selectedRole==null||emailController.text.isEmpty || passwordController.text.isEmpty){
                              showMessage("Please fill all required fields.",isError: true);
                              return;
                            }

                           await _authCubit.login(LoginRequestModel(role: _authCubit.selectedRole??"",username: emailController.text, password: passwordController.text,));
                          }, text: "Login",height: 30,
                            fontSize: 13,width: mdWidth(context)*.5,),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}



