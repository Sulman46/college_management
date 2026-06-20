
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/time_table_manger_model.dart';
import '../datasource/datasource.dart';

class TimetableManagerRepositoryImpl extends TimetableManagerRepository{
  final TimetableManagerDataSource dataSource;
  TimetableManagerRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,TimeTableManagerModel>> post({required TimeTableManagerModel value})async{
    return dataSource.post(value: value);
  }

  @override
  Future<Either<String,TimeTableManagerModel>> update({required TimeTableManagerModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,bool>> delete({required TimeTableManagerModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<TimeTableManagerModel>>> get(){
    return dataSource.get();
  }


}