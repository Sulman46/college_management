import 'dart:developer';

import 'package:college_management/core/helper/show_message.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/time_table_manger_model.dart';

abstract class TimetableManagerDataSource{
  Future<Either<String,String>> post({required TimeTableManagerModel value});
  Future<Either<String,String>> update({required TimeTableManagerModel value});
  Future<Either<String,String>> delete({required TimeTableManagerModel value});
  Future<Either<String,List<TimeTableManagerModel>>> get();
}


class FunctionClassTimetableManager extends TimetableManagerDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required TimeTableManagerModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.timeTableManager,data: value.toMap());
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
  Future<Either<String,String>> update({required TimeTableManagerModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.timeTableManager}/${value.id}",data: value.toMap());
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
  Future<Either<String,String>> delete({required TimeTableManagerModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.timeTableManager}/${value.id}");
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
  Future<Either<String,List<TimeTableManagerModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.timeTableManager);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<TimeTableManagerModel> model=data.map((e)=>TimeTableManagerModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data['message'] ??data['error'] ?? "Failed",
          );
        }
      }
      var data=response.data;
      return Left(data['message'] ??data['error'] ?? "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

}