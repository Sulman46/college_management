
import 'package:dartz/dartz.dart';
import '../../../announcements/models/announcement_model.dart';
import '../../models/bulk_save_marking_model.dart';
import '../../models/marking_student_filter_model.dart';
import '../../models/marks_student_model.dart';
import '../../models/student_history_marks_model.dart';
import '../repository/repository.dart';

class MarkingStudentUseCase{
  final MarkingStudentRepository repository;
  MarkingStudentUseCase({required this.repository});

  Future<Either<String,MarksResponseModel>> get({required MarkingStudentFilterModel model})async {
    return repository.get(model: model);
  }
  Future<Either<String,List<StudentHistoryMarksModel>>> search({required String rollNo})async {
    return repository.search(rollNo: rollNo);
  }

  Future<Either<String,String>> bulkSaveData({required BulkSaveMarksRequest model})async {
    return repository.bulkSaveData(model: model);
  }

  Future<Either<String,String>> lockStatus({required BulkSaveMarksRequest model})async {
    return repository.lockStatus(model: model);
  }


}
