
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/hod_assign_model.dart';
import '../datasource/datasource.dart';

class HODAssignmentRepositoryImpl extends HODAssignmentRepository{
  final HODAssignmentDataSource dataSource;
  HODAssignmentRepositoryImpl({required this.dataSource});



  Future<Either<String,String>> post({required HodAssignModel value})async{
    return dataSource.post(value: value);
  }

  Future<Either<String,String>> update({required HodAssignModel value}){
    return dataSource.update(value: value);
  }

  Future<Either<String,String>> delete({required HodAssignModel value}){
    return dataSource.delete(value: value);
  }

  Future<Either<String,List<HodAssignModel>>> get(){
    return dataSource.get();
  }


}