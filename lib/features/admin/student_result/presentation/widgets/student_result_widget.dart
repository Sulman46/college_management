
import 'package:college_management/features/admin/student_result/model/user_result_model.dart';
import 'package:college_management/features/admin/student_result/presentation/widgets/result_status_widget.dart';
import 'package:college_management/features/admin/student_result/presentation/widgets/user_result_detail_dialog.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/AppColor.dart';

class StudentResultWidget extends StatelessWidget {
   StudentResultWidget({super.key,required this.model});
UserResultModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(context: context, builder: (context) => UserResultDetailDialog(model: model),);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColor.white.withOpacity(.2),
            ),
          ),
          color:AppColor.bgPrimary.withOpacity(.6),
          boxShadow: AppColor.shadowBlack,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text:model.studentName??"",fontSize: 11,color: AppColor.white,),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: "Roll: ${model.rollNo??"-"}",fontSize: 11,color: AppColor.white,),
                ResultStatusWidget(model: model),
              ],
            ),
            SizedBox(height: 5,),

          ],
        ),

      ),
    );
  }
}
