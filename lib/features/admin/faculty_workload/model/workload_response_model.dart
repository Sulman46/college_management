import 'allocation_workload_model.dart';
import 'teacher_workload_model.dart';
import 'workload_card_model.dart';

class WorkloadResponseModel {
  final List<TeacherWorkloadModel>    teacherWorkloadModel;
  final List<AllocationWorkloadModel> allocationWorkloadModel;
  final List<WorkloadCardModel>       workloadList;

  WorkloadResponseModel({
    required this.teacherWorkloadModel,
    required this.allocationWorkloadModel,
    required this.workloadList,
  });



  factory WorkloadResponseModel.fromMap(Map<String, dynamic> map) {
    final teachers = (map['teachers'] is List)
        ? (map['teachers'] as List)
        .map((e) => TeacherWorkloadModel.fromMap(e as Map<String, dynamic>))
        .toList()
        : <TeacherWorkloadModel>[];

    final allocations = (map['allocations'] is List)
        ? (map['allocations'] as List)
        .map((e) => AllocationWorkloadModel.fromMap(e as Map<String, dynamic>))
        .toList()
        : <AllocationWorkloadModel>[];

    return WorkloadResponseModel(
      teacherWorkloadModel:    teachers,
      allocationWorkloadModel: allocations,
      workloadList:            _buildWorkloadCards(teachers, allocations),
    );
  }

  static List<WorkloadCardModel> _buildWorkloadCards(
      List<TeacherWorkloadModel>    teachers,
      List<AllocationWorkloadModel> allocations,
      ) {
    // Active allocations only
    final active = allocations
        .where((a) => (a.status ?? 'Active') == 'Active')
        .toList();

    return teachers.map((teacher) {
      final teacherName = (teacher.teacherName ?? '').trim();

      // subjectKey → CourseInfoModel  (deduplication happens here)
      final Map<String, CourseInfoModel> subjectMap = {};

      for (final alloc in active) {
        if ((alloc.teacherName ?? '').trim() != teacherName) continue;

        final isCombined = alloc.isCombinedClass;

        // ── course fields: nested first, flat as fallback ──
        final nestedCourse = alloc.courseMapping?.course;
        final courseCode   = (nestedCourse?.courseCode  ?? alloc.courseCode  ?? '').trim();
        final courseTitle  = (nestedCourse?.courseTitle ?? alloc.courseName  ?? '').trim();
        // creditHours comes from nested courseId — that is the source of truth
        final ch           =  nestedCourse?.creditHours ?? alloc.creditHours ?? 0;
        final courseType   =  nestedCourse?.type        ?? '';

        final baseKey = courseCode.isNotEmpty ? courseCode : courseTitle;
        if (baseKey.isEmpty) continue;

        // ── program label from nested programId ──
        final program     = alloc.courseMapping?.semester?.program;
        final semName     = alloc.courseMapping?.semester?.semesterName ?? '';
        final programName = (program?.name    ?? '').trim();
        final section     = (program?.section ?? '').trim();
        final semLabel    = semName.isNotEmpty ? 'Sem $semName' : '';

        final programLabel = [programName, section, semLabel]
            .where((s) => s.isNotEmpty)
            .join(' › ');

        final courseInfo = CourseInfoModel(
          id:           nestedCourse?.id ?? '',
          courseCode:   courseCode,
          courseTitle:  courseTitle,
          creditHours:  ch,          // ← correct CH from courseId
          type:         courseType,
          programLabel: programLabel,
          isCombined:   isCombined,
        );

        if (isCombined) {
          // Combined: count once regardless of how many sections share it
          final key = 'combined__$baseKey';
          if (!subjectMap.containsKey(key)) subjectMap[key] = courseInfo;
        } else {
          // Regular: unique per course + program + section
          final key = '${baseKey}__${programName}__$section';
          if (!subjectMap.containsKey(key)) subjectMap[key] = courseInfo;
        }
      }

      // WorkloadCardModel computes completedCr / creditHourRemaining itself
      return WorkloadCardModel(
        teacherWorkloadModel: teacher,
        courseInfoList:       subjectMap.values.toList(),
      );
    }).toList();
  }
}