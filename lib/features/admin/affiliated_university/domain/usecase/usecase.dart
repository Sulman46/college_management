
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class AffiliatedUniversityUseCase{
  final AffiliatedUniversityRepository repository;
  AffiliatedUniversityUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
