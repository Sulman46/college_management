import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository{
  Future<Either<String,bool>> function1();
}