import 'dart:developer';

import 'package:college_management/core/constants/app_apis.dart';
import 'package:college_management/core/controllers/dio_helper.dart';
import 'package:dartz/dartz.dart';

import '../../models/announcement_model.dart';

abstract class AnnouncementsDataSource{
  Future<Either<String,AnnouncementModel>> post({required AnnouncementModel value});
  Future<Either<String,AnnouncementModel>> update({required AnnouncementModel value});
  Future<Either<String,bool>> delete({required AnnouncementModel value});
  Future<Either<String,List<AnnouncementModel>>> get();
  
}


class FunctionClassAnnouncements extends AnnouncementsDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,AnnouncementModel>> post({required AnnouncementModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.announcement,data: value.toMap());
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        AnnouncementModel model=AnnouncementModel.fromMap(data['data']);

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
  Future<Either<String,AnnouncementModel>> update({required AnnouncementModel value})async{
    try{
      var response=await _dioHelper.put("${AppApis.announcement}/${value.id}",data: value.toMap());
      log("3223423: ${response.data}");
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        AnnouncementModel model=AnnouncementModel.fromMap(data);
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
  Future<Either<String,bool>> delete({required AnnouncementModel value})async{
    try{
      var response=await _dioHelper.delete("${AppApis.announcement}/${value.id}");
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
  Future<Either<String,List<AnnouncementModel>>> get()async{
    try{
      var response=await _dioHelper.get(AppApis.announcement);
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;
        if(data is List){
          List<AnnouncementModel> model=data.map((e)=>AnnouncementModel.fromMap(e)).toList();
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