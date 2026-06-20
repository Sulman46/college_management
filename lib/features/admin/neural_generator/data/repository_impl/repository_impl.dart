
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/neural_generate_model.dart';
import '../datasource/datasource.dart';

class NeuralGeneratorRepositoryImpl extends NeuralGeneratorRepository{
  final NeuralGeneratorDataSource dataSource;
  NeuralGeneratorRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,String>> post({required NeuralGenerateModel value})async{
    return dataSource.post(value: value);
  }

}