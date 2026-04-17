
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class SemesterAdminUseCase{
  final SemesterAdminRepository repository;
  SemesterAdminUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
