
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class HODAssignmentRepositoryImpl extends HODAssignmentRepository{
  final HODAssignmentDataSource dataSource;
  HODAssignmentRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}