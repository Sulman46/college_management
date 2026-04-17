
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class CourseCatalogAdminUseCase{
  final CourseCatalogAdminRepository repository;
  CourseCatalogAdminUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
