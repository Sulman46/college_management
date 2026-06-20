
import 'package:dartz/dartz.dart';
import '../../models/hod_assign_model.dart';
import '../repository/repository.dart';

class HODAssignmentUseCase{
  final HODAssignmentRepository repository;
  HODAssignmentUseCase({required this.repository});


  Future<Either<String,HodAssignModel>> post({required HodAssignModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,HodAssignModel>> update({required HodAssignModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,bool>> delete({required HodAssignModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<HodAssignModel>>> get(){
    return repository.get();
  }

}
