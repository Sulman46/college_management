
import 'package:dartz/dartz.dart';
import '../../models/program_model.dart';
import '../../models/program_request_model.dart';
import '../repository/repository.dart';

class AdminProgramsUseCase{
  final AdminProgramsRepository repository;
  AdminProgramsUseCase({required this.repository});

  
  Future<Either<String,List<ProgramModel>>> getPrograms() async{
    return repository.getPrograms();
  }

  
  Future<Either<String,String>> addProgram({required ProgramRequestModel programRequestModel}) async{
    return repository.addProgram(programRequestModel: programRequestModel);
  }



  Future<Either<String,String>> updateProgram({required ProgramRequestModel programRequestModel}) async{
    return repository.updateProgram(programRequestModel: programRequestModel);
  }


  Future<Either<String,String>> deleteProgram({required String id}) async{
    return repository.deleteProgram(id: id);
  }

}
