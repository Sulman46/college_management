import 'package:college_management/core/helper/app_date_picker.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/exam_schedule/models/exam_schedule_widget_model.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../controller/cubit.dart';

class ExamScheduleWidget extends StatefulWidget {
   ExamScheduleWidget({super.key,required this.model});
ExamScheduleWidgetModel model;

  @override
  State<ExamScheduleWidget> createState() => _ExamScheduleWidgetState();
}

class _ExamScheduleWidgetState extends State<ExamScheduleWidget> {
  final _examScheduleCubit=DiContainer().sl<ExamScheduleCubit>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: AppColor.bgPrimary.withOpacity(.5), // glass tint
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColor.primary.withOpacity(.5),
          width: .5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: widget.model.courseTitle??"-",fontSize: 11,color: AppColor.white,),
          SizedBox(height: 3,),
          AppText(text: "Code: ${widget.model.courseCode??"-"}",fontSize: 11,color: AppColor.white,),
          SizedBox(height: 3,),
          Row(
            children: [
              Expanded(child: InkWell(

              onTap: ()async {
                DateTime? val = await AppDatePicker.pickCustomDate(
                  context: context,
                  initialDate:widget.model.examDate?? DateTime.now(),
                  lastDate: DateTime(3000),
                  firstDate: DateTime(2000),
                );
                if(val!=null){
                  _examScheduleCubit.updateModel(widget.model.copyWith(examDate: val));
                }
                },
                  child: DropDownFieldWidget(text: widget.model.examDate!=null?DateToStringHelper.dateMonthYearConvert(widget.model.examDate!):"mm/dd/yyyy", isFilled: true,icon:Icons.date_range_outlined))),
              SizedBox(width: 10,),
              Expanded(child: InkWell(
                  onTap: ()async {
                    TimeOfDay? time=await  AppDatePicker.timePicker(context,initialTime: widget.model.examTime??TimeOfDay(hour: 00, minute: 00));
                    if(time!=null){
                      _examScheduleCubit.updateModel(widget.model.copyWith(examTime: time));
                    }
                  },
                  child: DropDownFieldWidget(text:  widget.model.examTime!=null?DateToStringHelper.formatTime(widget.model.examTime!):"--/--", isFilled: true,icon:Icons.timer))),
            ],
          ),

        ],
      ),
    );
  }
}
