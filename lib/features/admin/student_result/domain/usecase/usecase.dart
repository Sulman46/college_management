
import 'package:dartz/dartz.dart';
import '../../model/filter_result_model.dart';
import '../../model/user_result_model.dart';
import '../repository/repository.dart';

class StudentResultUseCase{
  final StudentResultRepository repository;
  StudentResultUseCase({required this.repository});

  Future<Either<String,List<UserResultModel>>> get({required FilterResultModel model})async {
    return repository.get(model: model);
  }

}
