
import 'package:dartz/dartz.dart';
import '../../models/exams_schedule_response_model.dart';
import '../../models/filter_exams_schedule_model.dart';
import '../repository/repository.dart';

class ExamScheduleUseCase{
  final ExamScheduleRepository repository;
  ExamScheduleUseCase({required this.repository});

  Future<Either<String,ExamScheduleResponseModel>> get({required FilterExamsScheduleModel model}) {
    return repository.get(model: model);
  }
  Future<Either<String,String>> examScheduleSave({required Map<String, dynamic> model}) {
    return repository.examScheduleSave(model: model);
  }

}
