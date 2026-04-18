
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class HODAssignmentUseCase{
  final HODAssignmentRepository repository;
  HODAssignmentUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
