import 'dart:developer';

import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:college_management/features/admin/course_mapping/model/course_mapping_model.dart';
import 'package:dartz/dartz.dart';

abstract class CourseMappingDataSource{
  Future<Either<String,CourseMappingModel>> addMapping({required CourseMappingModel value});
  Future<Either<String,CourseMappingModel>> update({required CourseMappingModel value});
  Future<Either<String,bool>> delete({required CourseMappingModel value});
  Future<Either<String,List<CourseMappingModel>>> getMappingData();
}


class FunctionClassCourseMapping extends CourseMappingDataSource{

  final DioHelper _dioHelper=DioHelper();

  // function
  @override
  Future<Either<String,CourseMappingModel>> addMapping({required CourseMappingModel value})async{
    try{

      var response= await _dioHelper.post(AppApis.courseMapping,data: value.toMap());

      if(response.statusCode! >=200 && response.statusCode! <=300){
        CourseMappingModel model=CourseMappingModel.fromMap(response.data);
        return Right(model);
      }

      return Left(response.data["message"]??"Data not added");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,CourseMappingModel>> update({required CourseMappingModel value})async{
    try{

      var response= await _dioHelper.put("${AppApis.courseMapping}/${value.id}",data: value.toMap());

      if(response.statusCode! >=200 && response.statusCode! <=300){
        CourseMappingModel model=CourseMappingModel.fromMap(response.data);
        return Right(model);
      }

      return Left(response.data["message"]??"Data not updated");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,bool>> delete({required CourseMappingModel value})async{
    try{

      var response= await _dioHelper.delete("${AppApis.courseMapping}/${value.id}",data: value.toMap());

      if(response.statusCode! >=200 && response.statusCode! <=300){
        return Right(true);
      }

      return Left(response.data["message"]??"Data not deleted");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,List<CourseMappingModel>>> getMappingData()async{
    try{

      var response= await _dioHelper.get(AppApis.courseMapping);
      if(response.statusCode! >=200 && response.statusCode! <=300){
        var data=response.data;
        if(data is List){
          List<CourseMappingModel> model=data.map((e) => CourseMappingModel.fromMap(e),).toList();
          return Right(model);
        }
      }

      return Left(response.data["message"]??"Data not found");
    }catch(e){
      return Left(e.toString());
    }
  }


}