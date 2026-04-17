
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class UniversityProfileUseCase{
  final UniversityProfileRepository repository;
  UniversityProfileUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
