import 'package:dartz/dartz.dart';

import '../../models/semester_levels_model.dart';

abstract class SemesterAdminRepository{
  Future<Either<String,String>> addSemester({required SemesterLevelsModel semesterModel});
  Future<Either<String,String>> updateSemester({required SemesterLevelsModel semesterModel});
  Future<Either<String,List<SemesterLevelsModel>>> getSemester();
  Future<Either<String,String>> deleteSemester({required SemesterLevelsModel semesterModel});
}