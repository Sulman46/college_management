import 'package:dartz/dartz.dart';

import '../../models/hod_assign_model.dart';

abstract class HODAssignmentRepository{
  Future<Either<String,String>> post({required HodAssignModel value});
  Future<Either<String,String>> update({required HodAssignModel value});
  Future<Either<String,String>> delete({required HodAssignModel value});
  Future<Either<String,List<HodAssignModel>>> get();
}