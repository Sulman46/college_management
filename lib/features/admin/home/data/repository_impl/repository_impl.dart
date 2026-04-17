
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class AdminHomeRepositoryImpl extends AdminHomeRepository{
  final AdminHomeDataSource dataSource;
  AdminHomeRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}