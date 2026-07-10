
import 'package:dartz/dartz.dart';
import '../../data/models/student_enrollment_filter_model.dart';
import '../../data/models/student_enrollment_model.dart';
import '../repository/repository.dart';

class StudentEnrollmentUseCase{
  final StudentEnrollmentRepository repository;
  StudentEnrollmentUseCase({required this.repository});

  Future<Either<String,String>> post({required StudentEnrollmentModel value})async{
    return repository.post(value: value);
  }
  Future<Either<String,String>> promote({required StudentEnrollmentModel value})async{
    return repository.promote(value: value);
  }
  Future<Either<String,String>> demote({required StudentEnrollmentModel value})async{
    return repository.demote(value: value);
  }

  Future<Either<String,String>> update({required StudentEnrollmentModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,String>> delete({required StudentEnrollmentModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<StudentEnrollmentModel>>> get({required StudentEnrollmentFilterModel value}){
    return repository.get(value: value);
  }

  Future<Either<String,List<StudentEnrollmentModel>>> search({required String rollNumber}){
    return repository.search(rollNumber: rollNumber);
  }

}
