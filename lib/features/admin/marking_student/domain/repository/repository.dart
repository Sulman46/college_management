import 'package:dartz/dartz.dart';

import '../../../announcements/models/announcement_model.dart';
import '../../models/bulk_save_marking_model.dart';
import '../../models/marking_student_filter_model.dart';
import '../../models/marks_student_model.dart';
import '../../models/student_history_marks_model.dart';

abstract class MarkingStudentRepository{
  Future<Either<String,MarksResponseModel>> get({required MarkingStudentFilterModel model});
  Future<Either<String,List<StudentHistoryMarksModel>>> search({required String rollNo});
  Future<Either<String,String>> bulkSaveData({required BulkSaveMarksRequest model});
  Future<Either<String,String>> lockStatus({required BulkSaveMarksRequest model});
}