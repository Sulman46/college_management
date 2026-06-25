import 'package:dartz/dartz.dart';

import '../../model/workload_response_model.dart';

abstract class FacultyWorkLoadRepository{
  Future<Either<String,WorkloadResponseModel>> get();
}