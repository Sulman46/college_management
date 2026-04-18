import 'package:dartz/dartz.dart';

abstract class LeaveRequestRepository{
  Future<Either<String,bool>> function1();
}