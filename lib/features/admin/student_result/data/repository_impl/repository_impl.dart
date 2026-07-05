
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../model/filter_result_model.dart';
import '../../model/user_result_model.dart';
import '../datasource/datasource.dart';

class StudentResultRepositoryImpl extends StudentResultRepository{
  final StudentResultDataSource dataSource;
  StudentResultRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,List<UserResultModel>>> get({required FilterResultModel model}) {
    return dataSource.get(model: model);
  }

}