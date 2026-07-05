import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/features/admin/student_result/model/user_result_model.dart';
import 'package:college_management/features/admin/student_result/presentation/widgets/result_table.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class UserResultDetailDialog extends StatelessWidget {
   UserResultDetailDialog({super.key,required this.model});
  UserResultModel model;
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDialog(child:
    SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(text: "",fontSize: 12,),
              AppText(text: "Result",fontSize: 15,color: AppColor.white,),
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

          AppText(text: model.studentName??"-",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
          SizedBox(height: 5,),
          AppText(text: "Roll: ${model.rollNo??"-"}",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),
          SizedBox(height: 5,),
          const SizedBox(height: 10),

          ResultTableWidget(model: model),

          const SizedBox(height: 15),

        ],
      ),
    ));
  }
}


Widget _summaryCard({
  required String title,
  required String value,
}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.primary.withOpacity(.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.whiteLight),
      ),
      child: Column(
        children: [
          AppText(
            text: title,
            fontSize: 10,
            color: AppColor.grey,
          ),
          const SizedBox(height: 4),
          AppText(
            text: value,
            fontSize: 11,
            color: AppColor.white,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    ),
  );
}

