
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class CourseMappingRepositoryImpl extends CourseMappingRepository{
  final CourseMappingDataSource dataSource;
  CourseMappingRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}