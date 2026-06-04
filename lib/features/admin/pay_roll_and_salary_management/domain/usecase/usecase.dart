
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class PayrollAndSalaryManagementUseCase{
  final PayrollAndSalaryManagementRepository repository;
  PayrollAndSalaryManagementUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
