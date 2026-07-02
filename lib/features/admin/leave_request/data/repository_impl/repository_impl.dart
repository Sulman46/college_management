
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/faculty_leave_model.dart';
import '../datasource/datasource.dart';

class LeaveRequestRepositoryImpl extends LeaveRequestRepository{
  final LeaveRequestDataSource dataSource;
  LeaveRequestRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,String>> post({required FacultyLeaveModel value}){
    return dataSource.post(value: value);
  }
  @override
  Future<Either<String,String>> update({required FacultyLeaveModel value}){
    return dataSource.update(value: value);

  }
  @override
  Future<Either<String,String>> delete({required FacultyLeaveModel value}){
    return dataSource.delete(value: value);

  }
  @override
  Future<Either<String,List<FacultyLeaveModel>>> get(){
    return dataSource.get();

  }
}