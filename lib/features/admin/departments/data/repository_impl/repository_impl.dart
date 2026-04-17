
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class AdminDepartmentRepositoryImpl extends AdminDepartmentRepository{
  final AdminDepartmentDataSource dataSource;
  AdminDepartmentRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}