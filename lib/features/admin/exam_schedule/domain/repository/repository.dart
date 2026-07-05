import 'package:dartz/dartz.dart';

import '../../models/exams_schedule_response_model.dart';
import '../../models/filter_exams_schedule_model.dart';

abstract class ExamScheduleRepository{
  Future<Either<String,ExamScheduleResponseModel>> get({required FilterExamsScheduleModel model});
  Future<Either<String,String>> examScheduleSave({required Map<String, dynamic> model});
}