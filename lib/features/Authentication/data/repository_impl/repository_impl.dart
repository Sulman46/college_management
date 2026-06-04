
import 'package:dartz/dartz.dart';

import '../../domain/repository/repository.dart';
import '../../models/login_request_model.dart';
import '../../models/login_respons_model.dart';
import '../datasource/datasource.dart';
class AuthenticationRepositoryImpl extends AuthenticationRepository{
  final AuthenticationDataSource dataSource;
  AuthenticationRepositoryImpl({required this.dataSource});


  @override
  Future<Either<String, LoginResponseModel>> login({required LoginRequestModel request}) {
    return dataSource.login(request:request);
  }

}