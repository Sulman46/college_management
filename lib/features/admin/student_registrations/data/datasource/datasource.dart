import 'dart:developer';
import 'package:college_management/core/helper/show_message.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/student_model.dart';

abstract class StudentRegistrationDataSource{
  Future<Either<String,String>> post({required StudentModel value});
  Future<Either<String,StudentModel>> update({required StudentModel value});
  Future<Either<String,bool>> delete({required StudentModel value});
  Future<Either<String,List<StudentModel>>> get();
}


class FunctionClassStudentRegistration extends StudentRegistrationDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required StudentModel value})async{
    try{
      var formData=await value.toFormData();

      var response=await _dioHelper.postWithFile(AppApis.studentRegister,data: formData);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        String data=response.data['message']??"";
        return Right(data);
      }
      var data=response.data;
      return Left(data['error'] ?? "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,StudentModel>> update({required StudentModel value})async{
    try{
      var formData=await value.toFormData();
      var response=await _dioHelper.putWithFile("${AppApis.studentRegister}/${value.id}",data: formData);
      log("3223423: ${response.data}");
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        StudentModel model=StudentModel.fromMap(data['student']);
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
  Future<Either<String,bool>> delete({required StudentModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.studentRegister}/${value.id}");
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
  Future<Either<String,List<StudentModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.studentRegister);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<StudentModel> model=data.map((e)=>StudentModel.fromMap(e)).toList();
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