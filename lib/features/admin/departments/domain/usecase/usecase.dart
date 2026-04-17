
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class AdminDepartmentUseCase{
  final AdminDepartmentRepository repository;
  AdminDepartmentUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
