import 'package:dartz/dartz.dart';

import '../../data/models/student_enrollment_filter_model.dart';
import '../../data/models/student_enrollment_model.dart';

abstract class StudentEnrollmentRepository{
  Future<Either<String,StudentEnrollmentModel>> post({required StudentEnrollmentModel value});
  Future<Either<String,StudentEnrollmentModel>> update({required StudentEnrollmentModel value});
  Future<Either<String,bool>> delete({required StudentEnrollmentModel value});
  Future<Either<String,List<StudentEnrollmentModel>>> get({required StudentEnrollmentFilterModel value});
}