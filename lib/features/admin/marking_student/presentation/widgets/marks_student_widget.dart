import 'dart:developer';

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:college_management/features/admin/course_mapping/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/marking_student/models/marks_student_model.dart';
import 'package:college_management/features/admin/marking_student/presentation/widgets/update_student_marks_dialog.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:college_management/widgets/more_vert_pop_menu_button.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app/di_container.dart';
import '../../../programs/models/program_model.dart';
import '../../../programs/presentation/controller/cubit.dart';
import '../controller/cubit.dart';
import '../controller/marks_student_controller.dart';

class MarksStudentWidget extends StatefulWidget {
  const MarksStudentWidget({
    super.key,
    required this.model,
  });

  final MarksStudentModel model;

  @override
  State<MarksStudentWidget> createState() => _MarksStudentWidgetState();
}

class _MarksStudentWidgetState extends State<MarksStudentWidget> {
  final _programCubit = DiContainer().sl<AdminProgramsCubit>();
  final _markingCubit = DiContainer().sl<MarkingStudentCubit>();
  final _courseMappingCubit = DiContainer().sl<CourseMappingCubit>();
  final _marksStudentController = MarksStudentController();

  late MarksStudentModel currentStudent;
  ProgramModel? programModel;
  CourseMappingModel? courseMappingModel;
  int courseType = 0;

  @override
  void initState() {
    super.initState();
    currentStudent = widget.model;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  @override
  void didUpdateWidget(covariant MarksStudentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.model != widget.model) {
      currentStudent = widget.model;
      _initialize();
    }
  }

  void _initialize() {
    try {
      programModel = _programCubit.programsList.firstWhere(
            (e) => e.id == _markingCubit.submittedData.programId,
      );
    } catch (_) {
      programModel = null;
    }

    try {
      courseMappingModel = _courseMappingCubit.courseMappingList.firstWhere(
            (e) => e.id == _markingCubit.submittedData.mappingId,
      );
    } catch (_) {
      courseMappingModel = null;
    }

    courseType = MarksCalculationService.resolveCourseType(courseMappingModel);

    _refreshCalculatedMarks();

    if (mounted) {
      setState(() {});
    }
  }

  void _refreshCalculatedMarks() {
    final calculated = _marksStudentController.calculateMarks(
      marks: currentStudent.marks,
      courseType: courseType,
      programModel: programModel,
      courseMappingModel: courseMappingModel,
    );

    currentStudent = currentStudent.copyWith(marks: calculated);
  }

  @override
  Widget build(BuildContext context) {
    final marks = currentStudent.marks;
    final totalMarks = marks?.totalMarks ?? 0;
    final maxMarks = marks?.grandMax ?? 0;
    final percentage = maxMarks > 0 ? (totalMarks / maxMarks) * 100 : 0.0;
    final grade = marks?.grade ?? "–";
    final gpa = marks?.gpa ?? 0.0;
    final passed = marks?.passed ?? false;

    return InkWell(
      onTap: () {
        log("2342: ${widget.model.toMap()}");
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
          color: marks?.isLocked == true
              ? AppColor.white.withOpacity(.1)
              : AppColor.bgPrimary.withOpacity(.6),
          boxShadow: marks?.isLocked == true ? null : AppColor.shadowBlack,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: currentStudent.name ?? "-",
              fontSize: 12,
              color: AppColor.white,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                AppText(
                  text: "Roll: ${currentStudent.rollNo ?? "-"}",
                  fontSize: 10,
                  color: AppColor.white,
                ),
                const SizedBox(width: 10),
                AppText(
                  text: "Reg: ${currentStudent.srNo ?? "-"}",
                  fontSize: 10,
                  color: AppColor.white,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (courseType == 0 || courseType == 2) ...[
                  Column(
                    children: [
                      AppText(
                        text: "Mids",
                        fontSize: 10,
                        color: AppColor.white,
                      ),
                      AppText(
                        text: "${marks?.mids ?? "-"}/${programModel?.mids ?? "-"}",
                        fontSize: 10,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppText(
                        text: "Sessional",
                        fontSize: 10,
                        color: AppColor.white,
                      ),
                      AppText(
                        text: "${marks?.sessional ?? "-"}/${programModel?.sessional ?? "-"}",
                        fontSize: 10,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppText(
                        text: "Final",
                        fontSize: 10,
                        color: AppColor.white,
                      ),
                      AppText(
                        text: "${marks?.finalMarks ?? "-"}/${programModel?.finalMarks ?? "-"}",
                        fontSize: 10,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ],
                if (courseType == 1 || courseType == 2)
                  Column(
                    children: [
                      AppText(
                        text: "Practical",
                        fontSize: 10,
                        color: AppColor.white,
                      ),
                      AppText(
                        text: "${marks?.practical ?? "-"}/${programModel?.practicalMax ?? '-'} (${((marks?.practical??0) / (programModel?.practicalMax??0)) * 100 >= (programModel?.practicalPassPercentage ?? 0)?"P":"F"})",
                        fontSize: 10,
                        color:((marks?.practical??0) / (programModel?.practicalMax??0)) * 100 >= (programModel?.practicalPassPercentage ?? 0)? AppColor.white:AppColor.red,
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "Total: $totalMarks / $maxMarks",
                  fontSize: 10,
                  color: AppColor.white,
                ),
                AppText(
                  text: "${widget.model.marks?.percentage?.toStringAsFixed(1)??percentage.toStringAsFixed(1)??"-"}%",
                  fontSize: 10,
                  color: AppColor.white,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AppText(
                      text: "Grade: ",
                      fontSize: 10,
                      color: AppColor.white,
                    ),
                    GradeBadge(
                      grade: grade,
                      gpa: gpa,
                    ),
                  ],
                ),
                Row(
                  children: [
                    AppText(
                      text: "GPA: ",
                      fontSize: 10,
                      color: AppColor.white,
                    ),
                    AppText(
                      text: gpa.toStringAsFixed(2),
                      fontSize: 10,
                      color: AppColor.white,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PassFailChip(passed: passed),
                if (marks?.isLocked != true && !_markingCubit.marksResponseModel.isLocked)
                  CustomPopMenuButton(
                    menus: const ["Edit"],
                    onSelected: (value) async {
                      if (value == 0) {
                        final updated = await showDialog<MarksStudentModel>(
                          context: context,
                          builder: (context) => UpdateStudentMarksDialog(
                            marksStudentModel: currentStudent,
                            courseType: courseType,
                          ),
                        );

                        if (updated != null) {
                          currentStudent = updated;
                          _refreshCalculatedMarks();
                          if (mounted) {
                            setState(() {});
                          }
                        }
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GradeBadge extends StatelessWidget {
  final String grade;
  final double gpa;

  const GradeBadge({
    super.key,
    required this.grade,
    required this.gpa,
  });

  @override
  Widget build(BuildContext context) {
    final color = MarksCalculationService.gradeColor(grade);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        border: Border.all(color: color.withOpacity(0.45)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        grade.isEmpty ? "–" : grade,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class PassFailChip extends StatelessWidget {
  final bool passed;

  const PassFailChip({
    super.key,
    required this.passed,
  });

  @override
  Widget build(BuildContext context) {
    final color = passed ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        border: Border.all(color: color.withOpacity(0.45)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        passed ? "Pass" : "Fail",
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}