
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../model/course_mapping_model.dart';
import '../datasource/datasource.dart';

class CourseMappingRepositoryImpl extends CourseMappingRepository{
  final CourseMappingDataSource dataSource;
  CourseMappingRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,CourseMappingModel>> addMapping({required CourseMappingModel value}) {
    return dataSource.addMapping(value: value);
  }

  @override
  Future<Either<String,CourseMappingModel>> update({required CourseMappingModel value}){
    return dataSource.update(value: value);
  }

  @override
  Future<Either<String,bool>> delete({required CourseMappingModel value}){
    return dataSource.delete(value: value);
  }

  @override
  Future<Either<String,List<CourseMappingModel>>> getMappingData() {
    return dataSource.getMappingData();
  }

}