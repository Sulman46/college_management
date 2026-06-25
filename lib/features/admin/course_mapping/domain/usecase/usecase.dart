
import 'package:dartz/dartz.dart';
import '../../model/course_mapping_model.dart';
import '../repository/repository.dart';

class CourseMappingUseCase{
  final CourseMappingRepository repository;
  CourseMappingUseCase({required this.repository});

  Future<Either<String,String>> addMapping({required CourseMappingModel value})async {
    return repository.addMapping(value: value);
  }

  Future<Either<String,String>> update({required CourseMappingModel value}){
    return repository.update(value: value);
  }

  Future<Either<String,String>> delete({required CourseMappingModel value}){
    return repository.delete(value: value);
  }

  Future<Either<String,List<CourseMappingModel>>> getMappingData()async {
    return repository.getMappingData();
  }

}
