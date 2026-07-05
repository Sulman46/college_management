import 'dart:developer';

import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/student_result/model/user_result_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../model/filter_result_model.dart';

abstract class StudentResultDataSource{
  Future<Either<String,List<UserResultModel>>> get({required FilterResultModel model});
}


class FunctionClassStudentResult extends StudentResultDataSource{
  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,List<UserResultModel>>> get({required FilterResultModel model})async{
    try{
      var response=await _dioHelper.get(AppApis.resultSheet,queryParameters: model.toMap());
      var data=response.data;
      log("453234: ${response.data}");
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("453234: ${response.data}");
        if(data is List){
          List<UserResultModel> model=data.map((e) =>UserResultModel.fromMap(e) ,).toList();
          return Right(model);
        }else{
          return Left(data["message"]??data["msg"]??data["error"]??"Failed");
        }
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  
}