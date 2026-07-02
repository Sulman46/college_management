
import 'package:dartz/dartz.dart';
import '../../../coordinator_management/presentation/models/coordinator_register_model.dart';
import '../../../hod_assignment/models/hod_assign_model.dart';
import '../../../teacher_records/models/teacher_model.dart';
import '../../models/neural_generate_model.dart';
import '../../models/neural_user_management_model.dart';
import '../repository/repository.dart';

class NeuralGeneratorUseCase{
  final NeuralGeneratorRepository repository;
  NeuralGeneratorUseCase({required this.repository});

  Future<Either<String,String>> post({required NeuralGenerateModel value})async{
    return repository.post(value: value);
  }

  Future<Either<String,List<TeacherModel>>> getTeachers()async{
    return repository.getTeachers();
  }

  Future<Either<String,List<HodAssignModel>>> getHod()async{
    return repository.getHod();
  }

  Future<Either<String,List<CoordinatorRegisterModel>>> getCoordinator()async{
    return repository.getCoordinator();
  }

  Future<Either<String,List<NeuralUserManagementModel>>> getNeuralUserManagement()async{
    return repository.getNeuralUserManagement();
  }


  Future<Either<String,String>> statusPatchNeuralUserManagement({required NeuralUserManagementModel model})async{
    return repository.statusPatchNeuralUserManagement(model: model);
  }

  Future<Either<String,String>> keyPatchNeuralUserManagement({required NeuralUserManagementModel model})async{
    return repository.keyPatchNeuralUserManagement(model: model);
  }


}
