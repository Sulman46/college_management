import 'dart:io';
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/image_picker_class.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';

import '../../../../../widgets/custom_text_form.dart';
import '../controller/cubit.dart';

class AddNewStudentScreen extends StatefulWidget {
  const AddNewStudentScreen({super.key});

  @override
  State<AddNewStudentScreen> createState() =>
      _AddNewStudentScreenState();
}

class _AddNewStudentScreenState extends State<AddNewStudentScreen> {

  // Controllers
  final nameController = TextEditingController();
  final registerNoController = TextEditingController();
  final rollNoController = TextEditingController();
  final fatherNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressController = TextEditingController();

  final sessionsBatch = TextEditingController();

  File? selectedImage;

  Future pickImage() async {
    final picked = await ImagePickerClass.pickImage();
    if (picked != null) {
      setState(() {
        selectedImage=picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body:Column(
        children: [
          CustomTopBar(text: "Register Student"),
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
                        onTap:  pickImage ,
                        child: Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                            boxShadow: AppColor.blackShadow,
                            image:selectedImage != null
                                ? DecorationImage(
                              image: FileImage(selectedImage!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: selectedImage == null
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
                            CustomTextFormField(
                              isHintText: true,
                              controller: nameController, subTitle: "Name..",title: "Student Name",),
                            SizedBox(height: 10,),
                            CustomTextFormField(
                              isHintText: true,
                              controller: fatherNameController, subTitle: "Father..",title: "Father Name",),
                            SizedBox(height: 10,),
                            CustomPopMenuButton(menus: ['Male (S/O)','Female D/O'],title: "Gender",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                            SizedBox(height: 10,),
                            CustomTextFormField(
                              isHintText: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11)
                              ],
                              controller: contactNumberController, subTitle: "03XXX..",title: "Contact Number",),
                            SizedBox(height: 10,),
                            CustomTextFormField(
                              isHintText: true,
                              controller: addressController, subTitle: "Address..",title: "Full Address",),
                            SizedBox(height: 15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: Divider(height: 1,color: AppColor.grey.withOpacity(.4),)),
                                SizedBox(width: 10,),
                                AppText(text: "Academic Details",fontSize: 12,color: AppColor.primary,),
                                SizedBox(width: 10,),
                                Expanded(child: Divider(height: 1,color: AppColor.grey.withOpacity(.4),)),
                              ],
                            ),
                            SizedBox(height: 7,),

                            CustomPopMenuButton(menus: ['Faculty of Computing','Faculty of English'],title: "Department",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                            SizedBox(height: 10,),

                            CustomPopMenuButton(menus: ['BSCS','BSIT'],title: "Program",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                            SizedBox(height: 10,),

                            CustomPopMenuButton(menus: ['A','B'],title: "Section",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                            SizedBox(height: 10,),

                            CustomPopMenuButton(menus: ['2021-2025','2022-2026'],title: "Session ",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                            SizedBox(height: 10,),

                            CustomPopMenuButton(menus: ['Active','Inactive'],title: "Status",widget: DropDownFieldWidget(text: "Select..", isFilled: false),),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      /// 🔹 SAVE BUTTON
                        CustomElevatedButton(onPressed: (){}, text: "Save",width: mdWidth(context)*.5,),
                     SafeArea(child: SizedBox(height: 30,),top: false,),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


