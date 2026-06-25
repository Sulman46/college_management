
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';
import '../models/student_enrollment_filter_model.dart';
import '../models/student_enrollment_model.dart';

class StudentEnrollmentRepositoryImpl extends StudentEnrollmentRepository{
  final StudentEnrollmentDataSource dataSource;
  StudentEnrollmentRepositoryImpl({required this.dataSource});



  @override
  Future<Either<String,String>> post({required StudentEnrollmentModel value})async{
    return dataSource.post(value: value);
  }

  @override
  Future<Either<String,String>> promote({required StudentEnrollmentModel value})async{
    return dataSource.promote(value: value);
  }

  @override
  Future<Either<String,String>> demote({required StudentEnrollmentModel value})async{
    return dataSource.demote(value: value);
  }

  @override
  Future<Either<String,String>> update({required StudentEnrollmentModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,String>> delete({required StudentEnrollmentModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<StudentEnrollmentModel>>> get({required StudentEnrollmentFilterModel value}){
    return dataSource.get(value: value);
  }

}