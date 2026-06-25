
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../model/workload_response_model.dart';
import '../datasource/datasource.dart';

class FacultyWorkLoadRepositoryImpl extends FacultyWorkLoadRepository{
  final FacultyWorkLoadDataSource dataSource;
  FacultyWorkLoadRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,WorkloadResponseModel>> get() {
    return dataSource.get();
  }

}