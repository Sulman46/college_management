
import 'package:dartz/dartz.dart';
import '../../models/teacher_model.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';

class TeacherRecordsRepositoryImpl extends TeacherRecordsRepository{
  final TeacherRecordsDataSource dataSource;
  TeacherRecordsRepositoryImpl({required this.dataSource});



  @override
  Future<Either<String,TeacherModel>> addTeacher({required TeacherModel value})async{
    return dataSource.addTeacher(value: value);
  }

  @override
  Future<Either<String,TeacherModel>> update({required TeacherModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,bool>> delete({required TeacherModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<TeacherModel>>> getTeachers(){
    return dataSource.getTeachers();
  }


}