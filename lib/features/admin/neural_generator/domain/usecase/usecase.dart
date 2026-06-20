
import 'package:dartz/dartz.dart';
import '../../models/neural_generate_model.dart';
import '../repository/repository.dart';

class NeuralGeneratorUseCase{
  final NeuralGeneratorRepository repository;
  NeuralGeneratorUseCase({required this.repository});

  Future<Either<String,String>> post({required NeuralGenerateModel value})async{
    return repository.post(value: value);
  }

}
