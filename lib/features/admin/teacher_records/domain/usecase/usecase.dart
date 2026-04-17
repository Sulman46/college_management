
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class TeacherRecordsUseCase{
  final TeacherRecordsRepository repository;
  TeacherRecordsUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
