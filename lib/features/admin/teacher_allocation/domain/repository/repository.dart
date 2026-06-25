import 'package:dartz/dartz.dart';

import '../../models/teacher_allocation_model.dart';

abstract class TeacherAllocationRepository{
  Future<Either<String,String>> post({required TeacherAllocationModel value});
  Future<Either<String,String>> update({required TeacherAllocationModel value});
  Future<Either<String,String>> delete({required TeacherAllocationModel value});
  Future<Either<String,List<TeacherAllocationModel>>> get();
}