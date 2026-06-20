import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/hod_assignment/models/hod_assign_model.dart';
import 'package:college_management/features/admin/hod_assignment/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_records/presentation/controller/cubit.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';

class AssignHodDepartmentDialog extends StatefulWidget {
  const AssignHodDepartmentDialog({super.key, this.hodAssignModel});
final HodAssignModel? hodAssignModel;
  @override
  State<AssignHodDepartmentDialog> createState() =>
      _AssignHodDepartmentDialogState();
}

class _AssignHodDepartmentDialogState extends State<AssignHodDepartmentDialog> {


  final _departmentCubit=DiContainer().sl<AdminDepartmentCubit>();
  final _teacherCubit=DiContainer().sl<TeacherRecordsCubit>();
  final _hodAssignCubit=DiContainer().sl<HODAssignmentCubit>();
  @override
  void initState() {
    if(widget.hodAssignModel==null){
      _hodAssignCubit.getHodAssignModel(HodAssignModel());
    }else{
      _hodAssignCubit.getHodAssignModel(widget.hodAssignModel!);
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: screenPaddingHori - 3),
      backgroundColor: AppColor.bgPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: AppColor.decorationDialog,
        child: BlocBuilder(
          bloc: _hodAssignCubit,
          builder: (context,statebkal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔹 HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Assign Dept HOD",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: AppColor.grey),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                BlocBuilder(
                  bloc: _teacherCubit,
                  builder: (context,staebkjk) {
                    return _teacherCubit.teacherList.isNotEmpty? CustomPopMenuButton(
                      menus: _teacherCubit.teacherList.map((e) => e.teacherName??"",).toList(),
                      offset: Offset(0, 30),
                      onSelected: (p0) {
                        _hodAssignCubit.getHodAssignModel(_hodAssignCubit.addHodAssignModel.copyWith(teacherName:  _teacherCubit.teacherList.map((e) => e.teacherName??"",).toList()[p0],teacherId: _teacherCubit.teacherList.map((e) => e.id??"",).toList()[p0] ));
                      },
                      widget: DropDownFieldWidget(
                        text: _hodAssignCubit.addHodAssignModel.teacherName??"Select..",
                        maxLine: 1,
                        isFilled: false,
                      ),
                      title: "Faculty Teacher",
                    ):InkWell(
                      onTap: () async{
                       await _teacherCubit.getTeachers();
                      },
                      child: DropDownFieldWidget(
                        title: "Faculty Teacher",
                        text: _hodAssignCubit.addHodAssignModel.teacherName?? "Select..",
                        maxLine: 1,
                        isFilled: false,
                      ),
                    );
                  }
                ),

                SizedBox(height: 10),
                BlocBuilder(
                  bloc: _departmentCubit,
                  builder: (context,statesbk) {
                    return _departmentCubit.departmentList.isNotEmpty? CustomPopMenuButton(
                      menus: _departmentCubit.departmentList.map((e) => e.name,).toList(),
                      onSelected: (p0) {
                        _hodAssignCubit.getHodAssignModel(_hodAssignCubit.addHodAssignModel.copyWith(departmentName:  _departmentCubit.departmentList.map((e) => e.name,).toList()[p0],departmentId: _departmentCubit.departmentList.map((e) => e.id,).toList()[p0]));
                      },
                      offset: Offset(0, 30),
                      widget: DropDownFieldWidget(
                        text:_hodAssignCubit.addHodAssignModel.departmentName?? "Select..",
                        maxLine: 1,
                        isFilled: false,
                      ),
                      title: "Assign to Department",
                    ):InkWell(
                      onTap: () async{
                        await _departmentCubit.getDepartments();
                      },
                      child: DropDownFieldWidget(
                        title: "Assign to Department",
                        text:_hodAssignCubit.addHodAssignModel.departmentName?? "Select..",
                        maxLine: 1,
                        isFilled: false,
                      ),
                    );
                  }
                ),

                SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    DateTime? val = await AppDatePicker.pickCustomDate(
                      context: context,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(3000),
                      firstDate: DateTime(2000),
                    );
                    if (val != null) {
                      _hodAssignCubit.getHodAssignModel(_hodAssignCubit.addHodAssignModel.copyWith(assignedDate: val));
                    }
                  },
                  child: DropDownFieldWidget(
                    text:_hodAssignCubit.addHodAssignModel.assignedDate!=null? DateToStringHelper.dateMonthYearConvert(_hodAssignCubit.addHodAssignModel.assignedDate!):"Select",
                    maxLine: 1,
                    isFilled: false,
                    title: "Date of Assignment",
                  ),
                ),
                SizedBox(height: 10),
                CustomPopMenuButton(
                  menus: ConstantData.hodAssignStatus,
                  offset: Offset(0, 30),
                  onSelected: (p0) {
                    _hodAssignCubit.getHodAssignModel(_hodAssignCubit.addHodAssignModel.copyWith(status: ConstantData.hodAssignStatus[p0]));
                  },
                  widget: DropDownFieldWidget(
                    text:_hodAssignCubit.addHodAssignModel.status?? "Select..",
                    maxLine: 1,
                    isFilled: false,
                  ),
                  title: "Status",
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
                        onPressed: () async {
                          if(_hodAssignCubit.addHodAssignModel.teacherName==null || _hodAssignCubit.addHodAssignModel.departmentName==null || _hodAssignCubit.addHodAssignModel.assignedDate==null|| _hodAssignCubit.addHodAssignModel.status==null){
                            showMessage("Please fill all fields",isError: true);
                            return;
                          }
                       var response=
                           widget.hodAssignModel!=null?
                       await _hodAssignCubit.update(_hodAssignCubit.addHodAssignModel):
                       await _hodAssignCubit.post(_hodAssignCubit.addHodAssignModel);
                        if(response){
                          context.pop();
                        }
                       await _hodAssignCubit.get();
                          },
                        text: "Save",
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
