import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:college_management/features/admin/programs/models/program_model.dart';
import 'package:college_management/features/admin/programs/models/program_request_model.dart';
import 'package:dartz/dartz.dart';

abstract class AdminProgramsDataSource{
  Future<Either<String,String>> addProgram({required ProgramRequestModel programRequestModel});
  Future<Either<String,String>> updateProgram({required ProgramRequestModel programRequestModel});
  Future<Either<String,List<ProgramModel>>> getPrograms();
  Future<Either<String,String>> deleteProgram({required String id});
}


class FunctionClassAdminPrograms extends AdminProgramsDataSource{
 final DioHelper _dioHelper=DioHelper();
  // function
  @override
  Future<Either<String,String>> addProgram({ required ProgramRequestModel programRequestModel})async{
    try{
      var response=await _dioHelper.post(AppApis.program,data: programRequestModel.toMap());
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data added");

      }
      return Left(data["message"]??data["error"]??"Failed");
      
    }catch(e){
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String,String>> updateProgram({ required ProgramRequestModel programRequestModel})async{
    try{
      var response=await _dioHelper.put("${AppApis.program}/${programRequestModel.id}",data: programRequestModel.toMap());
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data updated");

      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

 @override
  Future<Either<String,List<ProgramModel>>> getPrograms()async{
    try{
      var response=await _dioHelper.get(AppApis.program);
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        List<ProgramModel> dataList=[];
        if(data is List){
          dataList=data.map((e) => ProgramModel.fromMap(e),).toList();
        }
        return Right(dataList);
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

 @override
  Future<Either<String,String>> deleteProgram({required String id})async{
    try{
      var response=await _dioHelper.delete("${AppApis.program}/$id");
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data deleted");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }
}