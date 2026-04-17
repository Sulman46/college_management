
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class AdminProgramsUseCase{
  final AdminProgramsRepository repository;
  AdminProgramsUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
