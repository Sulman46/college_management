import 'package:college_management/features/admin/student_result/model/user_result_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class ResultStatusWidget extends StatefulWidget {
   ResultStatusWidget({super.key,required this.model});
UserResultModel model;

  @override
  State<ResultStatusWidget> createState() => _ResultStatusWidgetState();
}

class _ResultStatusWidgetState extends State<ResultStatusWidget> {
  int totalSubject=0;
  int passedSubject=0;

  @override
  void initState() {
    totalSubject=widget.model.courses.length;
    passedSubject=widget.model.courses.where((element) => element.passed==true,).length;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1,color:totalSubject>passedSubject? AppColor.red:AppColor.green),
        color: totalSubject>passedSubject? AppColor.red.withOpacity(.1):AppColor.green.withOpacity(.1),
      ),
      child: AppText(text:totalSubject>passedSubject?"${totalSubject-passedSubject} Subject Failed": "Promoted",fontSize: 8,color:totalSubject>passedSubject? AppColor.red: AppColor.green,),
    );
  }
}
