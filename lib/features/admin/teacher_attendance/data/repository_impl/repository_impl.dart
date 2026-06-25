
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/teacher_attendance_model.dart';
import '../datasource/datasource.dart';

class TeacherAttendanceRepositoryImpl extends TeacherAttendanceRepository{
  final TeacherAttendanceDataSource dataSource;
  TeacherAttendanceRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,String>> post({required TeacherAttendanceModel value})async{
    return dataSource.post(value: value);
  }

  @override
  Future<Either<String,String>> update({required TeacherAttendanceModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,String>> delete({required TeacherAttendanceModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<TeacherAttendanceModel>>> get(){
    return dataSource.get();
  }


}