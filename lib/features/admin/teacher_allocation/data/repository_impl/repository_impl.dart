
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../../teacher_records/models/teacher_model.dart';
import '../../models/teacher_allocation_model.dart';
import '../datasource/datasource.dart';

class TeacherAllocationRepositoryImpl extends TeacherAllocationRepository{
  final TeacherAllocationDataSource dataSource;
  TeacherAllocationRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,String>> post({required TeacherAllocationModel value})async{
    return dataSource.post(value: value);
  }

  @override
  Future<Either<String,String>> update({required TeacherAllocationModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,String>> delete({required TeacherAllocationModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<TeacherAllocationModel>>> get(){
    return dataSource.get();
  }



}