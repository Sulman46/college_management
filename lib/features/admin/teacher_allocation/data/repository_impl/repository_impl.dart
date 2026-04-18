
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class TeacherAllocationRepositoryImpl extends TeacherAllocationRepository{
  final TeacherAllocationDataSource dataSource;
  TeacherAllocationRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, bool>> function1() {
    return dataSource.function1();
  }

}