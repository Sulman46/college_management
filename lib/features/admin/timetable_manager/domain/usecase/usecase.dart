
import 'package:dartz/dartz.dart';
import '../../models/time_table_manger_model.dart';
import '../repository/repository.dart';

class TimetableManagerUseCase{
  final TimetableManagerRepository repository;
  TimetableManagerUseCase({required this.repository});


  Future<Either<String,String>> post({required TimeTableManagerModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,String>> update({required TimeTableManagerModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,String>> delete({required TimeTableManagerModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<TimeTableManagerModel>>> get(){
    return repository.get();
  }

}
