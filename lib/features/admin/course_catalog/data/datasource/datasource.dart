
import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:college_management/features/admin/course_catalog/models/course_catalog_model.dart';
import 'package:dartz/dartz.dart';

abstract class CourseCatalogAdminDataSource{
  Future<Either<String,String>> addCourseCatalog({required CourseCatalogModel model});
  Future<Either<String,List<CourseCatalogModel>>> getCourseCatalog();
  Future<Either<String,String>> deleteCourseCatalog({required CourseCatalogModel model});
  Future<Either<String,String>> updateCatalog({required CourseCatalogModel model});
}


class FunctionClassCourseCatalogAdmin extends CourseCatalogAdminDataSource{
final DioHelper dio=DioHelper();
  
  // function
  @override
  Future<Either<String,String>> addCourseCatalog({required CourseCatalogModel model})async{
    try{
      var response=await dio.post(AppApis.courseCatalog,data: model.toMap());
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data added");;
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  // function
  @override
  Future<Either<String,String>> updateCatalog({required CourseCatalogModel model})async{
    try{
      var response=await dio.put("${AppApis.courseCatalog}/${model.id}",data: model.toMap());
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data updated");
      }
      return Left(data["message"]??data["error"]??"Data not updated");
    }catch(e){
      return Left(e.toString());
    }
  }

  // function
  @override
  Future<Either<String,String>> deleteCourseCatalog({required CourseCatalogModel model})async{
    try{
      var response=await dio.delete("${AppApis.courseCatalog}/${model.id}");
      if(response.statusCode! >=200 && response.statusCode! <=300){
        String message=response.data["message"]??response.data["error"]??"Data updated successfully";
        return Right(message);
      }
      return Left(response.data["message"]??response.data["error"]??"Data not deleted");
    }catch(e){
      return Left(e.toString());
    }
  }

  // function
  @override
  Future<Either<String,List<CourseCatalogModel>>> getCourseCatalog()async{
    try{
      var response=await dio.get(AppApis.courseCatalog);
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        var data=response.data;
        if(data is List){

          // log("2343242: ${response.data}");
          List<CourseCatalogModel> dataList =
          data.map<CourseCatalogModel>(
                (val) => CourseCatalogModel.fromMap(val),
          )
              .toList();

          return Right(dataList);
        }else{
          return Left("Data not found");
        }
      }
      return Left(data["message"]??data["error"]??"Data not found");
    }catch(e){
      return Left(e.toString());
    }
  }
}