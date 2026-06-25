
import 'package:dartz/dartz.dart';
import '../../models/teacher_model.dart';
import '../repository/repository.dart';

class TeacherRecordsUseCase{
  final TeacherRecordsRepository repository;
  TeacherRecordsUseCase({required this.repository});


  Future<Either<String,String>> addTeacher({required TeacherModel value})async{
    return repository.addTeacher(value: value);
  }

  Future<Either<String,String>> update({required TeacherModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,String>> delete({required TeacherModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<TeacherModel>>> getTeachers(){
    return repository.getTeachers();
  }


}
