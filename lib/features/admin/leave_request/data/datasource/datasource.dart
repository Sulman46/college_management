import 'dart:developer';

import 'package:college_management/features/admin/leave_request/models/faculty_leave_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';


abstract class LeaveRequestDataSource{
  Future<Either<String,String>> post({required FacultyLeaveModel value});
  Future<Either<String,String>> update({required FacultyLeaveModel value});
  Future<Either<String,String>> delete({required FacultyLeaveModel value});
  Future<Either<String,List<FacultyLeaveModel>>> get();
}


class FunctionClassLeaveRequest extends LeaveRequestDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required FacultyLeaveModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.leave,data: value.toMap());
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
  Future<Either<String,String>> update({required FacultyLeaveModel value})async{
    try{
      var response=await _dioHelper.patch("${AppApis.leave}/${value.id}",data: value.toMap());
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
  Future<Either<String,String>> delete({required FacultyLeaveModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.leave}/${value.id}");
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
  Future<Either<String,List<FacultyLeaveModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.leave);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<FacultyLeaveModel> model=data.map((e)=>FacultyLeaveModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data["message"]??data["error"]??"Failed");
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