
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';
import '../models/student_enrollment_filter_model.dart';
import '../models/student_enrollment_model.dart';

class StudentEnrollmentRepositoryImpl extends StudentEnrollmentRepository{
  final StudentEnrollmentDataSource dataSource;
  StudentEnrollmentRepositoryImpl({required this.dataSource});



  Future<Either<String,StudentEnrollmentModel>> post({required StudentEnrollmentModel value})async{
    return dataSource.post(value: value);
  }

  Future<Either<String,StudentEnrollmentModel>> update({required StudentEnrollmentModel value}){
    return dataSource.update(value: value);
  }

  Future<Either<String,bool>> delete({required StudentEnrollmentModel value}){
    return dataSource.delete(value: value);
  }

  Future<Either<String,List<StudentEnrollmentModel>>> get({required StudentEnrollmentFilterModel value}){
    return dataSource.get(value: value);
  }

}