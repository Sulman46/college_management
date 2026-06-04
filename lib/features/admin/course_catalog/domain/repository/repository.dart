import 'package:dartz/dartz.dart';

import '../../models/course_catalog_model.dart';

abstract class CourseCatalogAdminRepository{
  Future<Either<String,CourseCatalogModel>> addCourseCatalog({required CourseCatalogModel model});
  Future<Either<String,List<CourseCatalogModel>>> getCourseCatalog();
  Future<Either<String,bool>> deleteCourseCatalog({required CourseCatalogModel model});
  Future<Either<String,CourseCatalogModel>> updateCatalog({required CourseCatalogModel model});

}