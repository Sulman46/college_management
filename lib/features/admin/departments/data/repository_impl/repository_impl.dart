
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../datasource/datasource.dart';
import '../model/department_model.dart';
import '../model/request_new_department_model.dart';

class AdminDepartmentRepositoryImpl extends AdminDepartmentRepository{
  final AdminDepartmentDataSource dataSource;
  AdminDepartmentRepositoryImpl({required this.dataSource});

  @override
  Future<Either<String, DepartmentModel>> addNewDepartment({required RequestNewDepartmentModel model}){
    return dataSource.addNewDepartment(model: model);
  }
  
  @override
  Future<Either<String, List<DepartmentModel>>> getDepartments(){
    return dataSource.getDepartments();
  }
  
  @override
  Future<Either<String, String>> deleteDepartment(String id){
    return dataSource.deleteDepartment(id);
  }
  
  @override
  Future<Either<String, DepartmentModel>> editDepartment({required RequestNewDepartmentModel model}){
    return dataSource.editDepartment(model: model);
  }

}