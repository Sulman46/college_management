
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class TeacherAllocationUseCase{
  final TeacherAllocationRepository repository;
  TeacherAllocationUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
