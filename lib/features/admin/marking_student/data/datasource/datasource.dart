import 'dart:developer';
import 'package:college_management/features/admin/marking_student/models/marking_student_filter_model.dart';
import 'package:college_management/features/admin/marking_student/models/student_history_marks_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/bulk_save_marking_model.dart';
import '../../models/marks_student_model.dart';

abstract class MarkingStudentDataSource{
  Future<Either<String,MarksResponseModel>> get({required MarkingStudentFilterModel model});
  Future<Either<String,List<StudentHistoryMarksModel>>> search({required String rollNo});
  Future<Either<String,String>> bulkSaveData({required BulkSaveMarksRequest model});
  Future<Either<String,String>> lockStatus({required BulkSaveMarksRequest model});
}


class FunctionClassMarkingStudent extends MarkingStudentDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,MarksResponseModel>> get({required MarkingStudentFilterModel model})async{
    try{
      var response=await _dioHelper.get(AppApis.markingCourseData,queryParameters: model.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("453234: ${response.data}");
        MarksResponseModel model=MarksResponseModel.fromMap(data);
        return Right(model);
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,List<StudentHistoryMarksModel>>> search({required String rollNo})async{
    try{
      var response=await _dioHelper.get("${AppApis.studentMarkingHistory}$rollNo");
      var data=response.data;
      log("2332: ${data}");
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        var history=data["history"];
        if(history is List){
          List<StudentHistoryMarksModel> model=history.map((e) =>StudentHistoryMarksModel.fromMap(e) ,).toList();
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

  @override
  Future<Either<String,String>> bulkSaveData({required BulkSaveMarksRequest model})async{
    try{
      var response=await _dioHelper.post(AppApis.bulkSaveMarks,data: model.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){

        return Right(data["message"]??data["msg"]??data["error"]??"Data added");
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }


  @override
  Future<Either<String,String>> lockStatus({required BulkSaveMarksRequest model})async{
    try{
      var response=await _dioHelper.patch(AppApis.markingLock,data: model.lockMap());
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