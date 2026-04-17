
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class CourseCatalogAdminRepositoryImpl extends CourseCatalogAdminRepository{
  final CourseCatalogAdminDataSource dataSource;
  CourseCatalogAdminRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}