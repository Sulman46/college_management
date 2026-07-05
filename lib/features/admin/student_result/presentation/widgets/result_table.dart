import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/features/admin/student_result/presentation/controller/cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../model/user_result_model.dart';

class ResultTableWidget extends StatefulWidget {
  const ResultTableWidget({
    super.key,
    required this.model,
  });

  final UserResultModel model;

  @override
  State<ResultTableWidget> createState() => _ResultTableWidgetState();
}

class _ResultTableWidgetState extends State<ResultTableWidget> {
  double cgp=0;

  var _resultCubit=DiContainer().sl<StudentResultCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     cgp = widget.model.courses.isEmpty
        ? 0.0
        : widget.model.courses
        .fold<double>(0.0, (sum, e) => sum + (e.gpa ?? 0.0)) /
        widget.model.courses.length;


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bgPrimary,
        border: Border.all(color: AppColor.whiteLight),
      ),
      child: Column(
        children: [
          /// Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.primary,
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: "Semester ${_resultCubit.submittedData.semester??"-"}",fontSize: 11,color: AppColor.white,fontWeight: FontWeight.w500,),

                AppText(text: "CGPA: ${cgp.toStringAsFixed(2)}",fontSize: 8,color: AppColor.white,fontWeight: FontWeight.w500,),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(.4),
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
          ...List.generate(widget.model.courses.length, (index) {
            final course = widget.model.courses[index];

            return Container(
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
                      title: course.courseTitle ?? "-",
                      subtitle: course.courseCode ?? "-",
                    ),

                    _ValueCell(
                      (course.gpa ?? 0).toStringAsFixed(2),
                    ),

                    _ValueCell(
                      course.grade ?? "-",
                    ),

                    _StatusCell(
                      course.passed == true,
                    ),
                  ],
                ),
              ),
            );
          }),


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