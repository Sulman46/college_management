import 'package:dartz/dartz.dart';

import '../../models/time_table_manger_model.dart';

abstract class TimetableManagerRepository{
  Future<Either<String,TimeTableManagerModel>> post({required TimeTableManagerModel value});
  Future<Either<String,TimeTableManagerModel>> update({required TimeTableManagerModel value});
  Future<Either<String,bool>> delete({required TimeTableManagerModel value});
  Future<Either<String,List<TimeTableManagerModel>>> get();
}