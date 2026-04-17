
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class UseCaseName{
  final RepositoryName repository;
  UseCaseName({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
