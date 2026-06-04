import 'package:dartz/dartz.dart';

abstract class StudentEnrollmentRepository{
  Future<Either<String,bool>> function1();
}