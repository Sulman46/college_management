import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/teacher_model.dart';

abstract class TeacherRecordsDataSource{
  Future<Either<String,TeacherModel>> addTeacher({required TeacherModel value});
  Future<Either<String,TeacherModel>> update({required TeacherModel value});
  Future<Either<String,bool>> delete({required TeacherModel value});
  Future<Either<String,List<TeacherModel>>> getTeachers();
}


class FunctionClassTeacherRecords extends TeacherRecordsDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,TeacherModel>> addTeacher({required TeacherModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.teachers,data: value.toMap());
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        TeacherModel model=TeacherModel.fromMap(response.data!);
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
  Future<Either<String,TeacherModel>> update({required TeacherModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.teachers}/${value.id}",data: value.toMap());
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        TeacherModel model=TeacherModel.fromMap(response.data!);
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
  Future<Either<String,bool>> delete({required TeacherModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.teachers}/${value.id}");
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