import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/departments/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/programs/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/semesters/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/timetable_manager/models/time_table_manger_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/controller/cubit.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/app_date_picker.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_button.dart';

class AddSheet extends StatefulWidget {
   AddSheet({super.key,this.timeModel});
TimeTableManagerModel? timeModel;
  @override
  State<AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<AddSheet> {
  final _timeTableManagerCubit = DiContainer().sl<TimetableManagerCubit>();
  final _semesterCubit = DiContainer().sl<SemesterAdminCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.timeModel!=null){
        _timeTableManagerCubit.getTimeTableManagerModel(widget.timeModel!);
      }else{
        _timeTableManagerCubit.getTimeTableManagerModel(TimeTableManagerModel());
      }
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _timeTableManagerCubit,
      builder: (context,statebskj) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text:widget.timeModel==null? "New Timetable Sheet":"Update Timetable Sheet",
                fontSize: 15,
                color: AppColor.primary,
              ),
              SizedBox(height: 10),
              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, staetsbkn) {
                  return _semesterCubit.activeSemesterList.isNotEmpty? CustomPopMenuButton(
                    menus: _semesterCubit.activeSemesterList.map((e) => e.affiliation??"",).toSet().toList(),
                    onSelected: (p0) {
                      _timeTableManagerCubit.getTimeTableManagerModel(TimeTableManagerModel(affiliation:_semesterCubit.activeSemesterList.map((e) => e.affiliation??"",).toSet().toList()[p0] ));
                    },
                    title: "Affiliation",
                    widget: DropDownFieldWidget(text:_timeTableManagerCubit.addTimeTableManagerModel.affiliation?? "Select..", isFilled: _timeTableManagerCubit.addTimeTableManagerModel.affiliation!=null),
                  ):InkWell(
                      onTap: () async{
                       await _semesterCubit.getSemesterList();
                      },
                      child: DropDownFieldWidget(title: "Affiliation",text:_timeTableManagerCubit.addTimeTableManagerModel.affiliation?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.affiliation!=null));
                },
              ),
              SizedBox(height: 10),
              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context, staetsbkn) {
                  return _semesterCubit.activeSemesterList.isNotEmpty? CustomPopMenuButton(
                    menus: _semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation,).map((e) => e.department??"",).toSet().toList(),
                    onSelected: (p0) {
                      _timeTableManagerCubit.getTimeTableManagerModel(TimeTableManagerModel(
                          affiliation: _timeTableManagerCubit.addTimeTableManagerModel.affiliation,
                          department:_semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation,).map((e) => e.department??"",).toSet().toList()[p0] ));
                    },
                    title: "Department",
                    widget: DropDownFieldWidget(text:_timeTableManagerCubit.addTimeTableManagerModel.department?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.department!=null),
                  ):InkWell(
                      onTap: () async{
                       await _semesterCubit.getSemesterList();
                      },
                      child: DropDownFieldWidget(title: "Department",text:_timeTableManagerCubit.addTimeTableManagerModel.department?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.department!=null));
                },
              ),
              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context,statebka) {
                  return _semesterCubit.activeSemesterList.isNotEmpty? CustomPopMenuButton(
                    menus: _semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department,).map((e) => e.programName??"",).toSet().toList(),
                    onSelected: (p0) {
                      _timeTableManagerCubit.getTimeTableManagerModel(TimeTableManagerModel(
                          affiliation: _timeTableManagerCubit.addTimeTableManagerModel.affiliation,
                          department: _timeTableManagerCubit.addTimeTableManagerModel.department,programName:_semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department,).map((e) => e.programName??"",).toSet().toList()[p0] ));
                    },
                    title: "Program",
                    widget:
                    DropDownFieldWidget(text:_timeTableManagerCubit.addTimeTableManagerModel.programName?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.programName!=null),
                  ):
                  InkWell(
                      onTap: () async{
                        await _semesterCubit.getSemesterList();
                      },
                      child: DropDownFieldWidget(
                          title: "Program",
                          text:_timeTableManagerCubit.addTimeTableManagerModel.programName?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.programName!=null));
                }
              ),
              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context,statebka) {
                  return _semesterCubit.activeSemesterList.isNotEmpty? CustomPopMenuButton(
                    menus: _semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department &&element.programName==_timeTableManagerCubit.addTimeTableManagerModel.programName).map((e) => e.degree??"",).toSet().toList(),
                    onSelected: (p0) {
                      _timeTableManagerCubit.getTimeTableManagerModel(TimeTableManagerModel(
                          affiliation: _timeTableManagerCubit.addTimeTableManagerModel.affiliation,
                          department: _timeTableManagerCubit.addTimeTableManagerModel.department,programName:_timeTableManagerCubit.addTimeTableManagerModel.programName,
                          degree: _semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department &&element.programName==_timeTableManagerCubit.addTimeTableManagerModel.programName).map((e) => e.degree??"",).toSet().toList()[p0]));
                    },
                    title: "Degree",
                    widget:
                    DropDownFieldWidget(text:_timeTableManagerCubit.addTimeTableManagerModel.degree?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.degree!=null),
                  ):
                  InkWell(
                      onTap: () async{
                        await _semesterCubit.getSemesterList();
                      },
                      child: DropDownFieldWidget(
                          title: "Degree",
                          text:_timeTableManagerCubit.addTimeTableManagerModel.degree?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.degree!=null));
                }
              ),

              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context,statebskn) {
                  return  _semesterCubit.activeSemesterList.isNotEmpty? CustomPopMenuButton(
                    menus: _semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department &&element.programName==_timeTableManagerCubit.addTimeTableManagerModel.programName &&element.degree==_timeTableManagerCubit.addTimeTableManagerModel.degree).map((e) => e.section??"",).toSet().toList(),
                    onSelected: (p0) {
                      _timeTableManagerCubit.getTimeTableManagerModel(TimeTableManagerModel(
                          affiliation: _timeTableManagerCubit.addTimeTableManagerModel.affiliation,
                          degree: _timeTableManagerCubit.addTimeTableManagerModel.degree,
                          department: _timeTableManagerCubit.addTimeTableManagerModel.department,programName:_timeTableManagerCubit.addTimeTableManagerModel.programName,
                          section: _semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department &&element.programName==_timeTableManagerCubit.addTimeTableManagerModel.programName&&element.degree==_timeTableManagerCubit.addTimeTableManagerModel.degree).map((e) => e.section??"",).toSet().toList()[p0]));
                    },
                    title: "Section",
                    widget:
                    DropDownFieldWidget(text:_timeTableManagerCubit.addTimeTableManagerModel.section?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.section!=null),
                  ):
                  InkWell(
                      onTap: () async{
                        await _semesterCubit.getSemesterList();
                      },
                      child: DropDownFieldWidget(
                          title: "Section",
                          text:_timeTableManagerCubit.addTimeTableManagerModel.section?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.section!=null));
                }
              ),
              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context,staetsbkj) {
                  return _semesterCubit.activeSemesterList.isNotEmpty? CustomPopMenuButton(
                    menus: _semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department &&element.programName==_timeTableManagerCubit.addTimeTableManagerModel.programName &&element.degree==_timeTableManagerCubit.addTimeTableManagerModel.degree&& element.section==_timeTableManagerCubit.addTimeTableManagerModel.section).map((e) => e.session??"",).toSet().toList(),
                    onSelected: (p0) {
                      _timeTableManagerCubit.getTimeTableManagerModel(TimeTableManagerModel(
                          affiliation: _timeTableManagerCubit.addTimeTableManagerModel.affiliation,
                          department: _timeTableManagerCubit.addTimeTableManagerModel.department,
                          degree: _timeTableManagerCubit.addTimeTableManagerModel.degree,
                          programName:_timeTableManagerCubit.addTimeTableManagerModel.programName,
                          section:_timeTableManagerCubit.addTimeTableManagerModel.section,
                          session: _semesterCubit.activeSemesterList.where((element) => element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department &&element.programName==_timeTableManagerCubit.addTimeTableManagerModel.programName&&element.degree==_timeTableManagerCubit.addTimeTableManagerModel.degree && element.section==_timeTableManagerCubit.addTimeTableManagerModel.section).map((e) => e.session??"",).toSet().toList()[p0]));
                    },
                    title: "Session",
                    widget:
                    DropDownFieldWidget(text:_timeTableManagerCubit.addTimeTableManagerModel.session?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.session!=null),
                  ):
                  InkWell(
                      onTap: () async{
                        await _semesterCubit.getSemesterList();
                      },
                      child: DropDownFieldWidget(
                          title: "Session",
                          text:_timeTableManagerCubit.addTimeTableManagerModel.session?? "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.session!=null));
                }
              ),
              SizedBox(height: 10),

              BlocBuilder(
                bloc: _semesterCubit,
                builder: (context,statebska) {
                  return _semesterCubit.activeSemesterList.isNotEmpty? CustomPopMenuButton(
                    menus:  _semesterCubit.activeSemesterList.where((element) =>element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department &&  element.programName==_timeTableManagerCubit.addTimeTableManagerModel.programName&&element.degree==_timeTableManagerCubit.addTimeTableManagerModel.degree&&  element.section==_timeTableManagerCubit.addTimeTableManagerModel.section&&  element.session==_timeTableManagerCubit.addTimeTableManagerModel.session,).map((e) => e.semesterName??"",).toSet().toList(),
                    onSelected: (p0) {
                      _timeTableManagerCubit.getTimeTableManagerModel(TimeTableManagerModel(
                          affiliation: _timeTableManagerCubit.addTimeTableManagerModel.affiliation,
                          department: _timeTableManagerCubit.addTimeTableManagerModel.department,
                          degree: _timeTableManagerCubit.addTimeTableManagerModel.degree,
                          programName:_timeTableManagerCubit.addTimeTableManagerModel.programName,
                          section: _timeTableManagerCubit.addTimeTableManagerModel.section,
                          session: _timeTableManagerCubit.addTimeTableManagerModel.session,
                          semesterLevel: DataExtractor.extractInt(_semesterCubit.activeSemesterList.where((element) =>element.affiliation==_timeTableManagerCubit.addTimeTableManagerModel.affiliation&& element.department==_timeTableManagerCubit.addTimeTableManagerModel.department &&  element.programName==_timeTableManagerCubit.addTimeTableManagerModel.programName&&element.degree==_timeTableManagerCubit.addTimeTableManagerModel.degree&&  element.section==_timeTableManagerCubit.addTimeTableManagerModel.section&&  element.session==_timeTableManagerCubit.addTimeTableManagerModel.session,).map((e) => e.semesterName??"",).toSet().toList()[p0])));
                    },
                    title: "Active Semester",
                    widget: DropDownFieldWidget(text: _timeTableManagerCubit.addTimeTableManagerModel.semesterLevel!=null?_timeTableManagerCubit.addTimeTableManagerModel.semesterLevel.toString(): "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.semesterLevel!=null),
                  ):InkWell(
                      onTap: () async{
                        await _semesterCubit.getSemesterList();
                      },
                      child: DropDownFieldWidget(
                          title: "Active Semester",
                          text:_timeTableManagerCubit.addTimeTableManagerModel.semesterLevel!=null?_timeTableManagerCubit.addTimeTableManagerModel.semesterLevel.toString(): "Select..", isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.semesterLevel!=null));
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
                    _timeTableManagerCubit.getTimeTableManagerModel(_timeTableManagerCubit.addTimeTableManagerModel.copyWith(wefDate: val));

                  }
                },
                child: DropDownFieldWidget(
                  text:_timeTableManagerCubit.addTimeTableManagerModel.wefDate!=null? DateToStringHelper.dateMonthYearConvert(_timeTableManagerCubit.addTimeTableManagerModel.wefDate!):"Select..",
                  isFilled:  _timeTableManagerCubit.addTimeTableManagerModel.wefDate!=null,
                  title: "W.E.F Date",
                ),
              ),
              SizedBox(height: 10),
              CustomPopMenuButton(menus: [
                "Morning",
                "Evening"
              ],
                onSelected: (p0) {
                  _timeTableManagerCubit.getShiftType( [
                    "Morning",
                    "Evening"
                  ][p0]);
                },
                widget: DropDownFieldWidget(
                text:_timeTableManagerCubit.shiftType??"Select..",
                isFilled:  _timeTableManagerCubit.shiftType!=null,
                title: "Shift type",
              ),),
              SizedBox(height: 10),
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
                        var model=_timeTableManagerCubit.addTimeTableManagerModel;
                        if(_timeTableManagerCubit.shiftType==null||model.affiliation==null || model.department==null || model.programName==null || model.degree==null || model.section==null || model.session==null || model.wefDate==null || model.semesterLevel==null){
                         showMessage("Please fill all fields",isError: true);
                          return;
                        }

                        if(widget.timeModel==null){
                          model=model.copyWith(timeSlots: _timeTableManagerCubit.shiftType=="Morning"?ConstantData.morningSlot:ConstantData.eveningSlot);
                          var response=await _timeTableManagerCubit.post(model);
                          if(response){
                            Navigator.pop(context);
                          }
                        }else{

                          var val=widget.timeModel;
                          val=val!.copyWith(affiliation: model.affiliation,section: model.section,session: model.session,department: model.department,programName: model.programName,degree: model.degree,semesterLevel: model.semesterLevel,wefDate: model.wefDate);
                          var response=await _timeTableManagerCubit.update(val);
                          if(response){
                            Navigator.pop(context);
                          }
                        }

                        // TODO: Submit logic
                      },
                      text: "Save",
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
