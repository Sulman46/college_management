
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/profile_update_model.dart';
import '../../models/university_model.dart';
import '../../models/update_uni_specific_section_model.dart';
import '../datasource/datasource.dart';

class UniversityProfileRepositoryImpl extends UniversityProfileRepository{
  final UniversityProfileDataSource dataSource;
  UniversityProfileRepositoryImpl({required this.dataSource});

  @override
  Future<Either<String,UniversityModel>> addUniversitySetup({required UniversityModel universityModel }){
    return dataSource.addUniversitySetup(universityModel: universityModel);
  }

  @override
  Future<Either<String,UniversityModel>> getUniversitySetup(){
    return dataSource.getUniversitySetup();
  }


  @override
  Future<Either<String,String>> uploadProfile({required ProfileImageUpdateModel profileModel}){
    return dataSource.uploadProfile(profileModel: profileModel);
  }


  @override
  Future<Either<String,String>> updateUniversitySetup({required UpdateUniSpecificSectionModel model }){
    return dataSource.updateUniversitySetup(model: model);
  }

  @override
  Future<Either<String,String>> deleteUniversitySetup({required UpdateUniSpecificSectionModel model }){
    return dataSource.deleteUniversitySetup(model: model);
  }


}