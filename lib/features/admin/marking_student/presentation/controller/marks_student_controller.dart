import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:college_management/core/constants/constant_data.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:college_management/features/admin/marking_student/models/marks_student_model.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:college_management/features/admin/marking_student/models/marks_student_model.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';

class MarksStudentController {
  MarksModel calculateMarks({
    required MarksModel? marks,
    required int courseType,
    required ProgramModel? programModel,
    required CourseMappingModel? courseMappingModel,
  }) {
    final safeMarks = marks ?? MarksModel();

    final theoryMax =
    (courseType == 0 || courseType == 2)
        ? (programModel?.totalTheory ?? 100)
        : 0;

    final practicalMax =
    (courseType == 1 || courseType == 2)
        ? (programModel?.practicalMax ?? 50)
        : 0;

    final maxMarks = theoryMax + practicalMax;

    final hasTheory = courseType == 0 || courseType == 2;
    final hasPractical = courseType == 1 || courseType == 2;
    final bothCourse=hasTheory && hasPractical;

    final hasMarksData =
        bothCourse?(safeMarks.mids != null ||
            safeMarks.sessional != null ||
            safeMarks.finalMarks != null ||
            safeMarks.practical != null):
    hasTheory
        ? (safeMarks.mids != null ||
        safeMarks.sessional != null ||
        safeMarks.finalMarks != null)
        : hasPractical
        ? (safeMarks.practical != null)
        : false;

    if (!hasMarksData || maxMarks <= 0) {
      return safeMarks.copyWith(
        totalMarks: 0,
        grandMax: maxMarks,
        grade: "–",
        gpa: 0.0,
        passed: false,
      );
    }

    final theoryObtained =
    hasTheory ? (safeMarks.mids ?? 0) + (safeMarks.sessional ?? 0) + (safeMarks.finalMarks ?? 0) : 0;

    final practicalObtained =
    hasPractical ? (safeMarks.practical ?? 0) : 0;

    final obtainedMarks = theoryObtained + practicalObtained;

    final gradeResult = _calcGrade(obtainedMarks, maxMarks);

    final theoryPass =
    hasTheory && theoryMax > 0
        ? (theoryObtained / theoryMax) * 100 >= (programModel?.theoryPassPercentage ?? 50)
        : true;

    final practicalPass =
    hasPractical && practicalMax > 0
        ? (practicalObtained / practicalMax) * 100 >= (programModel?.practicalPassPercentage ?? 50)
        : true;

    final passed =theoryPass && practicalPass
    // gradeResult['letter'] != "F" && gradeResult['letter'] != "–"
    //     ? true
    //     : (gradeResult['letter'] == "F"
    //     ? false
    //     :
    // (theoryPass && practicalPass))
    ;

    return safeMarks.copyWith(
      totalMarks: obtainedMarks,
      percentage:maxMarks > 0 ? double.tryParse(((obtainedMarks / maxMarks) * 100).toStringAsFixed(1)) : 0.0,
      grandMax: maxMarks,
      grade: gradeResult['letter'],
      gpa: gradeResult['gpa'],
      passed: passed,
    );
  }

  Map<String, dynamic> _calcGrade(int obtained, int total) {
    if (total <= 0) {
      return {
        'letter': '–',
        'gpa': 0.0,
        'remarks': 'N/A',
      };
    }

    final pct = (obtained / total) * 100;

    if (pct >= 85) {
      return {
        'letter': 'A+',
        'gpa': 4.0,
        'remarks': 'Outstanding',
      };
    }

    const bands = [
      {'letter': 'A', 'remarks': 'Excellent', 'gpaBase': 3.70, 'gpaTop': 3.99, 'pctBase': 80.0, 'pctTop': 84.99},
      {'letter': 'B+', 'remarks': 'Very Good', 'gpaBase': 3.30, 'gpaTop': 3.69, 'pctBase': 75.0, 'pctTop': 79.99},
      {'letter': 'B', 'remarks': 'Good', 'gpaBase': 3.00, 'gpaTop': 3.29, 'pctBase': 70.0, 'pctTop': 74.99},
      {'letter': 'C+', 'remarks': 'Above Average', 'gpaBase': 2.50, 'gpaTop': 2.99, 'pctBase': 65.0, 'pctTop': 69.99},
      {'letter': 'C', 'remarks': 'Average', 'gpaBase': 2.00, 'gpaTop': 2.49, 'pctBase': 60.0, 'pctTop': 64.99},
      {'letter': 'D', 'remarks': 'Pass', 'gpaBase': 1.00, 'gpaTop': 1.99, 'pctBase': 50.0, 'pctTop': 59.99},
    ];

    for (final b in bands) {
      if (pct >= (b['pctBase'] as num).toDouble()) {
        final ratio =
            (pct - (b['pctBase'] as num).toDouble()) /
                ((b['pctTop'] as num).toDouble() - (b['pctBase'] as num).toDouble());

        final gpa = (b['gpaBase'] as num).toDouble() +
            (ratio * (((b['gpaTop'] as num).toDouble() - (b['gpaBase'] as num).toDouble())));

        return {
          'letter': b['letter'],
          'gpa': double.parse(gpa.toStringAsFixed(6)),
          'remarks': b['remarks'],
        };
      }
    }

    return {
      'letter': 'F',
      'gpa': 0.0,
      'remarks': 'Fail',
    };
  }
}



class MarksGradeSummary {
  final String grade;
  final double gpa;
  final double percentage;
  final bool passed;
  final String remarks;
  final int obtainedMarks;
  final int maxMarks;

  const MarksGradeSummary({
    required this.grade,
    required this.gpa,
    required this.percentage,
    required this.passed,
    required this.remarks,
    required this.obtainedMarks,
    required this.maxMarks,
  });
}

class MarksCalculationService {
  static const Map<String, double> gradeToGpa = {
    "A+": 4.00,
    "A": 3.85,
    "B+": 3.50,
    "B": 3.15,
    "C+": 2.75,
    "C": 2.25,
    "D": 1.50,
    "F": 0.00,
    "–": 0.00,
  };

  static int resolveCourseType(CourseMappingModel? courseMappingModel) {
    final index = ConstantData.courseTypes.indexWhere(
          (e) => e == courseMappingModel?.courseType,
    );
    return index < 0 ? 0 : index;
  }

  static int resolveTotalMarks(
      ProgramModel? programModel,
      int courseType,
      ) {
    final theory =
    (courseType == 0 || courseType == 2)
        ? (programModel?.totalTheory ?? 0)
        : 0;

    final practical =
    (courseType == 1 || courseType == 2)
        ? (programModel?.practicalMax ?? 0)
        : 0;

    return theory + practical;
  }

  static MarksGradeSummary evaluateMarks({
    required MarksModel? marks,
    required ProgramModel? programModel,
    required CourseMappingModel? courseMappingModel,
  }) {
    final courseType = resolveCourseType(courseMappingModel);
    final maxMarks = resolveTotalMarks(programModel, courseType);

    final hasMarksData =
        courseType==2?
        marks?.totalMarks != null ||
            marks?.mids != null ||
            marks?.sessional != null ||
            marks?.finalMarks != null ||
            marks?.practical != null:courseType==0?
        marks?.totalMarks != null ||
            marks?.mids != null ||
            marks?.sessional != null ||
            marks?.finalMarks != null:courseType==1?marks?.totalMarks != null||marks?.practical != null:false
    ;

    if (!hasMarksData) {
      return MarksGradeSummary(
        grade: "–",
        gpa: 0.0,
        percentage: 0.0,
        passed: false,
        remarks: "N/A",
        obtainedMarks: 0,
        maxMarks: maxMarks,
      );
    }

    final obtainedMarks =
        marks?.totalMarks ??
            ((marks?.mids ?? 0) +
                (marks?.sessional ?? 0) +
                (marks?.finalMarks ?? 0) +
                (marks?.practical ?? 0));

    return _calculateGrade(
      obtained: obtainedMarks,
      total: maxMarks,
      savedGrade: marks?.grade,
      savedGpa: marks?.gpa,
      savedPassed: marks?.passed,
    );
  }

  static MarksGradeSummary _calculateGrade({
    required int obtained,
    required int total,
    required String? savedGrade,
    required double? savedGpa,
    required bool? savedPassed,
  }) {
    if (total <= 0) {
      return MarksGradeSummary(
        grade: "–",
        gpa: 0.0,
        percentage: 0.0,
        passed: false,
        remarks: "N/A",
        obtainedMarks: 0,
        maxMarks: 0,
      );
    }

    final percentage = (obtained / total) * 100;
    final autoGrade = _autoGradeFromPercentage(percentage);

    final grade = savedGrade?.trim().isNotEmpty == true
        ? savedGrade!.trim()
        : autoGrade.grade;

    final gpa =
        savedGpa ??
            gradeToGpa[grade] ??
            autoGrade.gpa;

    final passed =
        savedPassed ??
            (grade != "F" && grade != "–");

    return MarksGradeSummary(
      grade: grade,
      gpa: gpa,
      percentage: percentage,
      passed: passed,
      remarks: autoGrade.remarks,
      obtainedMarks: obtained,
      maxMarks: total,
    );
  }

  static _AutoGrade _autoGradeFromPercentage(double percentage) {
    if (percentage >= 85) {
      return const _AutoGrade("A+", 4.0, "Outstanding");
    }

    const bands = [
      _GradeBand("A", "Excellent", 3.70, 3.99, 80, 84.99),
      _GradeBand("B+", "Very Good", 3.30, 3.69, 75, 79.99),
      _GradeBand("B", "Good", 3.00, 3.29, 70, 74.99),
      _GradeBand("C+", "Above Avg", 2.50, 2.99, 65, 69.99),
      _GradeBand("C", "Average", 2.00, 2.49, 60, 64.99),
      _GradeBand("D", "Pass", 1.00, 1.99, 50, 59.99),
    ];

    for (final band in bands) {
      if (percentage >= band.pctBase) {
        final ratio =
            (percentage - band.pctBase) / (band.pctTop - band.pctBase);
        final gpa = band.gpaBase + ratio * (band.gpaTop - band.gpaBase);
        return _AutoGrade(band.letter, double.parse(gpa.toStringAsFixed(2)), band.remarks);
      }
    }

    return const _AutoGrade("F", 0.0, "Fail");
  }

  static Color gradeColor(String grade) {
    switch (grade) {
      case "A+":
      case "A":
        return const Color(0xFF10B981); // green
      case "B+":
      case "B":
        return const Color(0xFF60A5FA); // blue
      case "C+":
      case "C":
        return const Color(0xFFF59E0B); // amber
      case "D":
        return const Color(0xFFFB923C); // orange
      case "F":
        return const Color(0xFFEF4444); // red
      default:
        return const Color(0xFF94A3B8); // gray
    }
  }
}

class _AutoGrade {
  final String grade;
  final double gpa;
  final String remarks;

  const _AutoGrade(this.grade, this.gpa, this.remarks);
}

class _GradeBand {
  final String letter;
  final String remarks;
  final double gpaBase;
  final double gpaTop;
  final double pctBase;
  final double pctTop;

  const _GradeBand(
      this.letter,
      this.remarks,
      this.gpaBase,
      this.gpaTop,
      this.pctBase,
      this.pctTop,
      );
}