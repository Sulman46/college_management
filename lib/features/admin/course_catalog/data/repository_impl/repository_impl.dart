
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/course_catalog_model.dart';
import '../datasource/datasource.dart';

class CourseCatalogAdminRepositoryImpl extends CourseCatalogAdminRepository{
  final CourseCatalogAdminDataSource dataSource;
  CourseCatalogAdminRepositoryImpl({required this.dataSource});

  @override
  Future<Either<String,List<CourseCatalogModel>>> getCourseCatalog() {
    return dataSource.getCourseCatalog();
  }

  @override
  Future<Either<String, CourseCatalogModel>> addCourseCatalog({required CourseCatalogModel model}) {
    return dataSource.addCourseCatalog(model: model);
  }

  @override
  Future<Either<String, CourseCatalogModel>> updateCatalog({required CourseCatalogModel model}) {
    return dataSource.updateCatalog(model: model);
  }

  @override
  Future<Either<String, bool>> deleteCourseCatalog({required CourseCatalogModel model}) {
    return dataSource.deleteCourseCatalog(model: model);
  }

}