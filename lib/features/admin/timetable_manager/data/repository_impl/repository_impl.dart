
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class TimetableManagerRepositoryImpl extends TimetableManagerRepository{
  final TimetableManagerDataSource dataSource;
  TimetableManagerRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}