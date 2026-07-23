import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/freez_unfreez_admin/models/student_freeze_request_model.dart';
import 'package:college_management/features/admin/freez_unfreez_admin/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/image_picker_class.dart';
import '../../../../../core/theme/AppColor.dart';

class StudentFreezeRequestDialog extends StatefulWidget {
  const StudentFreezeRequestDialog({super.key});

  @override
  State<StudentFreezeRequestDialog> createState() => _StudentFreezeRequestDialogState();
}

class _StudentFreezeRequestDialogState extends State<StudentFreezeRequestDialog> {


  var _authCubit=DiContainer().sl<AuthenticationCubit>();
  var _semesterCubit=DiContainer().sl<SemesterAdminCubit>();
  var _freezeCubit=DiContainer().sl<FreezUnFreezCubit>();
  List<String> typeList= ['Freeze', 'Withdraw', 'Unfreeze'];

  TextEditingController reasonController=TextEditingController();
 @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      _freezeCubit.initStudentFreezeRequestDialog();
    await  _semesterCubit.getSemesterList();
    },);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDialog(child:
    SingleChildScrollView(
      child: BlocBuilder(
        bloc:  _semesterCubit,
        builder: (context,statebs) {
          return  BlocBuilder(
            bloc: _freezeCubit,
            builder: (context,statevsj) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropDownFieldWidget(text: _authCubit.userModel?.studentDepartment??"", title: "Department:",isFilled: true),
                  SizedBox(height: 10,),

                  DropDownFieldWidget(text: _authCubit.userModel?.programName??"", title: "Program:",isFilled: true),
                  SizedBox(height: 10,),

                  DropDownFieldWidget(text: _authCubit.userModel?.session??"", title: "Session:",isFilled: true),
                  SizedBox(height: 10,),

                  DropDownFieldWidget(text: _authCubit.userModel?.section??"", title: "Section:",isFilled: true),
                  SizedBox(height: 10,),

                  InkWell(
                    onTap: () async{
                      if(_semesterCubit.semesterList.where((element) => element.status=="Active",).isEmpty){
                      await  _semesterCubit.getSemesterList();
                      }
                    },
                      child: DropDownFieldWidget(text:_semesterCubit.semesterList.isNotEmpty && _semesterCubit.semesterList.where((element) => element.status=="Active",).isNotEmpty? _semesterCubit.semesterList.where((element) => element.status=="Active",).first.semesterName??"Select":"Select", title: "Semester:",isFilled: true)),
                  SizedBox(height: 10,),

                  CustomPopMenuButton(menus:typeList,
                    title: "Request Type:",
                  onSelected: (p0) {
                    _freezeCubit.getStudentFreezeType(val:typeList[p0]);
                  },
                  widget:
                  DropDownFieldWidget(text:_freezeCubit.studentFreezeType?? "Select..", isFilled: _freezeCubit.studentFreezeType!=null),
                  ),

                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () async {
                      var resp = await ImagePickerClass.pickFile();
                      if (resp != null) {
                        _freezeCubit.getStudentFreezRequestModel(StudentFreezeRequestModel(attFile: resp));
                      }
                    },
                    child: DropDownFieldWidget(
                      text:
                      _freezeCubit
                          .studentFreezeRequestModel!=null&& _freezeCubit
                          .studentFreezeRequestModel
                          !.attFile !=
                          null
                          ? "File Picked":"Select",
                      isFilled: _freezeCubit
                          .studentFreezeRequestModel!=null&& _freezeCubit
                          .studentFreezeRequestModel
                          !.attFile !=
                          null,
                      title: "Attach File (Optional)",
                    ),
                  ),

                  SizedBox(height: 10,),
                  CustomTextFormField(controller: reasonController, subTitle: "Write your reason...",title: "Reason:",isHintText: true,),




                  SizedBox(height: 20,),

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
                      Expanded(child:
                      CustomElevatedButton(
                          onPressed: () async {
                            if(_semesterCubit.semesterList.where((element) => element.status=="Active",).isEmpty){
                              showMessage("Semester not found");
                              return;
                            }

                            if(_freezeCubit.studentFreezeType==null){
                              showMessage("Please select type");
                              return;
                            }

                            if(reasonController.text.isEmpty){
                              showMessage("Please provide your reason");
                              return;
                            }


                            StudentFreezeRequestModel model=StudentFreezeRequestModel(semesterId: _semesterCubit.semesterList.where((element) => element.status=="Active",).first.id,
                            attFile: _freezeCubit.studentFreezeRequestModel?.attFile,studentId: _authCubit.userModel?.studentObjectId??'',
                              reason:reasonController.text,requestType: _freezeCubit.studentFreezeType??""
                            );

                            var respo=await _freezeCubit.post(model);

                            if(respo){
                              Navigator.pop(context);
                              await _freezeCubit.getMyRequest();
                            }


                          },

                          text: "Submit"))
                    ],
                  )


                ],
              );
            }
          );
        }
      ),
    ));
  }
}