
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class NeuralGeneratorUseCase{
  final NeuralGeneratorRepository repository;
  NeuralGeneratorUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
