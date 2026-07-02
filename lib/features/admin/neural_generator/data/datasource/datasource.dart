import 'dart:developer';
import 'package:college_management/features/admin/coordinator_management/presentation/models/coordinator_register_model.dart';
import 'package:college_management/features/admin/hod_assignment/models/hod_assign_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../../teacher_records/models/teacher_model.dart';
import '../../models/neural_generate_model.dart';
import '../../models/neural_user_management_model.dart';

abstract class NeuralGeneratorDataSource{
  Future<Either<String,String>> post({required NeuralGenerateModel value});
  Future<Either<String,List<TeacherModel>>> getTeachers();
  Future<Either<String,List<HodAssignModel>>> getHod();
  Future<Either<String,List<CoordinatorRegisterModel>>> getCoordinator();
  Future<Either<String,List<NeuralUserManagementModel>>> getNeuralUserManagement();
  Future<Either<String,String>> statusPatchNeuralUserManagement({required NeuralUserManagementModel model});
  Future<Either<String,String>> keyPatchNeuralUserManagement({required NeuralUserManagementModel model});
}


class FunctionClassNeuralGenerator extends NeuralGeneratorDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required NeuralGenerateModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.accessGenerate,data: value.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;

        return Right(data['message']??data['msg']??data['error'] ?? "Failed",);
      }
      return Left(data['message']??data['msg']??data['error'] ?? "Failed",);
    }catch(e){
      return Left(e.toString());
    }
  }



  @override
  Future<Either<String,List<TeacherModel>>> getTeachers()async{
    try{
      var response=await _dioHelper.get(AppApis.teachers);
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        if(data is List){
          List<TeacherModel> model=data.map((e)=>TeacherModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data["message"]??data["msg"]??data["error"]??"Failed");
        }
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,List<HodAssignModel>>> getHod()async{
    try{
      var response=await _dioHelper.get(AppApis.hodList);
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        if(data is List){
          List<HodAssignModel> model=data.map((e)=>HodAssignModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data["message"]??data["msg"]??data["error"]??"Failed");
        }
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");

    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,List<CoordinatorRegisterModel>>> getCoordinator()async{
    try{
      var response=await _dioHelper.get(AppApis.coordinatorManagement);
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        if(data is List){
          List<CoordinatorRegisterModel> model=data.map((e)=>CoordinatorRegisterModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data["message"]??data["msg"]??data["error"]??"Failed");

        }
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");

    }catch(e){
      return Left(e.toString());
    }
  }


  @override
  Future<Either<String,List<NeuralUserManagementModel>>> getNeuralUserManagement()async{
    try{
      var response=await _dioHelper.get(AppApis.userList);
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        if(data is List){
          List<NeuralUserManagementModel> model=data.map((e)=>NeuralUserManagementModel.fromMap(e)).toList();
          return Right(model);
        }else{
          return Left(data["message"]??data["msg"]??data["error"]??"Failed");

        }
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");

    }catch(e){
      return Left(e.toString());
    }
  }


  @override
  Future<Either<String,String>> statusPatchNeuralUserManagement({required NeuralUserManagementModel model})async{
    try{
      var response=await _dioHelper.patch("${AppApis.userListStatus}/${model.id}",data: model.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["msg"]??data["error"]??"Updated");
      }
      return Left(data["message"]??data["msg"]??data["error"]??"Failed");

    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> keyPatchNeuralUserManagement({required NeuralUserManagementModel model})async{
    try{
      var response=await _dioHelper.patch("${AppApis.userResetKey}/${model.id}",data: model.toMap());
      var data=response.data;
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        return Right(data["message"]??data["msg"]??data["error"]??"Updated");
      }
      return Left(data["message"]??data["error"]??data["msg"]??"Failed");

    }catch(e){
      return Left(e.toString());
    }
  }


}