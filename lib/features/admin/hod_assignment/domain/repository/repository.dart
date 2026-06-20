import 'package:dartz/dartz.dart';

import '../../models/hod_assign_model.dart';

abstract class HODAssignmentRepository{
  Future<Either<String,HodAssignModel>> post({required HodAssignModel value});
  Future<Either<String,HodAssignModel>> update({required HodAssignModel value});
  Future<Either<String,bool>> delete({required HodAssignModel value});
  Future<Either<String,List<HodAssignModel>>> get();
}