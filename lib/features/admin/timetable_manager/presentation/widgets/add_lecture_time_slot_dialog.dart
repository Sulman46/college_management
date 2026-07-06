import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/teacher_allocation/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/timetable_manager/models/time_table_manger_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/controller/cubit.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/custom_button.dart';

class AddLectureTimeSlotDialog extends StatefulWidget {
   AddLectureTimeSlotDialog({super.key,required this.timeTableManagerModel,required this.keyValue});
TimeTableManagerModel timeTableManagerModel;
String keyValue;
  @override
  State<AddLectureTimeSlotDialog> createState() => _AddLectureTimeSlotDialogState();
}

class _AddLectureTimeSlotDialogState extends State<AddLectureTimeSlotDialog> {
  TextEditingController roomController=TextEditingController();
  final _teacherAllocationCubit=DiContainer().sl<TeacherAllocationCubit>();
  final _timeTableManagerCubit=DiContainer().sl<TimetableManagerCubit>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _timeTableManagerCubit.getTableCell(model: TimeTableCellModel());
      await _teacherAllocationCubit.get();
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _timeTableManagerCubit,
      builder: (context,stategbvja) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(text: "Add Slot",fontSize: 15,color: AppColor.white,fontWeight: FontWeight.w600,),
            SizedBox(height: 10,),
            BlocBuilder(
              bloc: _teacherAllocationCubit,
              builder: (context,stateskja) {
                return _teacherAllocationCubit.activeTeacherAllocationList.isNotEmpty?
                CustomPopMenuButton(menus: _teacherAllocationCubit.activeTeacherAllocationList.where((element) => element.semesterId==widget.timeTableManagerModel.semesterModel?.id).map((e) => "${e.courseName??""} ",).toSet().toList(),
                  onSelected: (p0) {
                  String subjectName=_teacherAllocationCubit.activeTeacherAllocationList.where((element) => element.semesterId==widget.timeTableManagerModel.semesterModel?.id).map((e) => e.courseName??"",).toSet().toList()[p0];
                  String? subjectId=_teacherAllocationCubit.activeTeacherAllocationList.where((element) => element.semesterId==widget.timeTableManagerModel.semesterModel?.id && element.courseName==subjectName).map((e) => e.courseMappingId??"",).toSet().toList().first;
                    _timeTableManagerCubit.getTableCell(model:TimeTableCellModel(subject: subjectName,courseId: subjectId));
                  },
                  title: "Subject"
                  ,widget: DropDownFieldWidget(text:_timeTableManagerCubit.tableCellModel.subject?? "Select..",isFilled: _timeTableManagerCubit.tableCellModel.subject!=null,),): InkWell(
                    onTap: () async{
                      await _teacherAllocationCubit.get();
                    },
                    child: DropDownFieldWidget(
                      title: "Subject",
                      text:_timeTableManagerCubit.tableCellModel.subject?? "Select..",isFilled: _timeTableManagerCubit.tableCellModel.subject!=null,));
              }
            ),
            SizedBox(height: 10,),
            BlocBuilder(
              bloc: _teacherAllocationCubit,
              builder: (context,statevbjhak) {
                return _teacherAllocationCubit.teacherAllocationList.isNotEmpty?
                CustomPopMenuButton(menus: _teacherAllocationCubit.activeTeacherAllocationList.where((element) => element.semesterId==widget.timeTableManagerModel.semesterModel?.id && element.courseName==_timeTableManagerCubit.tableCellModel.subject).map((e) => e.teacherName??"",).toList(),
                  onSelected: (p0) {
                    String teacherName= _teacherAllocationCubit.activeTeacherAllocationList.where((element) => element.semesterId==widget.timeTableManagerModel.semesterModel?.id && element.courseName==_timeTableManagerCubit.tableCellModel.subject).map((e) => e.teacherName??"",).toList()[p0];
                    String teacherId= _teacherAllocationCubit.activeTeacherAllocationList.where((element) => element.semesterId==widget.timeTableManagerModel.semesterModel?.id && element.courseName==_timeTableManagerCubit.tableCellModel.subject && element.teacherName==teacherName).map((e) => e.id??"",).first;
                    _timeTableManagerCubit.getTableCell(model:TimeTableCellModel(subject: _timeTableManagerCubit.tableCellModel.subject,courseId:_timeTableManagerCubit.tableCellModel.courseId,teacher: teacherName,teacherId:teacherId ));
                    },
                  title: "Instructor",
                  widget: DropDownFieldWidget(text:_timeTableManagerCubit.tableCellModel.teacher?? "Select..",isFilled: _timeTableManagerCubit.tableCellModel.teacher!=null,),)
                  : InkWell(
                  onTap: () async{
                    await _teacherAllocationCubit.get();
                  },
                  child: DropDownFieldWidget(
                    title: "Instructor",
                    text:_timeTableManagerCubit.tableCellModel.teacher?? "Select..",isFilled: _timeTableManagerCubit.tableCellModel.teacher!=null,),
                );
              }
            ),
            SizedBox(height: 10,),
            CustomTextFormField(controller: roomController,
              keyboardType: TextInputType.number,
              isHintText: true,
              subTitle: "e.g. 5",title: "Room",inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],),
            SizedBox(height: 10,),
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
                      if(_timeTableManagerCubit.tableCellModel.teacher==null || _timeTableManagerCubit.tableCellModel.subject==null||_timeTableManagerCubit.tableCellModel.courseId==null || roomController.text.isEmpty){
                        showMessage("Please fill all fields",isError: true);
                        return;
                      }
                      var value=_timeTableManagerCubit.tableCellModel;
                      value=value.copyWith(room: roomController.text);
                      var oldTimeModel=widget.timeTableManagerModel;
                      var slotMap=oldTimeModel.data;
                      slotMap!.addAll({widget.keyValue:value});
                      oldTimeModel=oldTimeModel.copyWith(data: slotMap);
                      var response=await _timeTableManagerCubit.update(oldTimeModel);
                      if(response){
                        Navigator.pop(context);
                        await _timeTableManagerCubit.get();
                      }
                    },
                    text: "Save",
                  ),
                ),
              ],
            )
          ],
        );
      }
    );
  }
}
