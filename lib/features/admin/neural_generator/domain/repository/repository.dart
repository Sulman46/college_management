import 'package:dartz/dartz.dart';

import '../../../coordinator_management/presentation/models/coordinator_register_model.dart';
import '../../../hod_assignment/models/hod_assign_model.dart';
import '../../../teacher_records/models/teacher_model.dart';
import '../../models/neural_generate_model.dart';
import '../../models/neural_user_management_model.dart';

abstract class NeuralGeneratorRepository{
  Future<Either<String,String>> post({required NeuralGenerateModel value});
  Future<Either<String,List<TeacherModel>>> getTeachers();
  Future<Either<String,List<HodAssignModel>>> getHod();
  Future<Either<String,List<CoordinatorRegisterModel>>> getCoordinator();

  Future<Either<String,List<NeuralUserManagementModel>>> getNeuralUserManagement();
  Future<Either<String,String>> statusPatchNeuralUserManagement({required NeuralUserManagementModel model});
  Future<Either<String,String>> keyPatchNeuralUserManagement({required NeuralUserManagementModel model});
}