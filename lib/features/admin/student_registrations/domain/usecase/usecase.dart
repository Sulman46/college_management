
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class StudentRegistrationUseCase{
  final StudentRegistrationRepository repository;
  StudentRegistrationUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
