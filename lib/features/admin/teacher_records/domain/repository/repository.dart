import 'package:dartz/dartz.dart';

abstract class TeacherRecordsRepository{
  Future<Either<String,bool>> function1();
}