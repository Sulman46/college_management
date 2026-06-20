import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/helper/date_to_string_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/timetable_manager/models/new_slot_model.dart';
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

class AddNewTimeSlot extends StatefulWidget {
   AddNewTimeSlot({super.key,required this.timeTableManagerModel});
TimeTableManagerModel timeTableManagerModel;

  @override
  State<AddNewTimeSlot> createState() => _AddNewTimeSlotState();
}

class _AddNewTimeSlotState extends State<AddNewTimeSlot> {
  var _timeTableCubit=DiContainer().sl<TimetableManagerCubit>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timeTableCubit.getSlotTime(model: NewSlotModel());
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _timeTableCubit,
      builder: (context,statesbkb) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(text: "Add Time Slot",fontSize: 15,color: AppColor.white,fontWeight: FontWeight.w600,),
            SizedBox(height: 10,),
            InkWell(
                onTap: () async {
                TimeOfDay? time=await  AppDatePicker.timePicker(context);
                if(time!=null){
                  _timeTableCubit.getSlotTime(model:_timeTableCubit.newSlotModel.copyWith(slotTimeStart:DateToStringHelper.formatTime(time)));
                }
                },
                child: DropDownFieldWidget(text: _timeTableCubit.newSlotModel.slotTimeStart?? "Select",title: "Lecture Time Start", isFilled: _timeTableCubit.newSlotModel.slotTimeStart!=null)),
            SizedBox(height: 10,),
             InkWell(
                 onTap: () async {
                   TimeOfDay? time=await  AppDatePicker.timePicker(context);
                   if(time!=null){
                     _timeTableCubit.getSlotTime(model:_timeTableCubit.newSlotModel.copyWith(slotTimeEnd:DateToStringHelper.formatTime(time)));

                   }
                 },
                 child: DropDownFieldWidget(text: _timeTableCubit.newSlotModel.slotTimeEnd??"Select",title: "Lecture Time End", isFilled:  _timeTableCubit.newSlotModel.slotTimeEnd!=null)),
            if(widget.timeTableManagerModel.timeSlots!.isNotEmpty)
            ...[
              SizedBox(height: 10,),
              CustomPopMenuButton(menus: widget.timeTableManagerModel.timeSlots??[],
                onSelected: (p0) {
                  _timeTableCubit.getSlotTime(model: _timeTableCubit.newSlotModel.copyWith(referenceSlot:  widget.timeTableManagerModel.timeSlots?[p0]??""));
                },
                title: "Reference Slot",widget: DropDownFieldWidget(text:_timeTableCubit.newSlotModel.referenceSlot?? "Select", isFilled:  _timeTableCubit.newSlotModel.referenceSlot!=null),),
              SizedBox(height: 10,),
            CustomPopMenuButton(menus: ["Before","After"],
              onSelected: (p0) {
                _timeTableCubit.getSlotTime(model: _timeTableCubit.newSlotModel.copyWith(positionSlot:  ["Before","After"][p0]));

              },
              title: "Position",widget: DropDownFieldWidget(text:_timeTableCubit.newSlotModel.positionSlot?? "Select", isFilled:  _timeTableCubit.newSlotModel.positionSlot!=null),),
            ],

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
                    onPressed: () async {

                      var model=_timeTableCubit.newSlotModel;

                      if(model.slotTimeEnd==null || model.slotTimeStart==null){
                        showMessage("Please fill all fields",isError: true);
                        return;
                      }

                      if(widget.timeTableManagerModel.timeSlots!.isNotEmpty){
                        if(model.referenceSlot==null || model.positionSlot==null){
                          showMessage("Please fill all fields",isError: true);
                          return;
                        }

                      }

                      String newSlotValue="${model.slotTimeStart}-${model.slotTimeEnd}";

                      var timeTableModel=widget.timeTableManagerModel;
                      List<String> slotList=List.from(timeTableModel.timeSlots??[]);

                      if(slotList.isEmpty){
                        slotList.add(newSlotValue);
                      }else{
                        int referenceSlotIndex=slotList.indexOf(model.referenceSlot??"");
                        if (referenceSlotIndex == -1) {
                          showMessage("Reference slot not found");
                          return;
                        }

                        if(model.positionSlot=="Before"){
                          slotList.insert(referenceSlotIndex, newSlotValue);
                        }else{
                          slotList.insert(referenceSlotIndex+1, newSlotValue);
                        }
                      }

                      timeTableModel=timeTableModel.copyWith(timeSlots: slotList);

                     var response= await _timeTableCubit.update(timeTableModel);
                     if(response){
                       Navigator.pop(context);
                     }

                    },
                    text: "Save",
                  ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}
