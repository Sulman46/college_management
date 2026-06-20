import 'dart:developer';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/teacher_attendance_model.dart';

abstract class TeacherAttendanceDataSource{
  Future<Either<String,TeacherAttendanceModel>> post({required TeacherAttendanceModel value});
  Future<Either<String,TeacherAttendanceModel>> update({required TeacherAttendanceModel value});
  Future<Either<String,bool>> delete({required TeacherAttendanceModel value});
  Future<Either<String,List<TeacherAttendanceModel>>> get();
}


class FunctionClassTeacherAttendance extends TeacherAttendanceDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,TeacherAttendanceModel>> post({required TeacherAttendanceModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.teacherAttendancePost,data: value.toMap());
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        TeacherAttendanceModel model=TeacherAttendanceModel.fromMap(data['data']);

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
  Future<Either<String,TeacherAttendanceModel>> update({required TeacherAttendanceModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.teacherAttendanceEdit}/${value.id}",data: value.toMap());
      log("3223423: ${response.data}");
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        TeacherAttendanceModel model=TeacherAttendanceModel.fromMap(data['data']);
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
  Future<Either<String,bool>> delete({required TeacherAttendanceModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.teacherAttendanceDelete}/${value.id}");
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