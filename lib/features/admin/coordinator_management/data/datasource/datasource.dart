import 'dart:developer';

import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/coordinator_management/presentation/models/coordinator_register_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';

abstract class CoordinatorManagementDataSource{
  Future<Either<String,String>> post({required CoordinatorRegisterModel value});
  Future<Either<String,String>> update({required CoordinatorRegisterModel value});
  Future<Either<String,String>> delete({required CoordinatorRegisterModel value});
  Future<Either<String,List<CoordinatorRegisterModel>>> get();
}


class FunctionClassCoordinatorManagement extends CoordinatorManagementDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required CoordinatorRegisterModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.coordinatorRegister,data: value.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");

        return Right(data["message"]??data["error"]??"Data added");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> update({required CoordinatorRegisterModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.coordinatorManagement}/${value.id}",data: value.toMap());
      log("3223423: ${response.data}");
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data updated");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> delete({required CoordinatorRegisterModel value})async{
    try{

      var response=await _dioHelper.delete("${AppApis.coordinatorManagement}/${value.id}");
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data updated");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,List<CoordinatorRegisterModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.coordinatorManagement);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<CoordinatorRegisterModel> model=data.map((e)=>CoordinatorRegisterModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data['message'] ??data['error'] ??  "Failed",
          );
        }
      }
      var data=response.data;
      return Left(data['message'] ??data['error'] ??  "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }
}