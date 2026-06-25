import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_filter_dialog.dart';
import 'package:college_management/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/helper/data_extractor.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/data_not_found_widget.dart';
import '../controller/cubit.dart';
import 'enrolled_student_widget.dart';

class StudentEnrollmentHistorySection extends StatefulWidget {
  const StudentEnrollmentHistorySection({super.key});

  @override
  State<StudentEnrollmentHistorySection> createState() => _StudentEnrollmentHistorySectionState();
}

class _StudentEnrollmentHistorySectionState extends State<StudentEnrollmentHistorySection> {

  final _studentEnrollCubit=DiContainer().sl<StudentEnrollmentCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: AlignmentGeometry.centerLeft,
            child: AppText(text: "⚠️ These students remained in Sem ${(DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester))-1} — not promoted due to Frozen or Withdrawn status.",fontSize: 12,color: AppColor.red.withOpacity(.7),)),

        SizedBox(height: 10,),
        if(_studentEnrollCubit.filterDataHistoryList.isNotEmpty)
          ...List.generate(_studentEnrollCubit.filterDataHistoryList.length,
                (index) {
            var model=_studentEnrollCubit.filterDataHistoryList.toList()[index];
            return EnrolledStudentWidget(
            canCheck: false,
            studentEnrollmentModel: model,);
                },)
        else
          DataNotFoundWidget(onTap: () async {
            if(_studentEnrollCubit.submittedData.isAnyNull){
              showDialog(context: context, builder: (context) => StudentEnrollmentFilterDialog(),);
            }else{
              var res=    await _studentEnrollCubit.getHistory(_studentEnrollCubit.submittedData.copyWith(semester:"${ DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)-1}"));
            }
          }),
      ],
    );
  }
}
