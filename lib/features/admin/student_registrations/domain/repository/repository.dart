import 'package:dartz/dartz.dart';

import '../../models/student_model.dart';

abstract class StudentRegistrationRepository{
  Future<Either<String,String>> post({required StudentModel value});
  Future<Either<String,StudentModel>> update({required StudentModel value});
  Future<Either<String,bool>> delete({required StudentModel value});
  Future<Either<String,List<StudentModel>>> get();
}