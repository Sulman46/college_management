import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_filter_model.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../controller/cubit.dart';

class StudentEnrollmentTabs extends StatefulWidget {
  const StudentEnrollmentTabs({super.key});

  @override
  State<StudentEnrollmentTabs> createState() => _StudentEnrollmentTabsState();
}

class _StudentEnrollmentTabsState extends State<StudentEnrollmentTabs> {
  final _studentEnrollCubit=DiContainer().sl<StudentEnrollmentCubit>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.white.withOpacity(.9),
        boxShadow: AppColor.shadowBlack,
      ),
      child: BlocBuilder(
        bloc: _studentEnrollCubit,
        builder: (context,statesbkj) {
          return Row(
            children: [
              Expanded(child: _tabButton(text: "New Admissions", isSelected: _studentEnrollCubit.isNewTab, onTap: () async {
                _studentEnrollCubit.getTabIndex(true);
               await _studentEnrollCubit.get(StudentEnrollmentFilterModel(semester: "1"));
              },)),
              Expanded(child: _tabButton(text: "Enrolled", isSelected: !_studentEnrollCubit.isNewTab, onTap: () {
                _studentEnrollCubit.getTabIndex(false);

                showDialog(context: context, builder: (context) => StudentEnrollmentFilterDialog(),);

              },)),
            ],
          );
        }
      ),
    );
  }
}


Widget _tabButton({required String text,required bool isSelected,required VoidCallback? onTap}){
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal:8,vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:isSelected? AppColor.primary:AppColor.transparent),
      child: AppText(text: text,fontSize: 12,color: isSelected?AppColor.white:AppColor.white,),
    ),
  );
}