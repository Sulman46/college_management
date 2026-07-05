import 'dart:developer';
import 'package:college_management/features/admin/exam_schedule/models/exams_schedule_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/filter_exams_schedule_model.dart';

abstract class ExamScheduleDataSource{
  Future<Either<String,ExamScheduleResponseModel>> get({required FilterExamsScheduleModel model});
  Future<Either<String,String>> examScheduleSave({required Map<String, dynamic> model});
}


class FunctionClassExamSchedule extends ExamScheduleDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,ExamScheduleResponseModel>> get({required FilterExamsScheduleModel model})async{
    try{
      var response=await _dioHelper.get(AppApis.fetchExamDate,queryParameters: model.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("453234: ${response.data}");
        ExamScheduleResponseModel model=ExamScheduleResponseModel.fromMap(data);
        return Right(model);
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

@override
Future<Either<String,String>> examScheduleSave({required Map<String, dynamic> model})async{
    try{
      var response=await _dioHelper.post(AppApis.examScheduleBulkSave,data: model);
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["msg"]??data["error"]??"Data updated");
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }


}