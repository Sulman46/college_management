import 'package:dartz/dartz.dart';

import '../../presentation/models/coordinator_register_model.dart';

abstract class CoordinatorManagementRepository{
  Future<Either<String,String>> post({required CoordinatorRegisterModel value});
  Future<Either<String,String>> update({required CoordinatorRegisterModel value});
  Future<Either<String,String>> delete({required CoordinatorRegisterModel value});
  Future<Either<String,List<CoordinatorRegisterModel>>> get();
}