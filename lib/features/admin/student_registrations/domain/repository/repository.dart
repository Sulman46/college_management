import 'package:dartz/dartz.dart';

abstract class StudentRegistrationRepository{
  Future<Either<String,bool>> function1();
}