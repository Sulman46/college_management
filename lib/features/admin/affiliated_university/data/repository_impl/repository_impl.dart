
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class AffiliatedUniversityRepositoryImpl extends AffiliatedUniversityRepository{
  final AffiliatedUniversityDataSource dataSource;
  AffiliatedUniversityRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}