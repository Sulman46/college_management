
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class FacultyWorkLoadRepositoryImpl extends FacultyWorkLoadRepository{
  final FacultyWorkLoadDataSource dataSource;
  FacultyWorkLoadRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}