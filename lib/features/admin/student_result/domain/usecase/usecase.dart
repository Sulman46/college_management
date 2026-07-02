
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class StudentResultUseCase{
  final StudentResultRepository repository;
  StudentResultUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
