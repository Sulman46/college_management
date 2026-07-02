
import 'package:dartz/dartz.dart';
import '../../models/freeze_request_model.dart';
import '../repository/repository.dart';

class FreezUnFreezUseCase{
  final FreezUnFreezRepository repository;
  FreezUnFreezUseCase({required this.repository});

  Future<Either<String, List<FreezeRequestModel>>> getPen() {
    return repository.getPen();
  }

  Future<Either<String,List<FreezeRequestModel>>> getFinal(){
    return repository.getFinal();
  }


  Future<Either<String,String>> update({required FreezeRequestModel value}){
    return repository.update(value: value);
  }


  Future<Either<String,String>> delete({required FreezeRequestModel value}){
    return repository.delete(value: value);
  }

}
