
import 'package:dartz/dartz.dart';
import '../../model/workload_response_model.dart';
import '../repository/repository.dart';

class FacultyWorkLoadUseCase{
  final FacultyWorkLoadRepository repository;
  FacultyWorkLoadUseCase({required this.repository});

  Future<Either<String,WorkloadResponseModel>> get()async {
    return repository.get();
  }

}
