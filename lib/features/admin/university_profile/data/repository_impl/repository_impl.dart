
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';
import '../../models/profile_update_model.dart';
import '../../models/university_model.dart';
import '../datasource/datasource.dart';

class UniversityProfileRepositoryImpl extends UniversityProfileRepository{
  final UniversityProfileDataSource dataSource;
  UniversityProfileRepositoryImpl({required this.dataSource});

  Future<Either<String,UniversityModel>> addUniversitySetup({required UniversityModel universityModel }){
    return dataSource.addUniversitySetup(universityModel: universityModel);
  }

  Future<Either<String,UniversityModel>> getUniversitySetup(){
    return dataSource.getUniversitySetup();
  }


  Future<Either<String,String>> uploadProfile({required ProfileImageUpdateModel profileModel}){
    return dataSource.uploadProfile(profileModel: profileModel);
  }


}