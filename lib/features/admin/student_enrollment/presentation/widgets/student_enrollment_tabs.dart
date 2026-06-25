import 'package:college_management/core/helper/data_extractor.dart';
import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_filter_model.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/constants/app_widgets_size.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../student_registrations/presentation/controller/cubit.dart';
import '../controller/cubit.dart';

class StudentEnrollmentTabs extends StatefulWidget {
  const StudentEnrollmentTabs({super.key});

  @override
  State<StudentEnrollmentTabs> createState() => _StudentEnrollmentTabsState();
}

class _StudentEnrollmentTabsState extends State<StudentEnrollmentTabs> {
  final _studentEnrollCubit=DiContainer().sl<StudentEnrollmentCubit>();
  final _studentRegisterCubit=DiContainer().sl<StudentRegistrationCubit>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
      decoration: AppColor.containerDecoration,
      child: BlocBuilder(
        bloc: _studentEnrollCubit,
        builder: (context,statesbkj) {
          return Row(
            children: [
              Expanded(child: _tabButton(text:_studentEnrollCubit.submittedData.semester!=null? DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)>1?"History (${_studentEnrollCubit.filterDataHistoryList.isEmpty? "0":_studentEnrollCubit.dataHistoryList.length}) Sem-${DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)-1}":"New Admissions ${_studentRegisterCubit.dataList.where((e) =>e.department==_studentEnrollCubit.submittedData.department && e.programName==_studentEnrollCubit.submittedData.program && e.section==_studentEnrollCubit.submittedData.section && e.session==_studentEnrollCubit.submittedData.session&& DataExtractor.extractInt(e.semester)==DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester) && !_studentEnrollCubit.dataList.any(
                      (val) => val.srNo == e.registrationNumber
              )).length} Sem-${DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)}":"New Admissions", isSelected: _studentEnrollCubit.isNewTab, onTap: () async {
                _studentEnrollCubit.getTabIndex(true);
                if(DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)>1){
                  var res=    await _studentEnrollCubit.getHistory(_studentEnrollCubit.submittedData.copyWith(semester:"${ DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)-1}"));
                }
              },)),
              Expanded(child: _tabButton(text:_studentEnrollCubit.submittedData.isAnyNull? "Enrolled":"Enrolled Sem-${DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)}", isSelected: !_studentEnrollCubit.isNewTab, onTap: () {
                _studentEnrollCubit.getTabIndex(false);
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
      child: AppText(text: text,fontSize: 11,color: isSelected?AppColor.white:AppColor.white,),
    ),
  );
}