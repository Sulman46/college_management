import 'allocation_workload_model.dart';
import 'teacher_workload_model.dart';

class WorkloadCardModel {
  final TeacherWorkloadModel  teacherWorkloadModel;
  final List<CourseInfoModel> courseInfoList;

  WorkloadCardModel({
    required this.teacherWorkloadModel,
    required this.courseInfoList,
  });

  // ── computed from courseInfoList directly ──────────────────────────────────

  /// Total CH = sum of creditHours across all deduplicated courses
  int get completedCr =>
      courseInfoList.fold(
        0,
            (sum, course) => sum + (course.creditHours ?? 0),
      );

  /// targetWorkload - completedCr  (negative = overloaded)
  int get creditHourRemaining => targetCH - completedCr;

  // ── convenience getters for UI ─────────────────────────────────────────────

  String get teacherName => teacherWorkloadModel.teacherName  ?? '';
  String get designation => teacherWorkloadModel.designation  ?? '';
  String get teacherType => teacherWorkloadModel.teacherType  ?? '';
  int    get targetCH    => teacherWorkloadModel.targetWorkload ?? 0;
  bool   get isOverloaded => creditHourRemaining < 0;

  /// 0.0 – 1.0+  (exceeds 1.0 when overloaded)
  double get progressFraction =>
      targetCH > 0 ? completedCr / targetCH : 0.0;

  /// 0 – 110 clamped
  int get progressPercent =>
      targetCH > 0
          ? ((completedCr / targetCH) * 100).round().clamp(0, 110)
          : 0;

  List<String> get departmentNames =>
      teacherWorkloadModel.departments.map((d) => d.name ?? '').toList();
}