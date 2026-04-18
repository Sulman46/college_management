
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class TeacherAttendanceRepositoryImpl extends TeacherAttendanceRepository{
  final TeacherAttendanceDataSource dataSource;
  TeacherAttendanceRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}