import 'package:college_management/features/admin/home/presentation/page/admin_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:college_management/core/constants/app_assets.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_text_form.dart';

import '../../../../core/constants/media_query.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: SafeArea(
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
                    boxShadow: AppColor.blackShadow,
                  ),
                  child: Image.asset(AppAssets.appLogo,height: 100,width: 100,),
                ),
              ),
              SizedBox(height: 10,),

              Center(child: AppText(text: "Welcome Back!",fontSize: 14,color: AppColor.black,)),
              SizedBox(height: 2,),
              Center(child: AppText(text: "Login to your Portal",fontSize: 12,color: AppColor.greyLight,)),

              SizedBox(height: 30,),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.white,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: "Email",color: AppColor.greyLight,),
                    SizedBox(height: 5,),
                    CustomTextFormField(controller: emailController,isNeedLabelText: false,isHintText:true, subTitle: "Email"),
                    SizedBox(height: 10,),
                    AppText(text: "Password",color: AppColor.greyLight,),
                    SizedBox(height: 5,),
                    CustomTextFormField(controller: passwordController, subTitle: "Password",isHintText: true,isObSecure: true,),
                    SizedBox(height: 10,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     InkWell(
                    //         onTap: () {},
                    //         child: AppText(text: "Coordinator",fontSize: 11,color: AppColor.blue,)),
                    //   ],
                    // ),

                    SizedBox(height: 10,),
                    Center(
                      child: CustomElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomeScreen(),));
                      }, text: "Login",height: 30,
                        fontSize: 13,width: mdWidth(context)*.5,),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


