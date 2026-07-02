import 'package:dartz/dartz.dart';

import '../../models/freeze_request_model.dart';

abstract class FreezUnFreezRepository{
  Future<Either<String,List<FreezeRequestModel>>> getPen();
  Future<Either<String,List<FreezeRequestModel>>> getFinal();

  Future<Either<String,String>> update({required FreezeRequestModel value});
  Future<Either<String,String>> delete({required FreezeRequestModel value});
}