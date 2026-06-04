
import 'package:dartz/dartz.dart';
import '../../models/course_catalog_model.dart';
import '../repository/repository.dart';

class CourseCatalogAdminUseCase{
  final CourseCatalogAdminRepository repository;
  CourseCatalogAdminUseCase({required this.repository});

  Future<Either<String,List<CourseCatalogModel>>> getCourseCatalog() {
    return repository.getCourseCatalog();
  }

  Future<Either<String, CourseCatalogModel>> addCourseCatalog({required CourseCatalogModel model}) {
    return repository.addCourseCatalog(model: model);
  }


  Future<Either<String, CourseCatalogModel>> updateCatalog({required CourseCatalogModel model}) {
    return repository.updateCatalog(model: model);
  }

  Future<Either<String, bool>> deleteCourseCatalog({required CourseCatalogModel model}) {
    return repository.deleteCourseCatalog(model: model);
  }


}
