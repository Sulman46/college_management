import 'dart:developer';

import 'package:college_management/features/admin/faculty_workload/model/workload_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';

abstract class FacultyWorkLoadDataSource{
  Future<Either<String,WorkloadResponseModel>> get();
}


class FunctionClassFacultyWorkLoad extends FacultyWorkLoadDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,WorkloadResponseModel>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.workload);

      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        WorkloadResponseModel model=WorkloadResponseModel.fromMap(data);
        return Right(model);
        }

      return Left(data["message"]??data["error"]??"Data not found");
    }catch(e){
      return Left(e.toString());
    }
  }


}