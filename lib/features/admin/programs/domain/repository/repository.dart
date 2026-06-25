import 'package:dartz/dartz.dart';

import '../../models/program_model.dart';
import '../../models/program_request_model.dart';

abstract class AdminProgramsRepository{
  Future<Either<String,String>> addProgram({required ProgramRequestModel programRequestModel});
  Future<Either<String,String>> updateProgram({required ProgramRequestModel programRequestModel});
  Future<Either<String,List<ProgramModel>>> getPrograms();
  Future<Either<String,String>> deleteProgram({required String id});
}