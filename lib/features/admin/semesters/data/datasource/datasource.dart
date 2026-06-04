import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:college_management/features/admin/semesters/models/semester_levels_model.dart';
import 'package:dartz/dartz.dart';

abstract class SemesterAdminDataSource{
  Future<Either<String,SemesterLevelsModel>> addSemester({required SemesterLevelsModel semesterModel});
  Future<Either<String,SemesterLevelsModel>> updateSemester({required SemesterLevelsModel semesterModel});
  Future<Either<String,bool>> deleteSemester({required SemesterLevelsModel semesterModel});
  Future<Either<String,List<SemesterLevelsModel>>> getSemester();
}


class FunctionClassSemesterAdmin extends SemesterAdminDataSource{

  final DioHelper dioHelper=DioHelper();
  // function
  @override
  Future<Either<String,SemesterLevelsModel>> addSemester({required SemesterLevelsModel semesterModel})async{
    try{
      var response=await dioHelper.post(AppApis.semester,data: semesterModel.toMap());
      if(response.statusCode! >=200 && response.statusCode! <=300){
        var data=response.data;
        SemesterLevelsModel model=SemesterLevelsModel.fromMap(data);

        return Right(model);
      }else{
        var data=response.data;
        return Left(
          data==null? "Data not deleted":  data['message'] ??
              "Data not deleted",
        );
      }
    }catch(e){
      return Left(e.toString());
    }
  }
 // function
  @override
  Future<Either<String,SemesterLevelsModel>> updateSemester({required SemesterLevelsModel semesterModel})async{
    try{
      var response=await dioHelper.put("${AppApis.semester}/${semesterModel.id}",data: semesterModel.toMap());
      if(response.statusCode! >=200 && response.statusCode! <=300){
        var data=response.data;
        SemesterLevelsModel model=SemesterLevelsModel.fromMap(data);
        return Right(model);
      }else{
        var data=response.data;
        return Left(
          data==null? "Data not Added":  data['message'] ??
              "Data not Added",
        );
      }
    }catch(e){
      return Left(e.toString());
    }
  }
 // function

 @override
 Future<Either<String,bool>> deleteSemester({required SemesterLevelsModel semesterModel})async{
    try{
      var response=await dioHelper.delete("${AppApis.semester}/${semesterModel.id}");
      if(response.statusCode! >=200 && response.statusCode! <=300){

        return Right(true);
      }else{
        var data=response.data;
        return Left(
          data==null? "Data not Added":  data['message'] ??
              "Data not Added",
        );
      }
    }catch(e){
      return Left(e.toString());
    }
  }
 // function
  @override
  Future<Either<String,List<SemesterLevelsModel>>> getSemester()async{
    try{
      var response=await dioHelper.get(AppApis.semester,);
      if(response.statusCode! >=200 && response.statusCode! <=300){
        var data=response.data;
        List<SemesterLevelsModel> dataList=[];
        if(data is List){
          dataList =data.map((e) => SemesterLevelsModel.fromMap(e),).toList();
        }else{
          Left("Failed",);
        }

        return Right(dataList);
      }else{
        var data=response.data;
        return Left(
          data==null? "Failed":  data['message'] ??
              "Failed",
        );
      }
    }catch(e){
      return Left(e.toString());
    }
  }
}