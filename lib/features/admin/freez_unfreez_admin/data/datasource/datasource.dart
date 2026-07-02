import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/freeze_request_model.dart';

abstract class FreezUnFreezDataSource{
  Future<Either<String,List<FreezeRequestModel>>> getPen();
  Future<Either<String,List<FreezeRequestModel>>> getFinal();
  Future<Either<String,String>> update({required FreezeRequestModel value});
  Future<Either<String,String>> delete({required FreezeRequestModel value});
}


class FunctionClassFreezUnFreez extends FreezUnFreezDataSource{
  final DioHelper _dioHelper=DioHelper();


  @override
  Future<Either<String,List<FreezeRequestModel>>> getPen()async{
    try{
      var response=await _dioHelper.get(AppApis.freezePendingRequest);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<FreezeRequestModel> model=data.map((e)=>FreezeRequestModel.fromMap(e)).toList();
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
  

  @override
  Future<Either<String,List<FreezeRequestModel>>> getFinal()async{
    try{
      var response=await _dioHelper.get(AppApis.freezeFinalizedRequest);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<FreezeRequestModel> model=data.map((e)=>FreezeRequestModel.fromMap(e)).toList();
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




  @override
  Future<Either<String,String>> update({required FreezeRequestModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.updateFreezeStatus}/${value.id}",data: value.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data Updated");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> delete({required FreezeRequestModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.deleteFreezeRequest}/${value.id}");
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data deleted");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }


}