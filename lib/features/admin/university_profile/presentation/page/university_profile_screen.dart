import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/image_picker_class.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/university_profile/models/university_model.dart';
import 'package:college_management/features/admin/university_profile/models/university_profile_model.dart';
import 'package:college_management/features/admin/university_profile/presentation/widgets/university_profile_image.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_image_cache.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';

import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/data_not_found_widget.dart';
import '../controller/cubit.dart';

class UniversityProfileScreen extends StatefulWidget {
  const UniversityProfileScreen({super.key});

  @override
  State<UniversityProfileScreen> createState() =>
      _UniversityProfileScreenState();
}

class _UniversityProfileScreenState extends State<UniversityProfileScreen> {

  var universityProfileCubit=DiContainer().sl<UniversityProfileCubit>();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController campusIdController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController geoController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      universityProfileCubit.updateEditUniversityProfile(false);
      UniversityModel? response=  await universityProfileCubit.getUniversitySetup();
      if(response!=null){
        UniversityProfileModel model=response.universityProfileModel!;
        nameController.text=model.name;
        campusIdController.text=model.campusId;
        contactController.text=model.phone;
        emailController.text=model.email;
        addressController.text=model.address;
        website.text=model.website;
        geoController.text=model.location;
      }
    },);
    // TODO: implement initState
    super.initState();
  }






  Widget buildField(String label, TextEditingController controller) {
    return universityProfileCubit.editUniversityProfile
        ? Container(
      margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: label,color: AppColor.greyLight,),
              SizedBox(height: 5,),
              CustomTextFormField(
                    controller: controller,
                    subTitle: label,
                isHintText: true,
                  ),
            ],
          ),
        )
        : InkWell(
      onLongPress: () async{
       await Clipboard.setData(ClipboardData(text: controller.text)).then((value) {
       },);
      },
          child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: AppColor.blackShadow,
                ),
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText(
                  text: "$label:",
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey,
                ),
              ],
            ),
            SizedBox(height: 5,),
            AppText(
              text: controller.text,
              textAlign: TextAlign.end,
              fontWeight: FontWeight.w600,
            ),
          ],
                ),
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: BlocBuilder(
        bloc: universityProfileCubit,
        builder: (context,statesbhjb) {
          return Column(
            children: [
              CustomTopBar(text: "Profile",suffix: InkWell(
                onTap: () {
                  universityProfileCubit.updateEditUniversityProfile(!universityProfileCubit.editUniversityProfile);
                },
                child: Icon(universityProfileCubit.editUniversityProfile ? Icons.close : Icons.edit,color: AppColor.white,size: 20,),

              ),),
              /// 🔹 IMAGE
              if(universityProfileCubit.universityModel==null)
              DataNotFoundWidget(onTap:  ()async {
              await universityProfileCubit.getUniversitySetup();
              })
                else
             Expanded(
               child: SingleChildScrollView(
                 child: SafeArea(
                   top: false,
                   child: Padding(
                     padding:  EdgeInsets.symmetric(horizontal:screenPaddingHori,vertical: 10),
                     child: Column(
                       children: [
                         UniversityProfileImage(),

                         SizedBox(height: 15),


                         /// 🔹 CARD
                         Container(
                           padding: EdgeInsets.all(15),
                           decoration: BoxDecoration(
                             color: AppColor.white,
                             borderRadius: BorderRadius.circular(15),
                             boxShadow: AppColor.blackShadow,
                           ),
                           child: Column(
                             children: [
                               buildField("University Name", nameController),
                               buildField("Campus ID", campusIdController),
                               buildField("Contact Number", contactController),
                               buildField("Email", emailController),
                               buildField("Website", website),
                               buildField("Address", addressController),
                               buildField("Geo Location URL", geoController),
                             ],
                           ),
                         ),

                         SizedBox(height: 20),

                         /// 🔹 SAVE BUTTON
                         if (universityProfileCubit.editUniversityProfile)
                           CustomElevatedButton(onPressed: () async {
                             if(nameController.text.isEmpty || campusIdController.text.isEmpty || contactController.text.isEmpty|| emailController.text.isEmpty|| website.text.isEmpty|| addressController.text.isEmpty|| geoController.text.isEmpty){
                               showMessage("Please fill empty fields");
                               return;
                             }
                             UniversityProfileModel universityProfileModel=UniversityProfileModel(name: nameController.text, logo: universityProfileCubit.universityModel?.universityProfileModel?.logo??"", campusId: campusIdController.text, phone: contactController.text, email: emailController.text, website: website.text, address: addressController.text, location: geoController.text);
                             await universityProfileCubit.addUniversitySetup(UniversityModel(universityProfileModel: universityProfileModel));
                             
                             }, text: "Save",width: mdWidth(context)*.5,),
                       ],
                     ),
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


