
import 'dart:developer';

import 'package:college_management/core/helper/show_message.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/constants/app_apis.dart';
import '../../../../core/controllers/dio_helper.dart';
import '../../../../core/helper/share_pref/auth_sharepref_helper.dart';
import '../../models/login_request_model.dart';
import '../../models/login_respons_model.dart';


abstract class AuthenticationDataSource{
  Future<Either<String, LoginResponseModel>> login({required LoginRequestModel request});
}



class FunctionClassAuthentication extends AuthenticationDataSource {

  final DioHelper dioHelper = DioHelper();

  @override
  Future<Either<String, LoginResponseModel>> login({
    required LoginRequestModel request,
  }) async {
    try {

      final response = await dioHelper.post(AppApis.login,data:request.toJson() );

      final data = response.data;

      // SUCCESS
      if (response.statusCode! >= 200 &&
          response.statusCode! <= 300) {

        final model =
        LoginResponseModel.fromJson(data);

        await AuthShareprefHelper.saveUser(model.user);
        await AuthShareprefHelper.saveToken(model.token);
        log("3242423: ${model.token}");
        return Right(model);
      }
      // ERROR RESPONSE FROM SERVER
      return Left(
        data==null? "Login failed":  data['message'] ??
            "Login failed",
      );

    } catch (e) {
      return Left(e.toString());
    }
  }
}