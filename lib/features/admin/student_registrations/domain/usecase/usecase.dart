
import 'package:dartz/dartz.dart';
import '../../models/student_model.dart';
import '../repository/repository.dart';

class StudentRegistrationUseCase{
  final StudentRegistrationRepository repository;
  StudentRegistrationUseCase({required this.repository});

  Future<Either<String,String>> post({required StudentModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,StudentModel>> update({required StudentModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,bool>> delete({required StudentModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<StudentModel>>> get(){
    return repository.get();
  }

}
