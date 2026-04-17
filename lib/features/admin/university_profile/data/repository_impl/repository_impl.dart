
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class UniversityProfileRepositoryImpl extends UniversityProfileRepository{
  final UniversityProfileDataSource dataSource;
  UniversityProfileRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}