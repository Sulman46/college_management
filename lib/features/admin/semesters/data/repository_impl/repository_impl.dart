
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/semester_levels_model.dart';
import '../datasource/datasource.dart';

class SemesterAdminRepositoryImpl extends SemesterAdminRepository{
  final SemesterAdminDataSource dataSource;
  SemesterAdminRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,SemesterLevelsModel>> addSemester({required SemesterLevelsModel semesterModel})async {
    return dataSource.addSemester(semesterModel: semesterModel);
  }

  @override
  Future<Either<String,SemesterLevelsModel>> updateSemester({required SemesterLevelsModel semesterModel})async {
    return dataSource.updateSemester(semesterModel: semesterModel);
  }

  @override
  Future<Either<String,bool>> deleteSemester({required SemesterLevelsModel semesterModel})async {
    return dataSource.deleteSemester(semesterModel: semesterModel);
  }

  @override
  Future<Either<String,List<SemesterLevelsModel>>> getSemester()async {
    return dataSource.getSemester();
  }

}