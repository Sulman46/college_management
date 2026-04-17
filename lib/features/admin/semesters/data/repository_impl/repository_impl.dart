
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class SemesterAdminRepositoryImpl extends SemesterAdminRepository{
  final SemesterAdminDataSource dataSource;
  SemesterAdminRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}