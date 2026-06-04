import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_text_style.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/departments/data/model/department_model.dart';
import 'package:college_management/features/admin/departments/data/model/request_new_department_model.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';



class AddDepartmentDialog extends StatefulWidget {
   AddDepartmentDialog({super.key,this.editDepartmentModel});
DepartmentModel? editDepartmentModel;
  @override
  State<AddDepartmentDialog> createState() => _AddDepartmentDialogState();
}

class _AddDepartmentDialogState extends State<AddDepartmentDialog> {

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
var _departmentCubit=DiContainer().sl<AdminDepartmentCubit>();


  @override
  void initState() {
    if(widget.editDepartmentModel!=null){
      codeController.text=widget.editDepartmentModel?.code??"";
      nameController.text=widget.editDepartmentModel?.name??"";
      _departmentCubit.getStatus(widget.editDepartmentModel!.status.name);
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 13),
      backgroundColor: AppColor.bgPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: BlocBuilder(
        bloc: _departmentCubit,
        builder: (context,statesbjb) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal:10,vertical: 15),
            decoration: AppColor.decorationDialog,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔹 HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Register Academic Unit",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: AppColor.grey),
                    )
                  ],
                ),

                SizedBox(height: 20),

                /// 🔹 DEPARTMENT CODE
                AppText(
                  text: "DEPARTMENT ID CODE :",
                  fontSize: 11,
                  color: AppColor.grey,
                ),
                SizedBox(height: 6),

                CustomTextFormField(
                  controller: codeController,
                  subTitle: "e.g., CS-IQ",
                  isHintText: true,
                ),

                SizedBox(height: 5),

                /// 🔹 ERROR TEXT
                AppText(
                  text:
                  "Provide a unique identifier (e.g., CS, MATH, PHY)",
                  fontSize: 11,
                  color: AppColor.red,
                ),

                SizedBox(height: 15),

                /// 🔹 NAME
                AppText(
                  text: "OFFICIAL DEPARTMENT NAME :",
                  fontSize: 11,
                  color: AppColor.grey,
                ),
                SizedBox(height: 6),

                CustomTextFormField(
                  controller: nameController,
                  subTitle: "e.g., Faculty of Computing",
                  isHintText: true,
                ),

                SizedBox(height: 15),
                AppText(
                  text: "STATUS :",
                  fontSize: 11,
                  color: AppColor.grey,
                ),

                SizedBox(height: 6),

                /// 🔹 STATUS
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color:AppColor.primary.withOpacity(.5),width: .5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: PopupMenuButton<String>(
                    offset: Offset(1, 30),
                    color: AppColor.white,
                    padding: EdgeInsets.zero,
                    onSelected: (val) {
                      _departmentCubit.getStatus(val);
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        height: 30,
                        padding: EdgeInsets.only(left: 10),
                        value: "Active",
                        child: AppText(text: "Active"),
                      ),
                      PopupMenuItem(
                        height: 30,
                        padding: EdgeInsets.only(left: 10),
                        value: "Inactive",
                        child: AppText(text: "Inactive"),
                      ),
                    ],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(text: _departmentCubit.departmentStatus,style: AppTextStyle.hintTextStyle(),),
                        Icon(Icons.keyboard_arrow_down, color: AppColor.primary),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 25),

                /// 🔹 BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        text: "Discard",
                        bgColor: AppColor.white,
                        textColor: AppColor.red,
                        borderColor: AppColor.red,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () async{
                          if(nameController.text.isEmpty || codeController.text.isEmpty){
                            showMessage("Please fill all required fields",isError: true);
                            return;
                          }
                          if(widget.editDepartmentModel!=null){
                            var respo=   await _departmentCubit.editDepartment(model: RequestNewDepartmentModel(name: nameController.text, code: codeController.text, status: _departmentCubit.departmentStatus,id: widget.editDepartmentModel?.id??""));
                            if(respo){
                              Navigator.pop(context);
                            }
                          }else{
                            var respo=   await _departmentCubit.addDepartment(model: RequestNewDepartmentModel(name: nameController.text, code: codeController.text, status: _departmentCubit.departmentStatus));
                            // TODO: Submit logic
                            if(respo){
                              nameController.clear();
                              codeController.clear();
                              _departmentCubit.getStatus("Active");
                            }
                          }

                        },
                        text: "Save",
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
