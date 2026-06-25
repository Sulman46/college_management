import 'package:dartz/dartz.dart';

import '../../model/course_mapping_model.dart';

abstract class CourseMappingRepository{
  Future<Either<String,String>> addMapping({required CourseMappingModel value});
  Future<Either<String,String>> update({required CourseMappingModel value});
  Future<Either<String,String>> delete({required CourseMappingModel value});
  Future<Either<String,List<CourseMappingModel>>> getMappingData();
}