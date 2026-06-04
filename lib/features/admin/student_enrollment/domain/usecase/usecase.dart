
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class StudentEnrollmentUseCase{
  final StudentEnrollmentRepository repository;
  StudentEnrollmentUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
