import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/features/admin/student_result/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../models/student_history_marks_model.dart';

class StudentMarkingHistoryWidget extends StatefulWidget {
   StudentMarkingHistoryWidget({
    super.key,
    required this.model,
    required this.isFirst,
  });

  final StudentHistoryMarksModel model;
bool isFirst;
  @override
  State<StudentMarkingHistoryWidget> createState() => _StudentMarkingHistoryWidgetState();
}

class _StudentMarkingHistoryWidgetState extends State<StudentMarkingHistoryWidget> {
  double cgp=0;
  CourseHistoryModel? course;
  var _resultCubit=DiContainer().sl<StudentResultCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    course=widget.model.courseMapping!.course;

    cgp = widget.model.gpa??0;


  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bgPrimary,
        border: Border(bottom: BorderSide(color: AppColor.whiteLight),right: BorderSide(color: AppColor.whiteLight),left: BorderSide(color: AppColor.whiteLight),),
      ),
      child: Column(
        children: [
          if(widget.isFirst)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(.4),
              border: Border(top: BorderSide(color: AppColor.whiteLight))
            ),
            child:  Row(
              children: [
                _HeaderCell(
                  text: "Course",
                  flex: 3,
                  alignment: Alignment.centerLeft,
                ),
                _HeaderCell(text: "GPA"),
                _HeaderCell(text: "Grade"),
                _HeaderCell(text: "Status"),
              ],
            ),
          ),

          /// Rows
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColor.whiteLight,
                ),
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  _CourseCell(
                    flex: 3,
                    title: course!.courseTitle ?? "-",
                    subtitle: course!.courseCode ?? "-",
                  ),

                  _ValueCell(
                    (cgp ).toStringAsFixed(2),
                  ),

                  _ValueCell(
                    widget.model.grade ?? "-",
                  ),

                  _StatusCell(
                    widget.model.passed == true,
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;
  final Alignment alignment;

  const _HeaderCell({
    required this.text,
    this.flex = 1,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        alignment: alignment,
        child: AppText(
          text: text.toUpperCase(),
          color: AppColor.white,
          fontSize: 8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CourseCell extends StatelessWidget {
  final String title;
  final String subtitle;
  final int flex;

  const _CourseCell({
    required this.title,
    required this.subtitle,
    this.flex = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: AppColor.whiteLight,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: title,
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
            const SizedBox(height: 2),
            AppText(
              text: subtitle,
              fontSize: 9,
              color: AppColor.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class _ValueCell extends StatelessWidget {
  final String value;

  const _ValueCell(this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: AppColor.whiteLight,
            ),
          ),
        ),
        child: AppText(
          text: value,
          fontSize: 9,
          color: AppColor.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatusCell extends StatelessWidget {
  final bool passed;

  const _StatusCell(this.passed);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: AppText(
          text: passed ? "PASS" : "FAIL",
          color: passed ? AppColor.green : AppColor.red,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}