import 'dart:developer';

import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/student_enrollment/data/models/student_enrollment_filter_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../models/student_enrollment_model.dart';

abstract class StudentEnrollmentDataSource{
  Future<Either<String,String>> post({required StudentEnrollmentModel value});
  Future<Either<String,String>> promote({required StudentEnrollmentModel value});
  Future<Either<String,String>> demote({required StudentEnrollmentModel value});
  Future<Either<String,String>> update({required StudentEnrollmentModel value});
  Future<Either<String,String>> delete({required StudentEnrollmentModel value});
  Future<Either<String,List<StudentEnrollmentModel>>> get({required StudentEnrollmentFilterModel value});
}


class FunctionClassStudentEnrollment extends StudentEnrollmentDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required StudentEnrollmentModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.studentEnrollments,data: value.toMap());

      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data added");

      }
      return Left(data['message'] ?? "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> promote({required StudentEnrollmentModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.studentEnrollmentsPromote,data: value.toMap());
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
  Future<Either<String,String>> demote({required StudentEnrollmentModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.studentEnrollmentsDemote,data: value.toMap());
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
  Future<Either<String,String>> update({required StudentEnrollmentModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.studentEnrollments}/${value.id}",data: value.toMap());
      log("3223423: ${response.data}");
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
  Future<Either<String,String>> delete({required StudentEnrollmentModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.studentEnrollments}/${value.id}");
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data deleted");
      }
      return Left(data["message"]??data["error"]??"Failed");

    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,List<StudentEnrollmentModel>>> get({required StudentEnrollmentFilterModel value})async{
    try{
      var response=await _dioHelper.get(AppApis.studentEnrollments,queryParameters: value.toMap());

      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<StudentEnrollmentModel> model=data.map((e)=>StudentEnrollmentModel.fromMap(e)).toList();
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