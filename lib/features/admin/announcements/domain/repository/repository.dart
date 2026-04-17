import 'package:dartz/dartz.dart';

abstract class AnnouncementsRepository{
  Future<Either<String,bool>> function1();
}