
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class NeuralGeneratorRepositoryImpl extends NeuralGeneratorRepository{
  final NeuralGeneratorDataSource dataSource;
  NeuralGeneratorRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}