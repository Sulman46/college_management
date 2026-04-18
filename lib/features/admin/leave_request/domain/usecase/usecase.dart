
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';

class LeaveRequestUseCase{
  final LeaveRequestRepository repository;
  LeaveRequestUseCase({required this.repository});

  Future<Either<String, bool>> function1()async {
    return repository.function1();
  }

}
