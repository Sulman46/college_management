
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/timetable_manager/models/new_slot_model.dart';
import 'package:college_management/features/admin/timetable_manager/models/time_table_manger_model.dart';
import 'package:college_management/features/admin/timetable_manager/presentation/controller/cubit.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/drop_down_field_widget.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/custom_button.dart';

class RemoveSlotDialog extends StatefulWidget {
  RemoveSlotDialog({super.key,required this.timeTableManagerModel});
  TimeTableManagerModel timeTableManagerModel;

  @override
  State<RemoveSlotDialog> createState() => _RemoveSlotDialogState();
}

class _RemoveSlotDialogState extends State<RemoveSlotDialog> {
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
      builder: (context,statevjhl) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(text: "Remove Time Slot",fontSize: 15,color: AppColor.white,fontWeight: FontWeight.w600,),
            SizedBox(height: 10,),
            CustomPopMenuButton(menus: widget.timeTableManagerModel.timeSlots??[],
              onSelected: (p0) {
                _timeTableCubit.getSlotTime(model: _timeTableCubit.newSlotModel.copyWith(referenceSlot:  widget.timeTableManagerModel.timeSlots?[p0]??""));
              },
              title: "Slot",widget: DropDownFieldWidget(text:_timeTableCubit.newSlotModel.referenceSlot?? "Select", isFilled: _timeTableCubit.newSlotModel.referenceSlot!=null),),
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


                      if(widget.timeTableManagerModel.timeSlots!.isNotEmpty){
                        if(model.referenceSlot==null ){
                          showMessage("Please fill all fields",isError: true);
                          return;
                        }
                      }

                      var timeTableModel=widget.timeTableManagerModel;
                      List<String> slotList=List.from(timeTableModel.timeSlots??[]);
                      Map<String, TimeTableCellModel> slotLectures=timeTableModel.data??{};
                      slotLectures.removeWhere((key, value) => key.contains(_timeTableCubit.newSlotModel.referenceSlot!),);
                      slotList.removeWhere((element) => element==_timeTableCubit.newSlotModel.referenceSlot,);
                      timeTableModel=timeTableModel.copyWith(timeSlots: slotList,data: slotLectures);

                      var response= await _timeTableCubit.update(timeTableModel);
                      if(response){
                        Navigator.pop(context);
                        await _timeTableCubit.get();
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
