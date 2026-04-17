
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class TeacherRecordsRepositoryImpl extends TeacherRecordsRepository{
  final TeacherRecordsDataSource dataSource;
  TeacherRecordsRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}