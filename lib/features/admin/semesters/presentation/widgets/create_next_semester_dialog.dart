// ignore_for_file: must_be_immutable

import 'package:college_management/core/helper/data_extractor.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/helper/app_date_picker.dart';
import '../../../../../core/helper/date_to_string_helper.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/drop_down_field_widget.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../models/semester_levels_model.dart';
import '../controller/cubit.dart';

class CreateNextSemesterDialog extends StatelessWidget {
   CreateNextSemesterDialog({super.key,required this.semesterList});
  List<SemesterLevelsModel> semesterList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _semesterCubit,
      builder: (context,syttkl) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: "",fontSize: 12,),
                AppText(text: "Semester ${DataExtractor.extractInt(_semesterCubit.nextSemesterModel.semesterName)}",fontSize: 15,color: AppColor.white,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1,color: AppColor.grey
                      ),
                    ),
                    child: Icon(Icons.close,size: 15,color: AppColor.grey,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () async {
                DateTime? pickedDate=await  AppDatePicker.pickCustomDate(context: context, initialDate: _semesterCubit.nextSemesterModel.startDate??DateTime.now(), lastDate: DateTime(3000));
                if(pickedDate!=null){
                  final currentEndDate =
                      _semesterCubit.nextSemesterModel.endDate;

                  if (currentEndDate != null &&
                      pickedDate.isAfter(currentEndDate)) {
                    showMessage(
                        "Start date cannot be after end date",isError: true
                    );
                    return;
                  }
                  SemesterLevelsModel model=_semesterCubit.nextSemesterModel;
                  model=model.copyWith(startDate: pickedDate);
                  _semesterCubit.getNextSemesterModel(model);
                }
              },
              child: DropDownFieldWidget(
                title: "Start Date",
                text:_semesterCubit.nextSemesterModel.startDate!=null?DateToStringHelper.dateMonthYearConvert(_semesterCubit.nextSemesterModel.startDate!): "Start Date",
                maxLine: 1,
                isFilled: _semesterCubit.nextSemesterModel.startDate!=null,
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () async {
                DateTime? pickedDate=await  AppDatePicker.pickCustomDate(context: context, initialDate: _semesterCubit.nextSemesterModel.endDate??DateTime.now(), lastDate: DateTime(3000));

                if(pickedDate!=null){
                  final currentStartDate =
                      _semesterCubit.nextSemesterModel.startDate;

                  if (currentStartDate != null &&
                      pickedDate.isBefore(currentStartDate)) {
                    showMessage(
                        "End date cannot be before start date",isError: true
                    );
                    return;
                  }

                  SemesterLevelsModel model=_semesterCubit.nextSemesterModel;
                  model=model.copyWith(endDate: pickedDate);
                  _semesterCubit.getNextSemesterModel(model);
                }
              },
              child: DropDownFieldWidget(
                title: "End Date",
                text:_semesterCubit.nextSemesterModel.endDate!=null? DateToStringHelper.dateMonthYearConvert(_semesterCubit.nextSemesterModel.endDate!): "End Date",
                maxLine: 1,
                isFilled: _semesterCubit.nextSemesterModel.endDate!=null,
              ),
            ),
            SizedBox(height: 15),
            CustomPopMenuButton(
              title: "Status",
              menus: ['Active', 'Inactive'],
              onSelected:  (p0) {
                SemesterLevelsModel model=_semesterCubit.nextSemesterModel;
                model=model.copyWith(status: ['Active', 'Inactive'][p0]);
                _semesterCubit.getNextSemesterModel(model);
              },
              widget: DropDownFieldWidget(text: _semesterCubit.nextSemesterModel.status??"Select", isFilled: true),
            ),
            SizedBox(height: 15),
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
                SizedBox(width: 40,),
                Expanded(
                  child: CustomElevatedButton(onPressed:() async {
                    if(_semesterCubit.nextSemesterModel.endDate==null || _semesterCubit.nextSemesterModel.startDate==null){
                      showMessage("Please fill all fields");
                      return ;
                    }

                    if(semesterList.any((element) => element.id==_semesterCubit.nextSemesterModel.id,)){
                      /// update
                      var respo=await _semesterCubit.editSemester(_semesterCubit.nextSemesterModel);
                      if(respo){
                        Navigator.pop(context);
                        await _semesterCubit.getSemesterList();
                      }
                    }else{
                      /// new create
                      var respo=await _semesterCubit.moveNextSemester(semesterList);
                      if(respo){
                        Navigator.pop(context);
                        await _semesterCubit.getSemesterList();
                      }
                    }

                  }, text:semesterList.any((element) => element.id==_semesterCubit.nextSemesterModel.id,)? "Update":"Create"),
                ),
              ],
            ),
            SizedBox(height: 10,),
          ],
        );
      }
    );
  }
}

final _semesterCubit = DiContainer().sl<SemesterAdminCubit>();

