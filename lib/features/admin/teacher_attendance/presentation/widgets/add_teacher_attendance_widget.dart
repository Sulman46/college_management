
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/teacher_attendance/models/teacher_attendance_time_table_model.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../controller/cubit.dart';

class AddTeacherAttendanceWidget extends StatefulWidget {
   AddTeacherAttendanceWidget({super.key,required this.teacherAttendanceTimeTableModel,required this.index});
  TeacherAttendanceTimeTableModel teacherAttendanceTimeTableModel;
  int index;
  @override
  State<AddTeacherAttendanceWidget> createState() => _AddTeacherAttendanceWidgetState();
}

class _AddTeacherAttendanceWidgetState extends State<AddTeacherAttendanceWidget> {
  TextEditingController minutesController=TextEditingController();
  @override
  void initState() {
    minutesController.text=widget.teacherAttendanceTimeTableModel.minutes;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      margin: EdgeInsets.only(top: 8),
      decoration: AppColor.containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: widget.teacherAttendanceTimeTableModel.tableCellModel.teacher??"",fontSize: 11,color: AppColor.white,),
          SizedBox(height: 3,),
          AppText(text: widget.teacherAttendanceTimeTableModel.tableCellModel.subject??"",fontSize: 11,color: AppColor.white,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: "Slot: ${widget.teacherAttendanceTimeTableModel.slotTime}",fontSize: 11,color: AppColor.greyLight,),
              AppText(text: "Room: ${widget.teacherAttendanceTimeTableModel.tableCellModel.room??""}",fontSize: 11,color: AppColor.greyLight,),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomPopMenuButton(
                  menus: ConstantData.teacherAttendanceStatus,
                  onSelected: (p0) {
                    final teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();
                    teacherAttendanceCubit.updateType(type: ConstantData.teacherAttendanceStatus[p0], index: widget.index);

                  },
                  widget: DropDownFieldWidget(text:widget.teacherAttendanceTimeTableModel.status, isFilled: true),),
              ),
              if(widget.teacherAttendanceTimeTableModel.status=="Late"|| widget.teacherAttendanceTimeTableModel.status=="Early Left")
              ...[SizedBox(width: 5,),
              Expanded(
                child: CustomTextFormField(
                    controller: minutesController,
                    onChanged: (p0) {
                      final teacherAttendanceCubit = DiContainer().sl<TeacherAttendanceCubit>();
                      teacherAttendanceCubit.updateMinutes(minutes: p0, index: widget.index);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  subTitle: "Minutes",
                ),
              ),]
            ],
          )

        ],
      ),
    );
  }
}
