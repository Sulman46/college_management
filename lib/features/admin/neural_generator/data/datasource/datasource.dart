import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../../../core/constants/app_apis.dart';
import '../../../../../core/controllers/dio_helper.dart';
import '../../models/neural_generate_model.dart';

abstract class NeuralGeneratorDataSource{
  Future<Either<String,String>> post({required NeuralGenerateModel value});
}


class FunctionClassNeuralGenerator extends NeuralGeneratorDataSource{

  final DioHelper _dioHelper=DioHelper();

  @override
  Future<Either<String,String>> post({required NeuralGenerateModel value})async{
    try{
      var response=await _dioHelper.post(AppApis.accessGenerate,data: value.toMap());
      if(response.statusCode! >= 200 && response.statusCode! <=300){
        log("3223423: ${response.data}");
        var data=response.data;

        return Right(data['msg']);
      }
      var data=response.data;
      return Left(data['message'] ?? "Failed",
      );
    }catch(e){
      return Left(e.toString());
    }
  }

}