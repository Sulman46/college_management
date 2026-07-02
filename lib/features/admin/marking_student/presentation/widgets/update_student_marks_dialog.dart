import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/marking_student/models/marks_student_model.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/programs/presentation/controller/cubit.dart';
import 'package:college_management/widgets/custom_animated_dialog.dart';
import 'package:college_management/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../controller/cubit.dart';
import '../controller/marks_student_controller.dart';

class UpdateStudentMarksDialog extends StatefulWidget {
  const UpdateStudentMarksDialog({
    super.key,
    required this.marksStudentModel,
    required this.courseType,
  });

  final MarksStudentModel marksStudentModel;
  final int courseType;

  @override
  State<UpdateStudentMarksDialog> createState() =>
      _UpdateStudentMarksDialogState();
}

class _UpdateStudentMarksDialogState extends State<UpdateStudentMarksDialog> {
  final _markingCubit = DiContainer().sl<MarkingStudentCubit>();
  final _programCubit = DiContainer().sl<AdminProgramsCubit>();
  final _courseMappingCubit = DiContainer().sl<CourseMappingCubit>();
 late  ProgramModel selectedProgram;

  final TextEditingController mids = TextEditingController();
  final TextEditingController sessional = TextEditingController();
  final TextEditingController finalMarks = TextEditingController();
  final TextEditingController practical = TextEditingController();


  @override
  void initState() {
    super.initState();
  selectedProgram =
      _programCubit.programsList.where(
            (e) => e.id == _markingCubit.submittedData.programId,
      ).first;

  final m = widget.marksStudentModel.marks;

  mids.text = m?.mids?.toString() ?? '';
  sessional.text = m?.sessional?.toString() ?? '';
  finalMarks.text = m?.finalMarks?.toString() ?? '';
  practical.text = m?.practical?.toString() ?? '';

  }

  bool validateMarks() {
    if (widget.courseType == 0 || widget.courseType == 2) {
      final midsVal = int.tryParse(mids.text) ?? 0;
      final sessionalVal = int.tryParse(sessional.text) ?? 0;
      final finalVal = int.tryParse(finalMarks.text) ?? 0;

      if (midsVal > (selectedProgram.mids ?? 0)) {
        showMessage("Mids marks cannot exceed ${selectedProgram.mids}");
        return false;
      }

      if (sessionalVal > (selectedProgram.sessional ?? 0)) {
        showMessage(
            "Sessional marks cannot exceed ${selectedProgram.sessional}");
        return false;
      }

      if (finalVal > (selectedProgram.finalMarks ?? 0)) {
        showMessage(
            "Final marks cannot exceed ${selectedProgram.finalMarks}");
        return false;
      }
    }

    if (widget.courseType == 1 || widget.courseType == 2) {
      final practicalVal = int.tryParse(practical.text) ?? 0;

      if (practicalVal > (selectedProgram.practicalMax ?? 0)) {
        showMessage(
            "Practical marks cannot exceed ${selectedProgram.practicalMax}");
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: widget.marksStudentModel.name??"",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(width: 5,),
              InkWell(
                onTap: () => Navigator.pop(context),
                child:  Icon(Icons.close, color: AppColor.grey),
              ),
            ],
          ),
          const SizedBox(height: 11),

          if (widget.courseType == 0 || widget.courseType == 2) ...[
            CustomTextFormField(
              controller: mids,
              subTitle: "Mids (${selectedProgram.mids??"-"})",
              inputFormatters: [

                FilteringTextInputFormatter.digitsOnly,],
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 11,),
            CustomTextFormField(
              controller: sessional,
              subTitle: "Sessional (${selectedProgram.sessional??"-"})",
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 11,),
            CustomTextFormField(
              controller: finalMarks,
              subTitle: "Final (${selectedProgram.finalMarks??"-"})",
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
          ],

          if (widget.courseType == 1 || widget.courseType == 2)
            ...[
              SizedBox(height: 11,),
              CustomTextFormField(
              controller: practical,
              subTitle: "Practical (${selectedProgram.practicalMax??"-"})",
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            )],


          const SizedBox(height: 20),

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
              const SizedBox(width: 40),
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () {

                    if(widget.courseType == 0 || widget.courseType == 2){
                      if(mids.text.isEmpty || sessional.text.isEmpty ||  finalMarks.text.isEmpty){
                        showMessage("Please fill all fields");
                        return;
                      }
                    }
                    if(widget.courseType == 1 || widget.courseType == 2){
                      if(practical.text.isEmpty){
                        showMessage("Please fill all fields");
                        return;
                      }
                    }


                    if(!validateMarks()){
                      return;
                    }

                    final inputMarks = MarksModel(
                      studentId: widget.marksStudentModel.studentId,
                      semesterId: _markingCubit.submittedData.semesterId,
                      courseMappingId: _markingCubit.submittedData.mappingId,
                      mids: mids.text.trim().isEmpty
                          ? null
                          : int.tryParse(mids.text.trim()),
                      sessional: sessional.text.trim().isEmpty
                          ? null
                          : int.tryParse(sessional.text.trim()),
                      finalMarks: finalMarks.text.trim().isEmpty
                          ? null
                          : int.tryParse(finalMarks.text.trim()),
                      practical: practical.text.trim().isEmpty
                          ? null
                          : int.tryParse(practical.text.trim()),
                      isLocked: false,
                    );

                    final selectedProgram =
                    _programCubit.programsList.where(
                          (e) => e.id == _markingCubit.submittedData.programId,
                    ).first;

                    final selectedCourseMapping =
                    _courseMappingCubit.courseMappingList.where(
                          (e) => e.id == _markingCubit.submittedData.mappingId,
                    ).first;

                    final controller = MarksStudentController();

                    final updatedMarks = controller.calculateMarks(
                      marks: inputMarks,
                      courseType: widget.courseType,
                      programModel: selectedProgram,
                      courseMappingModel: selectedCourseMapping,
                    );

                    final updatedStudent = widget.marksStudentModel.copyWith(
                      marks: updatedMarks,
                    );

                    _markingCubit.getMarksStudentModel(updatedStudent);
                    Navigator.pop(context, updatedStudent);
                  },
                  text: "Submit",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}