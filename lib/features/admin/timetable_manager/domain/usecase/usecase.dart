
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class TimetableManagerUseCase{
  final TimetableManagerRepository repository;
  TimetableManagerUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
