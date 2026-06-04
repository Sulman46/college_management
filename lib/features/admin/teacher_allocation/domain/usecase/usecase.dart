
import 'package:dartz/dartz.dart';
import '../../../teacher_records/models/teacher_model.dart';
import '../../models/teacher_allocation_model.dart';
import '../repository/repository.dart';

class TeacherAllocationUseCase{
  final TeacherAllocationRepository repository;
  TeacherAllocationUseCase({required this.repository});

  Future<Either<String,TeacherAllocationModel>> post({required TeacherAllocationModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,TeacherAllocationModel>> update({required TeacherAllocationModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,bool>> delete({required TeacherAllocationModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<TeacherAllocationModel>>> get(){
    return repository.get();
  }


}
