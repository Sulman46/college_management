import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/teacher_model.dart';

abstract class TeacherRecordsDataSource{
  Future<Either<String,String>> addTeacher({required TeacherModel value});
  Future<Either<String,String>> update({required TeacherModel value});
  Future<Either<String,String>> delete({required TeacherModel value});
  Future<Either<String,List<TeacherModel>>> getTeachers();
}


class FunctionClassTeacherRecords extends TeacherRecordsDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> addTeacher({required TeacherModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.teachers,data: value.toMap());
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
  Future<Either<String,String>> update({required TeacherModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.teachers}/${value.id}",data: value.toMap());
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
  Future<Either<String,String>> delete({required TeacherModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.teachers}/${value.id}");
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
  Future<Either<String,List<TeacherModel>>> getTeachers()async{
    try{
      var response=await _dioHelper.get(AppApis.teachers);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<TeacherModel> model=data.map((e)=>TeacherModel.fromMap(e)).toList();
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