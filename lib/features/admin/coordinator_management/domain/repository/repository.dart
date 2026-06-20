import 'package:dartz/dartz.dart';

abstract class NewFileNameRepository{
  Future<Either<String,bool>> function1();
}