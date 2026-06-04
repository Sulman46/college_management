import 'package:dartz/dartz.dart';

import '../../data/model/department_model.dart';
import '../../data/model/request_new_department_model.dart';

abstract class AdminDepartmentRepository{
  Future<Either<String, DepartmentModel>> addNewDepartment({required RequestNewDepartmentModel model});
  Future<Either<String, List<DepartmentModel>>> getDepartments();
  Future<Either<String, String>> deleteDepartment(String id);
  Future<Either<String, DepartmentModel>> editDepartment({required RequestNewDepartmentModel model});
}