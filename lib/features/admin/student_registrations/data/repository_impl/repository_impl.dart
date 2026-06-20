
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/student_model.dart';
import '../datasource/datasource.dart';

class StudentRegistrationRepositoryImpl extends StudentRegistrationRepository{
  final StudentRegistrationDataSource dataSource;
  StudentRegistrationRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,String>> post({required StudentModel value})async{
    return dataSource.post(value: value);
  }

  @override
  Future<Either<String,StudentModel>> update({required StudentModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,bool>> delete({required StudentModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<StudentModel>>> get(){
    return dataSource.get();
  }

}