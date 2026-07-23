
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/dashboard_model.dart';
import '../datasource/datasource.dart';

class AdminHomeRepositoryImpl extends AdminHomeRepository{
  final AdminHomeDataSource dataSource;
  AdminHomeRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,DashboardModel>> get() {
    return dataSource.get();
  }

}