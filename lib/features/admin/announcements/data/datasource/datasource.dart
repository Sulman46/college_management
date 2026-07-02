import 'dart:developer';

import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:dartz/dartz.dart';

import '../../models/announcement_model.dart';

abstract class AnnouncementsDataSource{
  Future<Either<String,String>> post({required AnnouncementModel value});
  Future<Either<String,String>> update({required AnnouncementModel value});
  Future<Either<String,String>> delete({required AnnouncementModel value});
  Future<Either<String,List<AnnouncementModel>>> get();
  
}


class FunctionClassAnnouncements extends AnnouncementsDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required AnnouncementModel value})async{
    try{
      var val=await value.toMultipart();
      var response=await _dioHelper.postWithFile(AppApis.announcement,data: val);
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Announcement uploaded");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> update({required AnnouncementModel value})async{
    try{
      var val=await value.toMultipart();
      var response=await _dioHelper.putWithFile("${AppApis.announcement}/${value.id}",data:val);
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data Updated");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> delete({required AnnouncementModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.announcement}/${value.id}");
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["error"]??"Data Updated");
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,List<AnnouncementModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.announcement);
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        if(data is List){
          List<AnnouncementModel> model=data.map((e)=>AnnouncementModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data["message"]??data["error"]??"Failed");
        }
      }
      return Left(data["message"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }
}