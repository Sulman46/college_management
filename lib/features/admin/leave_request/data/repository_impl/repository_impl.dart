
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class LeaveRequestRepositoryImpl extends LeaveRequestRepository{
  final LeaveRequestDataSource dataSource;
  LeaveRequestRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}