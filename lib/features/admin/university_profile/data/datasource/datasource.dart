import 'dart:developer';

import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/profile_update_model.dart';
import '../../models/university_model.dart';
import '../../models/update_uni_specific_section_model.dart';

abstract class UniversityProfileDataSource{
  Future<Either<String,UniversityModel>> addUniversitySetup({required UniversityModel universityModel });
  Future<Either<String,String>> updateUniversitySetup({required UpdateUniSpecificSectionModel model });
  Future<Either<String,UniversityModel>> getUniversitySetup();
  Future<Either<String,String>> uploadProfile({required ProfileImageUpdateModel profileModel});
  Future<Either<String,String>> deleteUniversitySetup({required UpdateUniSpecificSectionModel model });
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


  // function
  @override
  Future<Either<String,String>> updateUniversitySetup({required UpdateUniSpecificSectionModel model })async{
    try{
      var response=await _dioHelper.put(AppApis.universityProfileSetupUpdate,data: model.toMap());
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        String message=data['message'] ??data['error'] ??"Data updated successfully";
        return Right(message);
      }
      return Left(
        data==null? "Failed":  data['message'] ??data['error'] ??
            "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }


  // function
  @override
  Future<Either<String,String>> deleteUniversitySetup({required UpdateUniSpecificSectionModel model })async{
    try{
      var response=await _dioHelper.delete("${AppApis.deleteUniversityProfileSetupUpdate}${model.deleteUrl()}",data: model.toMap());
      var data=response.data;
      if(response.statusCode! >=200 && response.statusCode! <=300){
        String message=data['message'] ??data['error'] ??"Data updated successfully";
        return Right(message);
      }
      return Left(
        data==null? "Failed":  data['message'] ??data['error'] ??
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
      MultipartFile imageFile;

      final fileName =
          "${profileModel.image.name}-${DateTime.now().millisecondsSinceEpoch}";

      if (kIsWeb) {
        imageFile = MultipartFile.fromBytes(
          await profileModel.image.readAsBytes(),
          filename: fileName,
        );
      } else {
        imageFile = await MultipartFile.fromFile(
          profileModel.image.path,
          filename: fileName,
        );
      }

      FormData formData = FormData.fromMap({
        "userId": profileModel.userId,
        "profileImage": imageFile,
      });
      var response=await _dioHelper.postWithFile(AppApis.profileImageUpdate,data: formData);
      var data=response.data;
      log("@#432: ${data}");
      if(response.statusCode! >=200 && response.statusCode! <=300){
        String url=data["imageUrl"]??"";
        return Right(url);
      }
      return Left(
        data==null? "Failed":  data['message'] ??data['error'] ??
            "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }



}