import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/leave_request/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/data_not_found_widget.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/teacher_send_leave_request_model.dart';

class LeaveRequestDialog extends StatefulWidget {
  const LeaveRequestDialog({super.key});

  @override
  State<LeaveRequestDialog> createState() => _LeaveRequestDialogState();
}

class _LeaveRequestDialogState extends State<LeaveRequestDialog> {
  TextEditingController reasonController=TextEditingController();
  var leaveCubit=DiContainer().sl<LeaveRequestCubit>();
  var authCubit=DiContainer().sl<AuthenticationCubit>();
  var departmentCubit=DiContainer().sl<AdminDepartmentCubit>();
  List<String> teacherLeaveTypeList=["Casual", "Sick", "Short Leave", "Duty Leave", "Emergency"];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      leaveCubit.getTeacherLeaveData(type: null, startDate: null, endDate: null);
      await departmentCubit.getDepartments();
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDialog(child:
    BlocBuilder(
      bloc: departmentCubit,
      builder: (context,staetsla) {
        return SingleChildScrollView(
          child: BlocBuilder(
            bloc: leaveCubit,
            builder: (context,statejks) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                  if(departmentCubit.departmentList.isEmpty)
               ...[ DataNotFoundWidget(onTap: () async{
                  await departmentCubit.getDepartments();
                },),
                 SizedBox(height: 20,),
                 CustomElevatedButton(onPressed: (){
                   Navigator.pop(context);
                 }, text: "Discard",height: 30,bgColor: AppColor.whiteLight,textColor: AppColor.grey,),

               ]
                  else
                 ...[ CustomPopMenuButton(menus: teacherLeaveTypeList,
                    onSelected: (p0) {
                      leaveCubit.getTeacherLeaveData(type: teacherLeaveTypeList[p0], startDate: leaveCubit.startLeaveDate, endDate: leaveCubit.endLeaveDate);

                    },
                    widget: DropDownFieldWidget(text:leaveCubit.leaveType?? "Select", isFilled: leaveCubit.leaveType!=null),title: "Leave Type:",),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: InkWell(
                        splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () async{
                            DateTime? res=await AppDatePicker.pickCustomDate(context: context, initialDate: DateTime.now(), lastDate: DateTime(3000));
                            if(res!=null){
                              leaveCubit.getTeacherLeaveData(type: leaveCubit.leaveType, startDate: res, endDate: leaveCubit.endLeaveDate);
                            }
                            },
                          child: DropDownFieldWidget(text:leaveCubit.startLeaveDate!=null? DateToStringHelper.dateMonthYearConvert(leaveCubit.startLeaveDate!): "Select",title: 'From', isFilled: leaveCubit.startLeaveDate!=null))),
                      SizedBox(width: 10,),
                      Expanded(child: InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async {
                            DateTime? res=await AppDatePicker.pickCustomDate(context: context, initialDate: DateTime.now(), lastDate: DateTime(3000));
                            if(res!=null){
                              leaveCubit.getTeacherLeaveData(type: leaveCubit.leaveType, startDate: leaveCubit.startLeaveDate, endDate: res);
                            }
                          },
                          child: DropDownFieldWidget(text:leaveCubit.endLeaveDate!=null? DateToStringHelper.dateMonthYearConvert(leaveCubit.endLeaveDate!): "Select",title: 'To', isFilled: leaveCubit.endLeaveDate!=null))),
                    ],
                  ),
                  SizedBox(height: 10,),

                  CustomTextFormField(controller: reasonController, isHintText: true,subTitle: "reason",title: "Reason",textInputAction: TextInputAction.newline,maxLines: 3,keyboardType: TextInputType.multiline,),
                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(child: CustomElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, text: "Discard",height: 30,bgColor: AppColor.whiteLight,textColor: AppColor.grey,)),
                      SizedBox(width: 20,),
                      Expanded(child: CustomElevatedButton(onPressed: ()async{
                        if(leaveCubit.startLeaveDate==null ||leaveCubit.endLeaveDate==null ||leaveCubit.leaveType==null || reasonController.text.isEmpty ){
                          showMessage("Please fill all fields");
                          return;
                        }

                        TeacherSendLeaveRequestModel value=TeacherSendLeaveRequestModel(leaveType: leaveCubit.leaveType??"", teacherId: authCubit.userModel?.id??"", departments: departmentCubit.departmentList.where((element) => authCubit.userModel!.department.contains(element.name),).map((e) => e.id,).toList(), reason: reasonController.text, startDate: leaveCubit.startLeaveDate!, endDate: leaveCubit.endLeaveDate!);

                        showMessage("teacher id :${value.toMap()}: ${authCubit.userModel?.teacherId??""}");

                        var resp=await leaveCubit.post(value);
                        if(resp){
                          Navigator.pop(context);
                          await leaveCubit.get();
                        }

                      }, text: "Submit",height: 30,)),
                    ],
                  ),],
                  SafeArea(top: false,child: SizedBox(),),

                ],
              );
            }
          ),
        );
      }
    ));
  }
}
