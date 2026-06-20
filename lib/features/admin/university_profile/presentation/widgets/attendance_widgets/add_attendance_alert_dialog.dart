
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/university_profile/models/attendance_policy_model.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/AppColor.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text_form.dart';
import '../../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../../models/university_model.dart';
import '../../controller/cubit.dart';




class AddAttendanceAlertDialog extends StatefulWidget {
  AddAttendanceAlertDialog({super.key,this.attendancePolicyModel});
  AttendancePolicyModel? attendancePolicyModel;
  @override
  State<AddAttendanceAlertDialog> createState() => _AddAttendanceAlertDialogState();
}

class _AddAttendanceAlertDialogState extends State<AddAttendanceAlertDialog> {

  final TextEditingController tagLabel = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController triggerValue = TextEditingController();
  final TextEditingController action = TextEditingController();
  var _universitySetupCubit = DiContainer().sl<UniversityProfileCubit>();


  @override
  void initState() {
    if(widget.attendancePolicyModel!=null){
      tagLabel.text=widget.attendancePolicyModel?.tag??"";
      title.text=widget.attendancePolicyModel?.title??"";
      triggerValue.text=widget.attendancePolicyModel?.val??"";
      action.text=widget.attendancePolicyModel?.action??"";
      _universitySetupCubit.getSeverityValue(widget.attendancePolicyModel?.type??"");

    }else{
      _universitySetupCubit.getSeverityValue(null);
      
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
          bloc: _universitySetupCubit,
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
                        text:widget.attendancePolicyModel!=null? "Update Escalation Level":"Add Escalation Level",
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
                  CustomTextFormField(
                    title: "Title :",
                    controller: title,
                    subTitle: "e.g., First Warning",
                    isHintText: true,
                  ),


                  SizedBox(height: 15),
                  CustomTextFormField(
                    title: "Tag Label :",
                    controller: tagLabel,
                    subTitle: "e.g., Initial Alert",
                    isHintText: true,
                  ),


                  SizedBox(height: 15),

                  CustomPopMenuButton(
                      title:"Severity",
                      onSelected: (p0) {
                        _universitySetupCubit.getSeverityValue(ConstantData.severityList[p0]);
                      },
                      menus:ConstantData.severityList,
                      widget:DropDownFieldWidget(text:_universitySetupCubit.severityValue?? "Select",
                          isFilled: _universitySetupCubit.severityValue!=null)),

                  SizedBox(height: 15),





                  CustomTextFormField(
                    title: "Trigger Value :",
                    keyboardType: TextInputType.number,
                    controller: triggerValue,
                    subTitle: "e.g., 75%",
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    isHintText: true,
                  ),


                  SizedBox(height: 15),


                  CustomTextFormField(
                    title: "System Action :",
                    controller: action,
                    subTitle: "e.g., Send Notification",
                    isHintText: true,
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
                            if(_universitySetupCubit.severityValue==null||title.text.isEmpty || tagLabel.text.isEmpty|| triggerValue.text.isEmpty|| action.text.isEmpty){
                              showMessage("Please fill all fields",isError: true);
                              return;
                            }
                              AttendancePolicyModel value=AttendancePolicyModel(id:widget.attendancePolicyModel!=null? widget.attendancePolicyModel?.id??0:int.parse("${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().millisecond}"),
                                  type:_universitySetupCubit.severityValue?.toLowerCase()??"" , tag: tagLabel.text, title: title.text, val: triggerValue.text, action: action.text);
                              var attendanceList=_universitySetupCubit.universityModel?.attendancePolicyModel??[];
                              if(widget.attendancePolicyModel!=null){
                                int index=attendanceList.indexWhere((element) => element.id==widget.attendancePolicyModel!.id,);
                                attendanceList[index]=value;
                              }else{
                                attendanceList.add(value);
                              }
                              UniversityModel model=UniversityModel(attendancePolicyModel: attendanceList);
                              bool val= await _universitySetupCubit.addUniversitySetup(model);
                              if(val){
                                Navigator.pop(context);
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
