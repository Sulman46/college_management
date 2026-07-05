
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/exams_schedule_response_model.dart';
import '../../models/filter_exams_schedule_model.dart';
import '../datasource/datasource.dart';

class ExamScheduleRepositoryImpl extends ExamScheduleRepository{
  final ExamScheduleDataSource dataSource;
  ExamScheduleRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,ExamScheduleResponseModel>> get({required FilterExamsScheduleModel model}) {
    return dataSource.get(model: model);
  }
  @override
  Future<Either<String,String>> examScheduleSave({required Map<String, dynamic> model}) {
    return dataSource.examScheduleSave(model: model);
  }

}