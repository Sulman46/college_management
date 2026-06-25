import 'dart:developer';
import 'package:college_management/core/helper/show_message.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/teacher_attendance_model.dart';

abstract class TeacherAttendanceDataSource{
  Future<Either<String,String>> post({required TeacherAttendanceModel value});
  Future<Either<String,String>> update({required TeacherAttendanceModel value});
  Future<Either<String,String>> delete({required TeacherAttendanceModel value});
  Future<Either<String,List<TeacherAttendanceModel>>> get();
}


class FunctionClassTeacherAttendance extends TeacherAttendanceDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required TeacherAttendanceModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.teacherAttendancePost,data: value.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data added");

      }
      return Left(data["message"]??data["error"]??"Failed");

    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> update({required TeacherAttendanceModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.teacherAttendanceEdit}/${value.id}",data: value.toMap());
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
  Future<Either<String,String>> delete({required TeacherAttendanceModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.teacherAttendanceDelete}/${value.id}");
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
  Future<Either<String,List<TeacherAttendanceModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.teacherAttendanceHistory);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data["data"];
        if(data is List){
          List<TeacherAttendanceModel> model=data.map((e)=>TeacherAttendanceModel.fromMap(e)).toList();
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