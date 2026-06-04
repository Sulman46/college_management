import 'package:dartz/dartz.dart';

import '../../../programs/models/program_model.dart';
import '../../../programs/models/program_request_model.dart';
import '../../models/profile_update_model.dart';
import '../../models/university_model.dart';

abstract class UniversityProfileRepository{
  Future<Either<String,UniversityModel>> addUniversitySetup({required UniversityModel universityModel });
  Future<Either<String,UniversityModel>> getUniversitySetup();
  Future<Either<String,String>> uploadProfile({required ProfileImageUpdateModel profileModel});
}