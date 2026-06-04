
import 'package:dartz/dartz.dart';
import '../../models/login_request_model.dart';
import '../../models/login_respons_model.dart';
import '../repository/repository.dart';

class AuthenticationUseCase{
  final AuthenticationRepository repository;
  AuthenticationUseCase({required this.repository});


  Future<Either<String, LoginResponseModel>> login({required LoginRequestModel request}) {
    return repository.login(request:request);
  }

}
