import 'package:dartz/dartz.dart';

import '../../models/time_table_manger_model.dart';

abstract class TimetableManagerRepository{
  Future<Either<String,String>> post({required TimeTableManagerModel value});
  Future<Either<String,String>> update({required TimeTableManagerModel value});
  Future<Either<String,String>> delete({required TimeTableManagerModel value});
  Future<Either<String,List<TimeTableManagerModel>>> get();
}