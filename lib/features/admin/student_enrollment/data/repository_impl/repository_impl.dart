
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class StudentEnrollmentRepositoryImpl extends StudentEnrollmentRepository{
  final StudentEnrollmentDataSource dataSource;
  StudentEnrollmentRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}