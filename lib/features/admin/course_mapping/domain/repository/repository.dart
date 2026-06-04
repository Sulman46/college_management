import 'package:dartz/dartz.dart';

import '../../model/course_mapping_model.dart';

abstract class CourseMappingRepository{
  Future<Either<String,CourseMappingModel>> addMapping({required CourseMappingModel value});
  Future<Either<String,CourseMappingModel>> update({required CourseMappingModel value});
  Future<Either<String,bool>> delete({required CourseMappingModel value});
  Future<Either<String,List<CourseMappingModel>>> getMappingData();
}