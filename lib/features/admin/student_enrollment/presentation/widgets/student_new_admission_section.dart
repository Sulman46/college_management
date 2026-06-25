import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/student_enrollment/presentation/widgets/student_enrollment_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app/di_container.dart';
import '../../../../../core/helper/data_extractor.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/data_not_found_widget.dart';
import '../../../semesters/presentation/controller/cubit.dart';
import '../../../student_registrations/presentation/controller/cubit.dart';
import '../../data/models/student_enrollment_filter_model.dart';
import '../controller/cubit.dart';
import 'enrolled_student_widget.dart';

class StudentNewAdmissionSection extends StatefulWidget {
  const StudentNewAdmissionSection({super.key});

  @override
  State<StudentNewAdmissionSection> createState() => _StudentNewAdmissionSectionState();
}

class _StudentNewAdmissionSectionState extends State<StudentNewAdmissionSection> {

  final _studentEnrollCubit=DiContainer().sl<StudentEnrollmentCubit>();
  final _studentRegisterCubit=DiContainer().sl<StudentRegistrationCubit>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _studentRegisterCubit,
      builder: (context,syttau) {
        return Column(
          children: [

            if(_studentEnrollCubit.selectNewStudentForEnroll.isNotEmpty)
            ...[
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomElevatedButton(onPressed: () async {
                  var respo=await _studentEnrollCubit.enrollNewStudents();

                }, text: "Enroll",height: 25,width: 60,fontSize: 12,fontWeight: FontWeight.w500,),
              ],
            ),
            SizedBox(height: 10,),],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: "Students",fontSize: 12,color: AppColor.white,),
                InkWell(
                    onTap: () {
                      _studentEnrollCubit.selectAllNewStudent([..._studentRegisterCubit.dataList.where((e) =>e.department==_studentEnrollCubit.submittedData.department && e.programName==_studentEnrollCubit.submittedData.program && e.section==_studentEnrollCubit.submittedData.section && e.session==_studentEnrollCubit.submittedData.session&& DataExtractor.extractInt(e.semester)==DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester) && !_studentEnrollCubit.dataList.any(
                              (val) => val.srNo == e.registrationNumber
                      ))], selectAll:_studentEnrollCubit.selectNewStudentForEnroll.isEmpty);
                    },
                    child: AppText(text:_studentEnrollCubit.selectNewStudentForEnroll.isNotEmpty? "Uncheck All (${_studentEnrollCubit.selectNewStudentForEnroll.length})":"Check All",fontSize: 12,color: AppColor.white,))
              ],
            ),
            SizedBox(height: 10,),
            if(_studentRegisterCubit.dataList.where((e) =>e.department==_studentEnrollCubit.submittedData.department && e.programName==_studentEnrollCubit.submittedData.program && e.section==_studentEnrollCubit.submittedData.section && e.session==_studentEnrollCubit.submittedData.session&& DataExtractor.extractInt(e.semester)==DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester)
                && !_studentEnrollCubit.dataList.any(
                  (val) => val.srNo == e.registrationNumber
            )).isNotEmpty)
              ...List.generate(_studentRegisterCubit.dataList.where((e) =>e.department==_studentEnrollCubit.submittedData.department && e.programName==_studentEnrollCubit.submittedData.program && e.section==_studentEnrollCubit.submittedData.section && e.session==_studentEnrollCubit.submittedData.session&& DataExtractor.extractInt(e.semester)==DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester) && !_studentEnrollCubit.dataList.any(
                      (val) => val.srNo == e.registrationNumber
              )).length,
                    (index) {
                var model=_studentRegisterCubit.dataList.where((e) =>e.department==_studentEnrollCubit.submittedData.department && e.programName==_studentEnrollCubit.submittedData.program && e.section==_studentEnrollCubit.submittedData.section && e.session==_studentEnrollCubit.submittedData.session&& DataExtractor.extractInt(e.semester)==DataExtractor.extractInt(_studentEnrollCubit.submittedData.semester) && !_studentEnrollCubit.dataList.any(
                        (val) => val.srNo == e.registrationNumber
                )).toList()[index];
                return EnrolledStudentWidget(
                  studentModel: model,
                onTap: () {
                  _studentEnrollCubit.selectNewStudent(model);
                },
                isChecked: _studentEnrollCubit.selectNewStudentForEnroll.contains(model),
                );
                    },)
            else
              DataNotFoundWidget(onTap: () async {
                if(_studentEnrollCubit.submittedData.isAnyNull){
                  showDialog(context: context, builder: (context) => StudentEnrollmentFilterDialog(),);
                }else{
                  await _studentRegisterCubit.get();
                }
              }),
          ],
        );
      }
    );
  }
}
