
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/program_model.dart';
import '../../models/program_request_model.dart';
import '../datasource/datasource.dart';

class AdminProgramsRepositoryImpl extends AdminProgramsRepository{
  final AdminProgramsDataSource dataSource;
  AdminProgramsRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,List<ProgramModel>>> getPrograms() async{
    return dataSource.getPrograms();
  }

  @override
  Future<Either<String,String>> addProgram({required ProgramRequestModel programRequestModel}) async{
    return dataSource.addProgram(programRequestModel: programRequestModel);
  }

  @override
  Future<Either<String,String>> updateProgram({required ProgramRequestModel programRequestModel}) async{
    return dataSource.updateProgram(programRequestModel: programRequestModel);
  }

  @override
  Future<Either<String,String>> deleteProgram({required String id}) async{
    return dataSource.deleteProgram(id: id);
  }

}