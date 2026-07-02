
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/course_catalog/models/course_catalog_model.dart';
import 'package:college_management/features/admin/course_catalog/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/course_catalog/presentation/widgets/catalog_depart_widget.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../departments/presentation/controller/cubit.dart';



class AddNewCourseCatalogDialog extends StatefulWidget {
   AddNewCourseCatalogDialog({super.key,this.courseCatalogModel});
CourseCatalogModel? courseCatalogModel;
  @override
  State<AddNewCourseCatalogDialog> createState() => _AddNewCourseCatalogDialogState();
}

class _AddNewCourseCatalogDialogState extends State<AddNewCourseCatalogDialog> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController creditHour = TextEditingController();
  final _departmentCubit = DiContainer().sl<AdminDepartmentCubit>();
  final _courseCatalogCubit = DiContainer().sl<CourseCatalogAdminCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.courseCatalogModel !=null){
        titleController.text=widget.courseCatalogModel?.courseTitle??"";
        creditHour.text="${widget.courseCatalogModel?.creditHours??""}";
        codeController.text=widget.courseCatalogModel?.courseCode??"";
        _courseCatalogCubit.getDepartment(depart: widget.courseCatalogModel?.departments??[], type: widget.courseCatalogModel?.type??"", category: widget.courseCatalogModel?.category??"");

      }else{
        _courseCatalogCubit.getDepartment(depart: [], type: "", category: "");
      }
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDialog(child: BlocBuilder(
      bloc: _courseCatalogCubit,
      builder: (context,syayebkja) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text:widget.courseCatalogModel!=null?"Update Course Catalog": "Add New Course",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: AppColor.grey),
                )
              ],
            ),

            SizedBox(height: 10),

            CustomTextFormField(
              title: "Course Title:",
              controller: titleController,
              subTitle: "Title..",
              isHintText: true,
            ),

            SizedBox(height: 15),


            BlocBuilder(
                bloc: _departmentCubit,
                builder: (context,statesbjbl) {
                  return _departmentCubit.departmentList.isEmpty
                      ? InkWell(
                    onTap: () async {
                      await _departmentCubit
                          .getDepartments();
                    },
                    child: DropDownFieldWidget(
                      title: "Department :",

                      text:"Dept..", isFilled: false,
                    ),
                  ): CustomPopMenuButton(
                    onSelected: (p0) {
                      var list=_courseCatalogCubit.department;
                      var val=_departmentCubit
                          .activeDepartmentList
                          .map((e) => "${e.name} (${e.code})")
                          .toSet().toList()[p0];
                      var model=_departmentCubit.activeDepartmentList.where((e) => "${e.name} (${e.code})"==val,).first;

                      var selectedModel=CourseCatalogDepartmentModel(id: model.id,name: model.name);
                      if(list.where((element) => element.id==selectedModel.id,).toList().isNotEmpty){
                        list.removeWhere((element) => element.id==selectedModel.id,);
                      }
                      list.add(CourseCatalogDepartmentModel(id: model.id,name: model.name));
                      list=list.toSet().toList();
                      _courseCatalogCubit.getDepartment(
                        depart:list ,
                        type: _courseCatalogCubit
                            .courseType,
                        category: _courseCatalogCubit.courseCategory,
                      );
                    },
                    menus: _departmentCubit.activeDepartmentList
                        .map((e) => "${e.name} (${e.code})")
                        .toSet().toList(),offset: Offset(0, 30),widget: SizedBox(
                      width: mdWidth(context),
                      child: DropDownFieldWidget(
                          title: "Department :",
                          text:"Dept..",maxLine: 1, isFilled: false)),);
                }
            ),


            if(_courseCatalogCubit.department.isNotEmpty)
              Wrap(
                  children: _courseCatalogCubit.department.map((e) => CatalogDepartWidget(text: e.name??"", onTap: () {
                    _courseCatalogCubit.removeDepartment(e);
                  },),).toSet().toList() ),
            SizedBox(height: 15),

            /// 🔹 NAME
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        title:"Course Code:" ,
                        controller: codeController,
                        subTitle: "CS-101",
                        isHintText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        title: "Credit Hour :",
                        controller: creditHour,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                        subTitle: "e.g., 1",
                        isHintText: true,
                      ),
                    ],
                  ),
                ),

              ],
            ),

            SizedBox(height: 15),

            /// 🔹 NAME
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomPopMenuButton(
                        title:  "Category :",
                        onSelected: (p0) {
                          _courseCatalogCubit.getDepartment(
                            depart: _courseCatalogCubit.department,
                            type: _courseCatalogCubit
                                .courseType,
                            category: ['Core', 'Supporting', 'Elective', 'General'][p0],
                          );
                        },
                        menus: ['Core', 'Supporting', 'Elective', 'General'],offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text:_courseCatalogCubit.courseCategory!=""?_courseCatalogCubit.courseCategory: "Category..",maxLine: 1, isFilled: _courseCatalogCubit.courseCategory!="")),),
                    ],
                  ),
                ),

                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CustomPopMenuButton(
                        title: "Type :",
                        onSelected:  (p0) {
                          _courseCatalogCubit.getDepartment(
                            depart: _courseCatalogCubit.department,
                            type: ConstantData.courseTypes[p0],
                            category: _courseCatalogCubit
                                .courseCategory,
                          );
                        },
                        menus:  ConstantData.courseTypes,offset: Offset(0, 30),widget: SizedBox(
                          width: mdWidth(context),
                          child: DropDownFieldWidget(text:_courseCatalogCubit.courseType!=""?_courseCatalogCubit.courseType: "Type..",maxLine: 1, isFilled: _courseCatalogCubit.courseType!="")),),
                    ],
                  ),
                ),
              ],
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
                    onPressed: ()async {
                      if(_courseCatalogCubit.courseCategory=="" || _courseCatalogCubit.department.isEmpty || _courseCatalogCubit.courseType==""|| codeController.text.isEmpty || titleController.text.isEmpty || creditHour.text.isEmpty){
                        showMessage("Please fill all fields",isError: true);
                        return ;
                      }
                      CourseCatalogModel model=
                      widget.courseCatalogModel!=null? CourseCatalogModel(id: widget.courseCatalogModel?.id??"",status: widget.courseCatalogModel?.status??"Inactive",category: _courseCatalogCubit.courseCategory,courseCode: codeController.text,courseTitle: titleController.text,departments: _courseCatalogCubit.department,type: _courseCatalogCubit.courseType,creditHours: double.parse(creditHour.text)):
                      CourseCatalogModel(category: _courseCatalogCubit.courseCategory,courseCode: codeController.text,courseTitle: titleController.text,departments: _courseCatalogCubit.department,type: _courseCatalogCubit.courseType,creditHours: double.parse(creditHour.text));

                      var respo= widget.courseCatalogModel!=null?
                      await _courseCatalogCubit.updateCatalog(val: model)
                          :await _courseCatalogCubit.addCourseCatalog(val: model);
                      if(respo){
                        Navigator.pop(context);
                        await _courseCatalogCubit.getCourseCatalogList();
                      }
                      // TODO: Submit logic
                    },
                    text: "Save",
                  ),
                ),
              ],
            )
          ],
        );
      }
    ));
  }
}
