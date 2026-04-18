import 'package:dartz/dartz.dart';

abstract class AttendanceNotificationRepository{
  Future<Either<String,bool>> function1();
}