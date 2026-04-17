
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class AdminHomeUseCase{
  final AdminHomeRepository repository;
  AdminHomeUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
