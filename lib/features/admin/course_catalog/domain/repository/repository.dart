import 'package:dartz/dartz.dart';

import '../../models/course_catalog_model.dart';

abstract class CourseCatalogAdminRepository{
  Future<Either<String,String>> addCourseCatalog({required CourseCatalogModel model});
  Future<Either<String,List<CourseCatalogModel>>> getCourseCatalog();
  Future<Either<String,String>> deleteCourseCatalog({required CourseCatalogModel model});
  Future<Either<String,String>> updateCatalog({required CourseCatalogModel model});

}