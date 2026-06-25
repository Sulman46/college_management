
import 'package:dartz/dartz.dart';
import '../../models/course_catalog_model.dart';
import '../repository/repository.dart';

class CourseCatalogAdminUseCase{
  final CourseCatalogAdminRepository repository;
  CourseCatalogAdminUseCase({required this.repository});

  Future<Either<String,List<CourseCatalogModel>>> getCourseCatalog() {
    return repository.getCourseCatalog();
  }

  Future<Either<String, String>> addCourseCatalog({required CourseCatalogModel model}) {
    return repository.addCourseCatalog(model: model);
  }


  Future<Either<String, String>> updateCatalog({required CourseCatalogModel model}) {
    return repository.updateCatalog(model: model);
  }

  Future<Either<String, String>> deleteCourseCatalog({required CourseCatalogModel model}) {
    return repository.deleteCourseCatalog(model: model);
  }


}
