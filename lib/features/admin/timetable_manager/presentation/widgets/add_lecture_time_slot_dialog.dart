import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/teacher_allocation/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/timetable_manager/models/new_slot_model.dart';
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
  var _courseMappingController=DiContainer().sl<CourseMappingCubit>();
  var _teacherAllocationCubit=DiContainer().sl<TeacherAllocationCubit>();
  var _timeTableManagerCubit=DiContainer().sl<TimetableManagerCubit>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timeTableManagerCubit.getTableCell(model: TimeTableCellModel());
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
              bloc: _courseMappingController,
              builder: (context,stateskja) {
                return _courseMappingController.courseMappingList.isNotEmpty?
                CustomPopMenuButton(menus: _courseMappingController.courseMappingList.where((element) => element.affiliation==widget.timeTableManagerModel.affiliation&&element.degree==widget.timeTableManagerModel.degree&&element.department==widget.timeTableManagerModel.department&&element.program==widget.timeTableManagerModel.programName&&element.session==widget.timeTableManagerModel.session&&element.section==widget.timeTableManagerModel.section&&DataExtractor.extractInt(element.semesterName)==widget.timeTableManagerModel.semesterLevel,).map((e) => e.courseTitle??"",).toList(),
                  onSelected: (p0) {
                  String subjectName=_courseMappingController.courseMappingList.where((element) => element.affiliation==widget.timeTableManagerModel.affiliation&&element.degree==widget.timeTableManagerModel.degree&&element.department==widget.timeTableManagerModel.department&&element.program==widget.timeTableManagerModel.programName&&element.session==widget.timeTableManagerModel.session&&element.section==widget.timeTableManagerModel.section&&DataExtractor.extractInt(element.semesterName)==widget.timeTableManagerModel.semesterLevel,).map((e) => e.courseTitle??"",).toList()[p0];
                  String courseId=_courseMappingController.courseMappingList.where((element) => element.affiliation==widget.timeTableManagerModel.affiliation&&element.degree==widget.timeTableManagerModel.degree&&element.department==widget.timeTableManagerModel.department&&element.program==widget.timeTableManagerModel.programName&&element.session==widget.timeTableManagerModel.session&&element.section==widget.timeTableManagerModel.section&&DataExtractor.extractInt(element.semesterName)==widget.timeTableManagerModel.semesterLevel,).map((e) => e.courseId??"",).toList()[p0];
                    _timeTableManagerCubit.getTableCell(model:_timeTableManagerCubit.tableCellModel.copyWith(subject:subjectName,courseId: courseId ));
                  },
                  title: "Subject"
                  ,widget: DropDownFieldWidget(text:_timeTableManagerCubit.tableCellModel.subject?? "Select..",isFilled: false,),): InkWell(
                    onTap: () async{
                     await _courseMappingController.getMappingData();
                    },
                    child: DropDownFieldWidget(
                      title: "Subject",
                      text:_timeTableManagerCubit.tableCellModel.subject?? "Select..",isFilled: false,));
              }
            ),
            SizedBox(height: 10,),
            BlocBuilder(
              bloc: _teacherAllocationCubit,
              builder: (context,statevbjhak) {
                return _teacherAllocationCubit.teacherAllocationList.isNotEmpty?
                CustomPopMenuButton(menus: _teacherAllocationCubit.teacherAllocationList.where((element) => element.affiliation==widget.timeTableManagerModel.affiliation&&element.degree==widget.timeTableManagerModel.degree&&element.department==widget.timeTableManagerModel.department&&element.programName==widget.timeTableManagerModel.programName&&element.section==widget.timeTableManagerModel.section).map((e) => e.teacherName??"",).toList(),
                  onSelected: (p0) {
                    String teacherName=_teacherAllocationCubit.teacherAllocationList.where((element) => element.affiliation==widget.timeTableManagerModel.affiliation&&element.degree==widget.timeTableManagerModel.degree&&element.department==widget.timeTableManagerModel.department&&element.programName==widget.timeTableManagerModel.programName&&element.section==widget.timeTableManagerModel.section).map((e) => e.teacherName??"",).toList()[p0];
                    _timeTableManagerCubit.getTableCell(model: _timeTableManagerCubit.tableCellModel.copyWith(teacher: teacherName));
                    },
                  title: "Instructor",
                  widget: DropDownFieldWidget(text:_timeTableManagerCubit.tableCellModel.teacher?? "Select..",isFilled: false,),)
                    :
                InkWell(
                  onTap: () async{
                    await _teacherAllocationCubit.get();
                  },
                  child: DropDownFieldWidget(
                    title: "Instructor",
                    text:_timeTableManagerCubit.tableCellModel.teacher?? "Select..",isFilled: false,),
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
