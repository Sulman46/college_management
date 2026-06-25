
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../presentation/models/coordinator_register_model.dart';
import '../datasource/datasource.dart';

class CoordinatorManagementRepositoryImpl extends CoordinatorManagementRepository{
  final CoordinatorManagementDataSource dataSource;
  CoordinatorManagementRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,String>> post({required CoordinatorRegisterModel value})async{
    return dataSource.post(value: value);
  }

  @override
  Future<Either<String,String>> update({required CoordinatorRegisterModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,String>> delete({required CoordinatorRegisterModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<CoordinatorRegisterModel>>> get(){
    return dataSource.get();
  }



}