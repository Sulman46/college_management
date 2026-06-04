import 'package:dartz/dartz.dart';

import '../../models/teacher_model.dart';

abstract class TeacherRecordsRepository{
  Future<Either<String,TeacherModel>> addTeacher({required TeacherModel value});
  Future<Either<String,TeacherModel>> update({required TeacherModel value});
  Future<Either<String,bool>> delete({required TeacherModel value});
  Future<Either<String,List<TeacherModel>>> getTeachers();
}