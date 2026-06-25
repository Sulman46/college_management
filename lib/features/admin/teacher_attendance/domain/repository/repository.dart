import 'package:dartz/dartz.dart';

import '../../models/teacher_attendance_model.dart';

abstract class TeacherAttendanceRepository{
  Future<Either<String,String>> post({required TeacherAttendanceModel value});
  Future<Either<String,String>> update({required TeacherAttendanceModel value});
  Future<Either<String,String>> delete({required TeacherAttendanceModel value});
  Future<Either<String,List<TeacherAttendanceModel>>> get();
}