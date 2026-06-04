
import 'package:dartz/dartz.dart';
import '../../models/semester_levels_model.dart';
import '../repository/repository.dart';

class SemesterAdminUseCase{
  final SemesterAdminRepository repository;
  SemesterAdminUseCase({required this.repository});

  Future<Either<String,SemesterLevelsModel>> addSemester({required SemesterLevelsModel semesterModel})async {
    return repository.addSemester(semesterModel: semesterModel);
  }

  Future<Either<String,SemesterLevelsModel>> updateSemester({required SemesterLevelsModel semesterModel})async {
    return repository.updateSemester(semesterModel: semesterModel);
  }

  Future<Either<String,List<SemesterLevelsModel>>> getSemester()async {
    return repository.getSemester();
  }

  Future<Either<String,bool>> deleteSemester({required SemesterLevelsModel semesterModel})async {
    return repository.deleteSemester(semesterModel: semesterModel);
  }

}
