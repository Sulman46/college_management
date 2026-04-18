
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class StudentRegistrationRepositoryImpl extends StudentRegistrationRepository{
  final StudentRegistrationDataSource dataSource;
  StudentRegistrationRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}