
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class StudentResultRepositoryImpl extends StudentResultRepository{
  final StudentResultDataSource dataSource;
  StudentResultRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}