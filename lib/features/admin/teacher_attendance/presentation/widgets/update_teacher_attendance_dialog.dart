import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/constants/constant_data.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../models/teacher_attendance_model.dart';
import '../controller/cubit.dart';

class UpdateTeacherAttendanceDialog extends StatefulWidget {
   UpdateTeacherAttendanceDialog({super.key,required this.model});
  TeacherAttendanceModel model;
  @override
  State<UpdateTeacherAttendanceDialog> createState() => _UpdateTeacherAttendanceDialogState();
}

class _UpdateTeacherAttendanceDialogState extends State<UpdateTeacherAttendanceDialog> {
  final _teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();
  TextEditingController minutesController=TextEditingController();
  @override
  void initState() {
    _teacherAttendanceCubit.getUpdateTeacherAttendType(widget.model.status??"Present");

    minutesController.text="${widget.model.minutes??""}";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
      children: [
        AppText(text: "Add Slot",fontSize: 15,color: AppColor.white,fontWeight: FontWeight.w600,),
        SizedBox(height: 5,),

        CustomPopMenuButton(
          menus: ConstantData.teacherAttendanceStatus,
          onSelected: (p0) {
            _teacherAttendanceCubit.getUpdateTeacherAttendType(ConstantData.teacherAttendanceStatus[p0]);
          },
          widget: DropDownFieldWidget(text:_teacherAttendanceCubit.updateTeacherAttendanceStatus, isFilled: true),),
        if(_teacherAttendanceCubit.updateTeacherAttendanceStatus=="Late"|| _teacherAttendanceCubit.updateTeacherAttendanceStatus=="Early Left")
          ...[SizedBox(height: 10,),
            CustomTextFormField(
              controller: minutesController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              subTitle: "Minutes",
            ),],
        SizedBox(height: 15,),

        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                onPressed: () => Navigator.pop(context),
                text: "Discard",
                height: 30,
                bgColor: AppColor.white,
                textColor: AppColor.red,
                borderColor: AppColor.red,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: CustomElevatedButton(
                height: 30,
                onPressed: () async {

                  if( (_teacherAttendanceCubit.updateTeacherAttendanceStatus=="Late"|| _teacherAttendanceCubit.updateTeacherAttendanceStatus=="Early Left")?minutesController.text.isNotEmpty:true){
                    var dataModel=widget.model;

                    dataModel=dataModel.copyWith(minutes:   _teacherAttendanceCubit.updateTeacherAttendanceStatus=="Late"|| _teacherAttendanceCubit.updateTeacherAttendanceStatus=="Early Left" ? int.parse(minutesController.text.isNotEmpty?minutesController.text:"0"):0,status: _teacherAttendanceCubit.updateTeacherAttendanceStatus);

                 var respo=await _teacherAttendanceCubit.update(dataModel);
                 if(respo){
                   Navigator.pop(context);
                   await _teacherAttendanceCubit.get();
                 }
                  }else {
                    showMessage("Please fill required fields");
                  }
                  // TODO: Submit logic
                },
                text: "Save",
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
