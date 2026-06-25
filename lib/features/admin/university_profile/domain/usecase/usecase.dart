
import 'package:dartz/dartz.dart';
import '../../models/profile_update_model.dart';
import '../../models/university_model.dart';
import '../../models/update_uni_specific_section_model.dart';
import '../repository/repository.dart';

class UniversityProfileUseCase{
  final UniversityProfileRepository repository;
  UniversityProfileUseCase({required this.repository});


  Future<Either<String,UniversityModel>> addUniversitySetup({required UniversityModel universityModel }){
    return repository.addUniversitySetup(universityModel: universityModel);
  }

  Future<Either<String,UniversityModel>> getUniversitySetup(){
    return repository.getUniversitySetup();
  }

  Future<Either<String,String>> uploadProfile({required ProfileImageUpdateModel profileModel}){
    return repository.uploadProfile(profileModel: profileModel);
  }

  Future<Either<String,String>> updateUniversitySetup({required UpdateUniSpecificSectionModel model }){
    return repository.updateUniversitySetup(model: model);
  }
  Future<Either<String,String>> deleteUniversitySetup({required UpdateUniSpecificSectionModel model }){
    return repository.deleteUniversitySetup(model: model);
  }


}
