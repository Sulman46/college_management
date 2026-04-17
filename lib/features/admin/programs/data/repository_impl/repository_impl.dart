
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class AdminProgramsRepositoryImpl extends AdminProgramsRepository{
  final AdminProgramsDataSource dataSource;
  AdminProgramsRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}