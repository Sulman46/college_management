import 'dart:developer';

import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:college_management/features/admin/teacher_allocation/models/teacher_allocation_model.dart';
import 'package:dartz/dartz.dart';

abstract class TeacherAllocationDataSource{
  Future<Either<String,TeacherAllocationModel>> post({required TeacherAllocationModel value});
  Future<Either<String,TeacherAllocationModel>> update({required TeacherAllocationModel value});
  Future<Either<String,bool>> delete({required TeacherAllocationModel value});
  Future<Either<String,List<TeacherAllocationModel>>> get();
}


class FunctionClassTeacherAllocation extends TeacherAllocationDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,TeacherAllocationModel>> post({required TeacherAllocationModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.teacherAllocation,data: value.toMap());
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        TeacherAllocationModel model=TeacherAllocationModel.fromMap(data['data']);

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
  Future<Either<String,TeacherAllocationModel>> update({required TeacherAllocationModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.teacherAllocation}/${value.id}",data: value.toMap());
      log("3223423: ${response.data}");
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        TeacherAllocationModel model=TeacherAllocationModel.fromMap(data['data']);
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
  Future<Either<String,bool>> delete({required TeacherAllocationModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.teacherAllocation}/${value.id}");
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
  Future<Either<String,List<TeacherAllocationModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.teacherAllocation);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<TeacherAllocationModel> model=data.map((e)=>TeacherAllocationModel.fromMap(e)).toList();
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