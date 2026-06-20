
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class NewFileNameRepositoryImpl extends NewFileNameRepository{
  final NewFileNameDataSource dataSource;
  NewFileNameRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}