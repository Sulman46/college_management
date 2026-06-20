import 'dart:io';
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/student_registrations/presentation/widgets/pick_student_image_widget.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../models/student_model.dart';
import '../controller/cubit.dart';

class AddNewStudentScreen extends StatefulWidget {
   AddNewStudentScreen({super.key,this.studentModel});
StudentModel? studentModel;
  @override
  State<AddNewStudentScreen> createState() => _AddNewStudentScreenState();
}

class _AddNewStudentScreenState extends State<AddNewStudentScreen> {
  final _studentRegisterCubit = DiContainer().sl<StudentRegistrationCubit>();
  final _semesterCubit = DiContainer().sl<SemesterAdminCubit>();
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController srNoController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController sessionsBatch = TextEditingController();

  File? selectedImage;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      if(_studentRegisterCubit.updateStudentModel!=null){
        _studentRegisterCubit.getStudentModel(_studentRegisterCubit.updateStudentModel??StudentModel());
        nameController.text=_studentRegisterCubit.updateStudentModel?.name??"";
        srNoController.text=_studentRegisterCubit.updateStudentModel?.srNo??"";
        rollNoController.text=_studentRegisterCubit.updateStudentModel?.rollNo??"";
        fatherNameController.text=_studentRegisterCubit.updateStudentModel?.fatherName??"";
        contactNumberController.text=_studentRegisterCubit.updateStudentModel?.contact??"";
        addressController.text=_studentRegisterCubit.updateStudentModel?.address??"";
        _studentRegisterCubit.getGender(_studentRegisterCubit.updateStudentModel?.gender??"Select");
        _studentRegisterCubit.getStatus(_studentRegisterCubit.updateStudentModel?.status??"Select");
      }else{
        _studentRegisterCubit.initValues();
      }
      await _semesterCubit.getSemesterList();
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: BlocBuilder(
        bloc: _studentRegisterCubit,
        builder: (context, statenal) {
          return Column(
            children: [
              CustomTopBar(text: "Register Student"),

              /// 🔹 IMAGE
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenPaddingHori,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          PickStudentImageWidget(
                            studentRegisterCubit: _studentRegisterCubit,
                          ),

                          SizedBox(height: 15),

                          /// 🔹 CARD
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: AppColor.shadowBlack,
                            ),
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  isHintText: true,
                                  controller: nameController,
                                  subTitle: "Name..",
                                  title: "Student Name",
                                ),
                                SizedBox(height: 10),
                                CustomTextFormField(
                                  isHintText: true,
                                  controller: fatherNameController,
                                  subTitle: "Father..",
                                  title: "Father Name",
                                ),
                                SizedBox(height: 10),
                                CustomPopMenuButton(
                                  menus: ["Male","Female"],
                                  onSelected: (p0) {
                                    _studentRegisterCubit.getGender(["Male","Female"][p0]);
                                  },
                                  title: "Gender",
                                  widget: DropDownFieldWidget(
                                    text:_studentRegisterCubit.gender??"Select..",
                                    isFilled: false,
                                  ),
                                ),
                                SizedBox(height: 10),
                                CustomTextFormField(
                                  isHintText: true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                  controller: contactNumberController,
                                  subTitle: "03XXX..",
                                  title: "Contact Number",
                                ),
                                SizedBox(height: 10),
                                CustomTextFormField(
                                  isHintText: true,
                                  controller: addressController,
                                  subTitle: "address..",
                                  title: "Address",
                                ),
                                SizedBox(height: 10),
                                CustomTextFormField(
                                  isHintText: true,
                                  controller: srNoController,
                                  subTitle: "sr..",
                                  title: "Sr No",
                                ),
                                SizedBox(height: 10),
                                CustomTextFormField(
                                  isHintText: true,
                                  controller: rollNoController,
                                  subTitle: "roll..",
                                  title: "Roll No",
                                ),
                                SizedBox(height: 15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        height: 1,
                                        color: AppColor.grey.withOpacity(.4),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    AppText(
                                      text: "Academic Details",
                                      fontSize: 12,
                                      color: AppColor.primary,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Divider(
                                        height: 1,
                                        color: AppColor.grey.withOpacity(.4),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 7),

                                BlocBuilder(
                                  bloc: _semesterCubit,
                                  builder: (context,statebska) {
                                    return _semesterCubit.semesterList.isNotEmpty? CustomPopMenuButton(
                                      menus: _semesterCubit.semesterList.map((e) => e.affiliation??"",).toSet().toList(),
                                      onSelected: (p0) {
                                        _studentRegisterCubit.getStudentModel(_studentRegisterCubit.studentModel.copyWith(affiliation: _semesterCubit.semesterList.map((e) => e.affiliation??"",).toSet().toList()[p0]));
                                      },
                                      widget: DropDownFieldWidget(
                                        title: "Affiliation",
                                        text: _studentRegisterCubit.studentModel.affiliation??"Select..",
                                        isFilled: false,
                                      ),
                                    ) :InkWell(
                                      onTap: () async{
                                       await _semesterCubit.getSemesterList();
                                      },
                                      child: DropDownFieldWidget(
                                        title: "Affiliation",
                                        text: _studentRegisterCubit.studentModel.affiliation??"Select..",
                                        isFilled: false,
                                      ),
                                    );
                                  }
                                ),
                                SizedBox(height: 10),

                                BlocBuilder(
                                  bloc: _semesterCubit,
                                  builder: (context,statebska) {
                                    return _semesterCubit.semesterList.isNotEmpty && _studentRegisterCubit.studentModel.affiliation!=null? CustomPopMenuButton(
                                      menus: _semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation,).map((e) => e.department??"",).toSet().toList(),
                                      onSelected: (p0) {
                                        _studentRegisterCubit.getStudentModel(StudentModel(affiliation: _studentRegisterCubit.studentModel.affiliation,department: _semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation,).map((e) => e.department??"",).toSet().toList()[p0]));
                                      },
                                      widget: DropDownFieldWidget(
                                        title: "Department",
                                        text: _studentRegisterCubit.studentModel.department??"Select..",
                                        isFilled: false,
                                      ),
                                    ) :InkWell(
                                      onTap: () async{
                                        if(_studentRegisterCubit.studentModel.affiliation!=null){
                                          await _semesterCubit.getSemesterList();
                                        }else{
                                          showMessage("Please select Affiliation");
                                        }
                                      },
                                      child: DropDownFieldWidget(
                                        title: "Department",
                                        text: _studentRegisterCubit.studentModel.department??"Select..",
                                        isFilled: false,
                                      ),
                                    );
                                  }
                                ),
                                SizedBox(height: 10),

                                BlocBuilder(
                                    bloc: _semesterCubit,
                                    builder: (context,statebska) {
                                      return _semesterCubit.semesterList.isNotEmpty && _studentRegisterCubit.studentModel.department!=null? CustomPopMenuButton(
                                        menus: _semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department,).map((e) => e.programName??"",).toSet().toList(),
                                        onSelected: (p0) {
                                          String val=_semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department,).map((e) => e.programName??"",).toSet().toList()[p0];
                                          _studentRegisterCubit.getStudentModel(StudentModel(affiliation: _studentRegisterCubit.studentModel.affiliation,department: _studentRegisterCubit.studentModel.department??"",programName:val));
                                        },
                                        widget: DropDownFieldWidget(
                                          title: "Program",
                                          text: _studentRegisterCubit.studentModel.programName??"Select..",
                                          isFilled: false,
                                        ),
                                      ) :InkWell(
                                        onTap: () async{
                                          if(_studentRegisterCubit.studentModel.department!=null){
                                            await _semesterCubit.getSemesterList();
                                          }else{
                                            showMessage("Please select Department");
                                          }
                                        },
                                        child: DropDownFieldWidget(
                                          title: "Program",
                                          text: _studentRegisterCubit.studentModel.programName??"Select..",
                                          isFilled: false,
                                        ),
                                      );
                                    }
                                ),
                                SizedBox(height: 10),


                                BlocBuilder(
                                    bloc: _semesterCubit,
                                    builder: (context,statebska) {
                                      return _semesterCubit.semesterList.isNotEmpty && _studentRegisterCubit.studentModel.programName!=null? CustomPopMenuButton(
                                        menus: _semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department&&element.programName==_studentRegisterCubit.studentModel.programName,).map((e) => e.degree??"",).toSet().toList(),
                                        onSelected: (p0) {
                                          String val=_semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department&&element.programName==_studentRegisterCubit.studentModel.programName,).map((e) => e.degree??"",).toSet().toList()[p0];
                                          _studentRegisterCubit.getStudentModel(StudentModel(affiliation: _studentRegisterCubit.studentModel.affiliation,department: _studentRegisterCubit.studentModel.department??"",programName:_studentRegisterCubit.studentModel.programName,degree:val));
                                        },
                                        widget: DropDownFieldWidget(
                                          title: "Degree",
                                          text: _studentRegisterCubit.studentModel.degree??"Select..",
                                          isFilled: false,
                                        ),
                                      ) :InkWell(
                                        onTap: () async{
                                          if(_studentRegisterCubit.studentModel.programName!=null){
                                            await _semesterCubit.getSemesterList();
                                          }else{
                                            showMessage("Please select Program");
                                          }
                                        },
                                        child: DropDownFieldWidget(
                                          title: "Degree",
                                          text: _studentRegisterCubit.studentModel.degree??"Select..",
                                          isFilled: false,
                                        ),
                                      );
                                    }
                                ),
                                SizedBox(height: 10),

                                BlocBuilder(
                                    bloc: _semesterCubit,
                                    builder: (context,statebska) {
                                      return _semesterCubit.semesterList.isNotEmpty && _studentRegisterCubit.studentModel.degree!=null? CustomPopMenuButton(
                                        menus: _semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department&&element.programName==_studentRegisterCubit.studentModel.programName&&element.degree==_studentRegisterCubit.studentModel.degree,).map((e) => e.section??"",).toSet().toList(),
                                        onSelected: (p0) {
                                          String val=_semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department&&element.programName==_studentRegisterCubit.studentModel.programName&&element.degree==_studentRegisterCubit.studentModel.degree,).map((e) => e.section??"",).toSet().toList()[p0];
                                          _studentRegisterCubit.getStudentModel(StudentModel(affiliation: _studentRegisterCubit.studentModel.affiliation,department: _studentRegisterCubit.studentModel.department??"",programName:_studentRegisterCubit.studentModel.programName,degree:_studentRegisterCubit.studentModel.degree,section:val));
                                        },
                                        widget: DropDownFieldWidget(
                                          title: "Section",
                                          text: _studentRegisterCubit.studentModel.section??"Select..",
                                          isFilled: false,
                                        ),
                                      ) :InkWell(
                                        onTap: () async{
                                          if(_studentRegisterCubit.studentModel.programName!=null){
                                            await _semesterCubit.getSemesterList();
                                          }else{
                                            showMessage("Please select Degree");
                                          }
                                        },
                                        child: DropDownFieldWidget(
                                          title: "Section",
                                          text: _studentRegisterCubit.studentModel.section??"Select..",
                                          isFilled: false,
                                        ),
                                      );
                                    }
                                ),
                                SizedBox(height: 10),

                                BlocBuilder(
                                    bloc: _semesterCubit,
                                    builder: (context,statebska) {
                                      return _semesterCubit.semesterList.isNotEmpty && _studentRegisterCubit.studentModel.section!=null? CustomPopMenuButton(
                                        menus: _semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department&&element.programName==_studentRegisterCubit.studentModel.programName&&element.degree==_studentRegisterCubit.studentModel.degree&&element.section==_studentRegisterCubit.studentModel.section,).map((e) => e.session??"",).toSet().toList(),
                                        onSelected: (p0) {
                                          String val=_semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department&&element.programName==_studentRegisterCubit.studentModel.programName&&element.degree==_studentRegisterCubit.studentModel.degree&&element.section==_studentRegisterCubit.studentModel.section,).map((e) => e.session??"",).toSet().toList()[p0];
                                          _studentRegisterCubit.getStudentModel(StudentModel(degree:_studentRegisterCubit.studentModel.degree,affiliation: _studentRegisterCubit.studentModel.affiliation,department: _studentRegisterCubit.studentModel.department??"",programName:_studentRegisterCubit.studentModel.programName,section:_studentRegisterCubit.studentModel.section,session: val));
                                        },
                                        widget: DropDownFieldWidget(
                                          title: "Session",
                                          text: _studentRegisterCubit.studentModel.session??"Select..",
                                          isFilled: false,
                                        ),
                                      ) :InkWell(
                                        onTap: () async{
                                          if(_studentRegisterCubit.studentModel.section!=null){
                                            await _semesterCubit.getSemesterList();
                                          }else{
                                            showMessage("Please select Section");
                                          }
                                        },
                                        child: DropDownFieldWidget(
                                          title: "Session",
                                          text: _studentRegisterCubit.studentModel.session??"Select..",
                                          isFilled: false,
                                        ),
                                      );
                                    }
                                ),
                                SizedBox(height: 10),

                                BlocBuilder(
                                    bloc: _semesterCubit,
                                    builder: (context,statebska) {
                                      return _semesterCubit.semesterList.isNotEmpty && _studentRegisterCubit.studentModel.session!=null? CustomPopMenuButton(
                                        menus: _semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department&&element.programName==_studentRegisterCubit.studentModel.programName&&element.degree==_studentRegisterCubit.studentModel.degree&&element.section==_studentRegisterCubit.studentModel.section&&element.session==_studentRegisterCubit.studentModel.session,).map((e) => DataExtractor.extractInt(e.semesterName??"").toString(),).toSet().toList(),
                                        onSelected: (p0) {
                                          String val=_semesterCubit.semesterList.where((element) => element.affiliation==_studentRegisterCubit.studentModel.affiliation&&element.department==_studentRegisterCubit.studentModel.department&&element.programName==_studentRegisterCubit.studentModel.programName&&element.degree==_studentRegisterCubit.studentModel.degree&&element.section==_studentRegisterCubit.studentModel.section&&element.session==_studentRegisterCubit.studentModel.session,).map((e) => DataExtractor.extractInt(e.semesterName??"").toString(),).toSet().toList()[p0];
                                          _studentRegisterCubit.getStudentModel(StudentModel(degree:_studentRegisterCubit.studentModel.degree,affiliation: _studentRegisterCubit.studentModel.affiliation,department: _studentRegisterCubit.studentModel.department??"",programName:_studentRegisterCubit.studentModel.programName,section:_studentRegisterCubit.studentModel.section,session: _studentRegisterCubit.studentModel.session,semester: val));
                                        },
                                        widget: DropDownFieldWidget(
                                          title: "Semester",
                                          text: _studentRegisterCubit.studentModel.semester??"Select..",
                                          isFilled: false,
                                        ),
                                      ) :InkWell(
                                        onTap: () async{
                                          if(_studentRegisterCubit.studentModel.session!=null){
                                            await _semesterCubit.getSemesterList();
                                          }else{
                                            showMessage("Please select Session");
                                          }
                                        },
                                        child: DropDownFieldWidget(
                                          title: "Semester",
                                          text: _studentRegisterCubit.studentModel.semester??"Select..",
                                          isFilled: false,
                                        ),
                                      );
                                    }
                                ),
                                SizedBox(height: 10),

                                CustomPopMenuButton(
                                  menus: ['Active', 'Inactive'],
                                  title: "Status",
                                  onSelected: (p0) {
                                    _studentRegisterCubit.getStatus(['Active', 'Inactive'][p0]);
                                  },
                                  widget: DropDownFieldWidget(
                                    text:_studentRegisterCubit.status?? "Select..",
                                    isFilled: false,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          /// 🔹 SAVE BUTTON
                          CustomElevatedButton(
                            onPressed: () async {
                              if (
                              nameController.text.isEmpty ||
                                  fatherNameController.text.isEmpty ||
                                  contactNumberController.text.isEmpty ||
                                  addressController.text.isEmpty ||
                                  srNoController.text.isEmpty ||
                                  rollNoController.text.isEmpty ||
                                  _studentRegisterCubit.gender==null||
                                  _studentRegisterCubit.status==null
                              ||(_studentRegisterCubit.updateStudentModel==null? _studentRegisterCubit.userImage==null:false)
                              ) {
                                showMessage("Please fill all fields",isError: true);
                                return;
                              }
                              var model=_studentRegisterCubit.studentModel;
                              if(model.affiliation==null || model.department==null || model.programName==null || model.degree==null || model.section==null || model.session==null || model.semester==null){
                                showMessage("Please fill all fields",isError: true);
                                return;
                              }

                              model=model.copyWith(name: nameController.text,fatherName: fatherNameController.text,contact: contactNumberController.text,
                                address: addressController.text,srNo: srNoController.text,rollNo: rollNoController.text,gender: _studentRegisterCubit.gender,
                                userImage: _studentRegisterCubit.userImage,status: _studentRegisterCubit.status
                             ,id:_studentRegisterCubit.updateStudentModel==null?null:_studentRegisterCubit.updateStudentModel!.id, image:_studentRegisterCubit.updateStudentModel?.image??"" );

                              var response=
                              _studentRegisterCubit.updateStudentModel!=null?
                              await _studentRegisterCubit.update(model):
                              await _studentRegisterCubit.post(model);

                              if(response && _studentRegisterCubit.updateStudentModel==null){
                                nameController.clear();
                                    fatherNameController.clear();
                                    contactNumberController.clear();
                                    addressController.clear();
                                    srNoController.clear();
                                    rollNoController.clear();
                                    _studentRegisterCubit.initValues();
                              }else if(_studentRegisterCubit.updateStudentModel!=null){
                                Navigator.pop(context);
                                _studentRegisterCubit.getStudentUpdateModel(null);
                                _studentRegisterCubit.initValues();
                              }

                            },
                            text: "Save",
                            width: mdWidth(context) * .5,
                          ),
                          SafeArea(top: false, child: SizedBox(height: 30)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
