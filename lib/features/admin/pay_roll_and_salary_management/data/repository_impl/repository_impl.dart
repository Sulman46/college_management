
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class PayrollAndSalaryManagementRepositoryImpl extends PayrollAndSalaryManagementRepository{
  final PayrollAndSalaryManagementDataSource dataSource;
  PayrollAndSalaryManagementRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}