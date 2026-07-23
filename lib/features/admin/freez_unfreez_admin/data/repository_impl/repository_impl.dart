
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/freeze_request_model.dart';
import '../../models/student_freeze_request_model.dart';
import '../datasource/datasource.dart';

class FreezUnFreezRepositoryImpl extends FreezUnFreezRepository {
  final FreezUnFreezDataSource dataSource;

  FreezUnFreezRepositoryImpl({required this.dataSource});

  @override
  Future<Either<String, List<FreezeRequestModel>>> getPen() {
    return dataSource.getPen();
  }

  @override
  Future<Either<String,List<FreezeRequestModel>>> getFinal(){
    return dataSource.getFinal();
  }

  @override
  Future<Either<String,String>> update({required FreezeRequestModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,String>> delete({required FreezeRequestModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<FreezeRequestModel>>> getMyRequest({required String srNo}){
    return dataSource.getMyRequest(srNo: srNo);
  }

  @override
  Future<Either<String,String>> post({required StudentFreezeRequestModel value}){
    return dataSource.post(value: value);
  }

}