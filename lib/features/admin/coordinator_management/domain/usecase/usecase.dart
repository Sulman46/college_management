
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class NewFileNameUseCase{
  final NewFileNameRepository repository;
  NewFileNameUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
