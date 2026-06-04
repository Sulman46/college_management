import 'package:dartz/dartz.dart';

import '../../models/teacher_allocation_model.dart';

abstract class TeacherAllocationRepository{
  Future<Either<String,TeacherAllocationModel>> post({required TeacherAllocationModel value});
  Future<Either<String,TeacherAllocationModel>> update({required TeacherAllocationModel value});
  Future<Either<String,bool>> delete({required TeacherAllocationModel value});
  Future<Either<String,List<TeacherAllocationModel>>> get();
}