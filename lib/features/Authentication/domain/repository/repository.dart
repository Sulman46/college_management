import 'package:dartz/dartz.dart';

import '../../models/login_request_model.dart';
import '../../models/login_respons_model.dart';

abstract class AuthenticationRepository{
  Future<Either<String, LoginResponseModel>> login({required LoginRequestModel request});
}