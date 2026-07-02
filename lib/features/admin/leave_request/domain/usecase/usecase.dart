
import 'package:dartz/dartz.dart';
import '../../models/faculty_leave_model.dart';
import '../repository/repository.dart';

class LeaveRequestUseCase{
  final LeaveRequestRepository repository;
  LeaveRequestUseCase({required this.repository});

  Future<Either<String,String>> post({required FacultyLeaveModel value}){
    return repository.post(value: value);
  }
  Future<Either<String,String>> update({required FacultyLeaveModel value}){
    return repository.update(value: value);

  }
  Future<Either<String,String>> delete({required FacultyLeaveModel value}){
    return repository.delete(value: value);

  }
  Future<Either<String,List<FacultyLeaveModel>>> get(){
    return repository.get();

  }

}
