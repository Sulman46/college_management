import 'dart:io';
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/image_picker_class.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';

import '../../../../../widgets/custom_text_form.dart';
import '../controller/cubit.dart';

class UniversityProfileScreen extends StatefulWidget {
  const UniversityProfileScreen({super.key});

  @override
  State<UniversityProfileScreen> createState() =>
      _UniversityProfileScreenState();
}

class _UniversityProfileScreenState extends State<UniversityProfileScreen> {



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      universityProfileCubit.updateEditUniversityProfile(false);
    },);
    // TODO: implement initState
    super.initState();
  }


  // Controllers
  final nameController = TextEditingController(text: "ABC University");
  final campusIdController = TextEditingController(text: "CAMP-123");
  final contactController = TextEditingController(text: "03001234567");
  final emailController = TextEditingController(text: "abc@uni.com");
  final addressController = TextEditingController(text: "Karachi, Pakistan");
  final geoController = TextEditingController(text: "https://maps.google.com");

  Future pickImage() async {
    final picked = await ImagePickerClass.pickImage();
    if (picked != null) {
      universityProfileCubit.pickUniversityImage(picked);
    }
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
             Expanded(
               child: SingleChildScrollView(
                 child: SafeArea(
                   top: false,
                   child: Padding(
                     padding:  EdgeInsets.symmetric(horizontal:screenPaddingHori,vertical: 10),
                     child: Column(
                       children: [
                         GestureDetector(
                           onTap: universityProfileCubit.editUniversityProfile ? pickImage : null,
                           child: Container(
                             height: 140,
                             width: 140,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               color: AppColor.white,
                               boxShadow: AppColor.blackShadow,
                               image: universityProfileCubit.pickedUniversityImage != null
                                   ? DecorationImage(
                                 image: FileImage(universityProfileCubit.pickedUniversityImage!),
                                 fit: BoxFit.cover,
                               )
                                   : null,
                             ),
                             child: universityProfileCubit.pickedUniversityImage == null
                                 ? Icon(Icons.camera_alt, size: 40, color: AppColor.grey)
                                 : null,
                           ),
                         ),

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
                               // if(universityProfileCubit.editUniversityProfile)
                                 buildField("University Name", nameController),
                                 // Container(
                                 //   margin: EdgeInsets.only(bottom: 20),
                                 //   child: CustomTextFormField(
                                 //     controller: nameController,
                                 //     subTitle: "University Name",
                                 //   ),
                                 // ),
                               buildField("Campus ID", campusIdController),
                               buildField("Contact Number", contactController),
                               buildField("Email", emailController),
                               buildField("Address", addressController),
                               buildField("Geo Location URL", geoController),
                             ],
                           ),
                         ),

                         SizedBox(height: 20),

                         /// 🔹 SAVE BUTTON
                         if (universityProfileCubit.editUniversityProfile)
                           CustomElevatedButton(onPressed: (){}, text: "Save",width: mdWidth(context)*.5,),
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


var universityProfileCubit=DiContainer().sl<UniversityProfileCubit>();