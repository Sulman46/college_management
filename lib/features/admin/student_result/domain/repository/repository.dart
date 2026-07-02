import 'package:dartz/dartz.dart';

abstract class StudentResultRepository{
  Future<Either<String,bool>> function1();
}