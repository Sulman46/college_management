import 'package:dartz/dartz.dart';

import '../../models/neural_generate_model.dart';

abstract class NeuralGeneratorRepository{
  Future<Either<String,String>> post({required NeuralGenerateModel value});
}