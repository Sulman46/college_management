import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/teacher_records/presentation/page/teacher_record_details_screen.dart';
import 'package:college_management/widgets/active_inactive_status_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../widgets/more_vert_pop_menu_button.dart';
import '../../models/teacher_model.dart';
import '../controller/cubit.dart';

class TeacherRecordItemWidget extends StatelessWidget {
   TeacherRecordItemWidget({super.key,required this.model});
  TeacherModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        context.push('/Admin-teacher-record-details',extra: model);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration:AppColor.containerNeon,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text:model.teacherName??"",fontSize: 12,color: AppColor.white,fontWeight: FontWeight.w600,),
            SizedBox(height: 3,),
            Row(
              children: [
                Expanded(child: AppText(text: "Dept. ${model.department!.join(", ")}",fontSize: 11,color: AppColor.grey,fontWeight: FontWeight.w500,)),
                AppText(text: "(${model.qualification})",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActiveInactiveStatusWidget(isActive: model.status=="Active"),
                CustomPopMenuButton(
                  menus: ["Edit",model.status=="Active"?"Inactive":"Active","Delete"],
                  onSelected: (value) async {
                    var teacherRecordCubit=DiContainer().sl<TeacherRecordsCubit>();
                    if(value==0){
                      context.push('/Admin-add-teacher-record',extra: model);
                    }else if(value==1){
                      if(model.status=="Active"){
                        await  teacherRecordCubit.update(model.copyWith(status: "Inactive"));

                      }else{
                        await  teacherRecordCubit.update(model.copyWith(status: "Active"));

                      }
                    }
                    else{
                   await  teacherRecordCubit.delete(model);
                    }
                  },),
              ],
            )
          ],
        ),
      ),
    );
  }
}
