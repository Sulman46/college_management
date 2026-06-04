import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/course_catalog/presentation/widgets/catalog_depart_widget.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_records/models/teacher_model.dart';
import 'package:college_management/features/admin/teacher_records/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
   AddTeacherRecordScreen({super.key,this.teacherModel});
TeacherModel? teacherModel;
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

  var _teacherRecordCubit=DiContainer().sl<TeacherRecordsCubit>();
  var _departmentCubit=DiContainer().sl<AdminDepartmentCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      if(widget.teacherModel!=null){
        emailController.text=widget.teacherModel?.email??"";
        teacherNameController.text=widget.teacherModel?.teacherName??"";
        phoneController.text=widget.teacherModel?.phone??"";
        bankNameController.text=widget.teacherModel?.bankName??"";
        accountNumberController.text=widget.teacherModel?.accountNo??"";
        specialization.text=widget.teacherModel?.specialization??"";
        rateLecture.text="${widget.teacherModel?.ratePerLecture??""}";
        weeklyWorkLoad.text="${widget.teacherModel?.targetWorkload??""}";
        joiningDateController.text=widget.teacherModel?.joiningDate??"";
      }
      _teacherRecordCubit.getTeacherModel(widget.teacherModel??TeacherModel());

    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _teacherRecordCubit,
        builder: (context,stateskloa) {
          return Column(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            CustomPopMenuButton(menus: ["Male", "Female", "Other"],
                              onSelected: (p0) {

                                _teacherRecordCubit.getTeacherModel(_teacherRecordCubit.teacherModel.copyWith(gender:["Male", "Female", "Other"][p0] ));
                              },
                              widget: DropDownFieldWidget(text:_teacherRecordCubit.teacherModel.gender?? "Gender..", isFilled: false),title: "Gender",),
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
                            CustomPopMenuButton(menus: ConstantData.qualificationList,
                              onSelected: (p0) {
                                _teacherRecordCubit.getTeacherModel(_teacherRecordCubit.teacherModel.copyWith(qualification:ConstantData.qualificationList[p0] ));
                              },
                              widget: DropDownFieldWidget(text:_teacherRecordCubit.teacherModel.qualification
                                  ??"Select", isFilled: false),title: "Qualification",),
                            SizedBox(height: 10,),
                            AppText(
                              text: "Job Assignment",
                              fontSize: 12,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 5,),
                            BlocBuilder(
                              bloc: _departmentCubit,
                              builder: (context,statesbkl) {
                                return _departmentCubit.departmentList.isNotEmpty? CustomPopMenuButton(
                                  menus: _departmentCubit.departmentList.map((e) => e.name,).toList(),
                                    title: "Department",
                                onSelected: (p0) {
                                  String val=_departmentCubit.departmentList.map((e) => e.name,).toList()[p0];
                                  List<String> departmentList=_teacherRecordCubit.teacherModel.department??[];
                                  departmentList.add(val);
                                  _teacherRecordCubit.getTeacherModel(_teacherRecordCubit.teacherModel.copyWith(department: departmentList));
                                },
                                  widget: DropDownFieldWidget(text: "Select", isFilled: false),)
                                :InkWell(
                                    onTap: () async{
                                     await _departmentCubit.getDepartments();
                                    },
                                    child: DropDownFieldWidget(

                                        title: "Department",
                                        text: "Select", isFilled: false));
                              }
                            ),
                            if(_teacherRecordCubit.teacherModel.department!=null && _teacherRecordCubit.teacherModel.department!.isNotEmpty)
                              Wrap(
                                children: List.generate(_teacherRecordCubit.teacherModel.department?.length??0, (index) => CatalogDepartWidget(text: _teacherRecordCubit.teacherModel.department![index], onTap: () {
                                  List<String> list=List.from(_teacherRecordCubit.teacherModel.department??[]);
                                  list.removeWhere((element) => element==_teacherRecordCubit.teacherModel.department![index],);
                                  _teacherRecordCubit.getTeacherModel(_teacherRecordCubit.teacherModel.copyWith(department: list));

                                },),),
                              ),
                            SizedBox(height: 10,),
                            CustomPopMenuButton(menus: ConstantData.designationList,
                              onSelected: (p0) {
                                _teacherRecordCubit.getTeacherModel(_teacherRecordCubit.teacherModel.copyWith(designation: ConstantData.designationList[p0]));

                              },
                              widget: DropDownFieldWidget(text:_teacherRecordCubit.teacherModel.designation?? "Select", isFilled: false),title: "Designation",),
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
                                Expanded(child: CustomPopMenuButton(menus: ["Permanent", "Visiting"],
                                  onSelected: (p0) {
                                    _teacherRecordCubit.getTeacherModel(_teacherRecordCubit.teacherModel.copyWith(teacherType: ["Permanent", "Visiting"][p0]));

                                  },
                                  widget: DropDownFieldWidget(text:_teacherRecordCubit.teacherModel.teacherType?? "Select", isFilled: false),title: "Job Type",)),
                                SizedBox(width: 10,),
                                Expanded(child: CustomTextFormField(
                                  isHintText: true,
                                  controller: joiningDateController,readOnly: true, subTitle: "Date",title: "Joining Date",onTap: () async {
                                  DateTime? val = await AppDatePicker.pickCustomDate(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime.now().add(Duration(days: 365)),
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: rateLecture, subTitle: "e.g. 1500",title: "Rate/Lecture(Rs)",),
                            SizedBox(height: 10,),
                            CustomTextFormField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                              keyboardType: TextInputType.number,
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
                            Center(
                              child: CustomElevatedButton(onPressed: () async {

                                if(emailController.text.isEmpty || teacherNameController.text.isEmpty ||phoneController.text.isEmpty||specialization.text.isEmpty
                                || joiningDateController.text.isEmpty || rateLecture.text.isEmpty ||weeklyWorkLoad.text.isEmpty || bankNameController.text.isEmpty
                                || accountNumberController.text.isEmpty || _teacherRecordCubit.teacherModel.teacherType==null || _teacherRecordCubit.teacherModel.designation==null
                                || _teacherRecordCubit.teacherModel.department == null||_teacherRecordCubit.teacherModel.gender == null|| _teacherRecordCubit.teacherModel.qualification == null || _teacherRecordCubit.teacherModel.department!.isEmpty){
                                  return showMessage("Please fill all fields");
                                }

                                var val=_teacherRecordCubit.teacherModel;

                                TeacherModel model=TeacherModel(id: val.id,status: val.status,department:val.department,email: emailController.text,accountNo: accountNumberController.text,allocationType: val.allocationType,
                                bankName: bankNameController.text,designation: val.designation,gender: val.gender,joiningDate: joiningDateController.text,phone: phoneController.text,qualification: val.qualification,ratePerLecture: double.parse(rateLecture.text)
                                ,specialization: specialization.text,targetWorkload: double.parse(weeklyWorkLoad.text),teacherName: teacherNameController.text,teacherType: val.teacherType);

                                 var response=
                                 widget.teacherModel!=null?
                                 await _teacherRecordCubit.update(model):
                                 await _teacherRecordCubit.addTeacher(model);
                                if(response){
                                  context.pop();
                                }
                              }, text: "Submit",width: mdWidth(context)*.6,),
                            ),

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
          );
        }
      ),
    );
  }
}
