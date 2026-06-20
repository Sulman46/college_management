import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/hod_assign_model.dart';

abstract class HODAssignmentDataSource{
  Future<Either<String,HodAssignModel>> post({required HodAssignModel value});
  Future<Either<String,HodAssignModel>> update({required HodAssignModel value});
  Future<Either<String,bool>> delete({required HodAssignModel value});
  Future<Either<String,List<HodAssignModel>>> get();
}


class FunctionClassHODAssignment extends HODAssignmentDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,HodAssignModel>> post({required HodAssignModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.hodAssign,data: value.toMap());
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        // HodAssignModel model=HodAssignModel.fromMap(data);
        HodAssignModel model=value;

        return Right(model);
      }
      var data=response.data;
      return Left(data['message'] ?? "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,HodAssignModel>> update({required HodAssignModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.hodUpdate}/${value.id}",data: value.toMap());
      log("3223423: ${response.data}");
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        HodAssignModel model=HodAssignModel.fromMap(data);
        return Right(model);
      }
      var data=response.data;
      return Left(data['message'] ?? "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,bool>> delete({required HodAssignModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.hodDelete}/${value.id}");
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        return Right(true);
      }
      var data=response.data;
      return Left(data['message'] ?? "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,List<HodAssignModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.hodList);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<HodAssignModel> model=data.map((e)=>HodAssignModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data['message'] ?? "Failed",
          );
        }
      }
      var data=response.data;
      return Left(data['message'] ?? "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }
}