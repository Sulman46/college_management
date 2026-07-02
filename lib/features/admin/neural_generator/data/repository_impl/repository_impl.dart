
import 'package:dartz/dartz.dart';
import '../../../coordinator_management/presentation/models/coordinator_register_model.dart';
import '../../../hod_assignment/models/hod_assign_model.dart';
import '../../domain/repository/repository.dart';
import '../../models/neural_generate_model.dart';
import '../../models/neural_user_management_model.dart';
import '../datasource/datasource.dart';

import '../../../teacher_records/models/teacher_model.dart';
class NeuralGeneratorRepositoryImpl extends NeuralGeneratorRepository{
  final NeuralGeneratorDataSource dataSource;
  NeuralGeneratorRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String,String>> post({required NeuralGenerateModel value})async{
    return dataSource.post(value: value);
  }


  @override
  Future<Either<String,List<TeacherModel>>> getTeachers()async{
    return dataSource.getTeachers();
  }


  @override
  Future<Either<String,List<HodAssignModel>>> getHod()async{
    return dataSource.getHod();
  }

  @override
  Future<Either<String,List<CoordinatorRegisterModel>>> getCoordinator()async{
    return dataSource.getCoordinator();
  }

  @override
  Future<Either<String,List<NeuralUserManagementModel>>> getNeuralUserManagement()async{
    return dataSource.getNeuralUserManagement();
  }


  @override
  Future<Either<String,String>> statusPatchNeuralUserManagement({required NeuralUserManagementModel model})async{
    return dataSource.statusPatchNeuralUserManagement(model: model);
  }

  @override
  Future<Either<String,String>> keyPatchNeuralUserManagement({required NeuralUserManagementModel model})async{
    return dataSource.keyPatchNeuralUserManagement(model: model);
  }

}