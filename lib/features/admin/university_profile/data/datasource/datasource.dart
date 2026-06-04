import 'dart:developer';

import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/profile_update_model.dart';
import '../../models/university_model.dart';

abstract class UniversityProfileDataSource{
  Future<Either<String,UniversityModel>> addUniversitySetup({required UniversityModel universityModel });
  Future<Either<String,UniversityModel>> getUniversitySetup();
  Future<Either<String,String>> uploadProfile({required ProfileImageUpdateModel profileModel});
}


class FunctionClassUniversityProfile extends UniversityProfileDataSource{

  DioHelper _dioHelper=DioHelper();
  // function
  @override
  Future<Either<String,UniversityModel>> addUniversitySetup({required UniversityModel universityModel })async{
    try{
      var response=await _dioHelper.post(AppApis.universityProfileSetup,data: universityModel.toMap());
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        UniversityModel model=UniversityModel.fromMap(data['data']);
        return Right(model);
      }
      return Left(
        data==null? "Failed":  data['message'] ??
            "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,UniversityModel>> getUniversitySetup()async{
    try{
      var response=await _dioHelper.get(AppApis.universityProfileSetup);
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        UniversityModel model=UniversityModel.fromMap(data);
        return Right(model);
      }
      return Left(
        data==null? "Failed":  data['message'] ??
            "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> uploadProfile({required ProfileImageUpdateModel profileModel})async{
    try{
      FormData formData=FormData.fromMap({
        "userId":profileModel.userId,
        "image":await MultipartFile.fromFile(profileModel.image.path.split('/').last)
      });
      var response=await _dioHelper.postWithFile(AppApis.profileImageUpdate,data: formData);
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        String url=data["imageUrl"]??"";
        return Right(url);
      }
      return Left(
        data==null? "Failed":  data['message'] ??
            "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }



}