import 'package:dartz/dartz.dart';

import '../../models/semester_levels_model.dart';

abstract class SemesterAdminRepository{
  Future<Either<String,SemesterLevelsModel>> addSemester({required SemesterLevelsModel semesterModel});
  Future<Either<String,SemesterLevelsModel>> updateSemester({required SemesterLevelsModel semesterModel});
  Future<Either<String,List<SemesterLevelsModel>>> getSemester();
  Future<Either<String,bool>> deleteSemester({required SemesterLevelsModel semesterModel});
}