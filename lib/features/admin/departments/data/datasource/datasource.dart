import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/features/admin/departments/data/model/department_model.dart';
import 'package:college_management/features/admin/departments/data/model/request_new_department_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/controllers/dio_helper.dart';

abstract class AdminDepartmentDataSource{
  Future<Either<String, DepartmentModel>> addNewDepartment({required RequestNewDepartmentModel model});
  Future<Either<String, DepartmentModel>> editDepartment({required RequestNewDepartmentModel model});
  Future<Either<String, List<DepartmentModel>>> getDepartments();
  Future<Either<String, String>> deleteDepartment(String id);
}


class FunctionClassAdminDepartment extends AdminDepartmentDataSource{
  final DioHelper dioHelper = DioHelper();
  // function
  Future<Either<String, DepartmentModel>> addNewDepartment({required RequestNewDepartmentModel model})async{
    try{

      final response=await dioHelper.post(AppApis.department,data: model.toMap());
      var data=response.data;

      if(response.statusCode! >=200 && response.statusCode! <=300){
        DepartmentModel departmentModel=DepartmentModel.fromMap(response.data);
        return Right(departmentModel);
      }

      return Left(
        data==null? "Failed":  data['message'] ??
            "Failed",
      );


    }catch(e){
      return Left(e.toString());
    }
  }

  Future<Either<String, DepartmentModel>> editDepartment({required RequestNewDepartmentModel model})async{
    try{

      final response=await dioHelper.put("${AppApis.department}/${model.id}",data: model.toMap());
      var data=response.data;

      if(response.statusCode! >=200 && response.statusCode! <=300){
        DepartmentModel departmentModel=DepartmentModel.fromMap(response.data);
        return Right(departmentModel);
      }

      return Left(
        data==null? "Failed":  data['message'] ??
            "Failed",
      );


    }catch(e){
      return Left(e.toString());
    }
  }

  Future<Either<String, List<DepartmentModel>>> getDepartments()async{
    try{

      final response=await dioHelper.get("${AppApis.department}");
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        List<DepartmentModel> departmentList=[];
        if(data is List){
          departmentList=data.map((e) => DepartmentModel.fromMap(e),).toList();
        }
        return Right(departmentList);
      }

      return Left(
        data==null? "Failed":  data['message'] ??
            "Failed",
      );


    }catch(e){
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteDepartment(String id)async{
    try{

      final response=await dioHelper.delete("${AppApis.department}/$id",);
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        String message=data['message']??"Department Deleted";
        return Right(message);
      }

      return Left(
        data==null? "Failed":  data['message'] ??
            "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }
  
  
}