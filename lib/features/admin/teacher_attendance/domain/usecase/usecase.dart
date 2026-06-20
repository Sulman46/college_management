
import 'package:dartz/dartz.dart';
import '../../models/teacher_attendance_model.dart';
import '../repository/repository.dart';

class TeacherAttendanceUseCase{
  final TeacherAttendanceRepository repository;
  TeacherAttendanceUseCase({required this.repository});


  Future<Either<String,TeacherAttendanceModel>> post({required TeacherAttendanceModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,TeacherAttendanceModel>> update({required TeacherAttendanceModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,bool>> delete({required TeacherAttendanceModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<TeacherAttendanceModel>>> get(){
    return repository.get();
  }

}
