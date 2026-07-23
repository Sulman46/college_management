
import 'package:dartz/dartz.dart';
import '../../models/dashboard_model.dart';
import '../repository/repository.dart';

class AdminHomeUseCase{
  final AdminHomeRepository repository;
  AdminHomeUseCase({required this.repository});

  Future<Either<String,DashboardModel>> get()async {
    return repository.get();
  }

}
