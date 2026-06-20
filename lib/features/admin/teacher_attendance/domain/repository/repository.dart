import 'package:dartz/dartz.dart';

import '../../models/teacher_attendance_model.dart';

abstract class TeacherAttendanceRepository{
  Future<Either<String,TeacherAttendanceModel>> post({required TeacherAttendanceModel value});
  Future<Either<String,TeacherAttendanceModel>> update({required TeacherAttendanceModel value});
  Future<Either<String,bool>> delete({required TeacherAttendanceModel value});
  Future<Either<String,List<TeacherAttendanceModel>>> get();
}