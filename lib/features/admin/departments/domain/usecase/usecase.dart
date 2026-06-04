
import 'package:dartz/dartz.dart';
import '../../data/model/department_model.dart';
import '../../data/model/request_new_department_model.dart';
import '../repository/repository.dart';

class AdminDepartmentUseCase{
  final AdminDepartmentRepository repository;
  AdminDepartmentUseCase({required this.repository});

  Future<Either<String, DepartmentModel>> addNewDepartment({required RequestNewDepartmentModel model}){
    return repository.addNewDepartment(model: model);
  }

  Future<Either<String, List<DepartmentModel>>> getDepartments(){
    return repository.getDepartments();
  }
  Future<Either<String, String>> deleteDepartment(String id){
    return repository.deleteDepartment(id);
  }

  Future<Either<String, DepartmentModel>> editDepartment({required RequestNewDepartmentModel model}){
    return repository.editDepartment(model: model);
  }
}
