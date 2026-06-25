import 'package:dartz/dartz.dart';

import '../../models/teacher_model.dart';

abstract class TeacherRecordsRepository{
  Future<Either<String,String>> addTeacher({required TeacherModel value});
  Future<Either<String,String>> update({required TeacherModel value});
  Future<Either<String,String>> delete({required TeacherModel value});
  Future<Either<String,List<TeacherModel>>> getTeachers();
}