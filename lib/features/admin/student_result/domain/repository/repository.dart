import 'package:dartz/dartz.dart';

import '../../model/filter_result_model.dart';
import '../../model/user_result_model.dart';

abstract class StudentResultRepository{
  Future<Either<String,List<UserResultModel>>> get({required FilterResultModel model});
}