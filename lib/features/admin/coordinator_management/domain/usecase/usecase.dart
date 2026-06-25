
import 'package:dartz/dartz.dart';
import '../../presentation/models/coordinator_register_model.dart';
import '../repository/repository.dart';

class CoordinatorManagementUseCase{
  final CoordinatorManagementRepository repository;
  CoordinatorManagementUseCase({required this.repository});

  Future<Either<String,String>> post({required CoordinatorRegisterModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,String>> update({required CoordinatorRegisterModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,String>> delete({required CoordinatorRegisterModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<CoordinatorRegisterModel>>> get(){
    return repository.get();
  }


}
