import 'dart:developer';

import 'package:college_management/core/app/myapp.dart';
import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/core/helper/share_pref/auth_sharepref_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:college_management/features/admin/home/presentation/page/admin_home_screen.dart';
import 'package:college_management/widgets/loader_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/usecase/usecase.dart';
import '../../models/login_request_model.dart';
import '../../models/login_respons_model.dart';
import '../../models/user_model.dart';
import 'state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationUseCase _useCase;
  AuthenticationCubit(this._useCase) : super(AuthenticationInit()){
    initFunction();
  }

  Future<void> initFunction()async{
      emit(AuthenticationLoading());
      userModel=await AuthShareprefHelper.getUser();
      emit(AuthenticationLoaded());
  }

  Future<void> logout()async{
      emit(AuthenticationLoading());
      userModel=null;
      await AuthShareprefHelper.removeToken();
      await AuthShareprefHelper.removeUser();
      emit(AuthenticationLoaded());
  }

  UserModel? userModel;
  String? token;

  String? selectedRole;

  Future<void> login(LoginRequestModel loginModel)async{
    showLoadingDialog();
    emit(AuthenticationLoading());
  var response= await _useCase.login(request: loginModel);
  if(response.isRight()){
    LoginResponseModel model=response.asRight();
    userModel=model.user;
    token=model.token;
    closeLoadingDialog();
    selectedRole=null;
    if(model.user.role==UserRole.admin){
      navigatorKey.currentContext!.pushReplacement('/Admin-dashboard');

    }else{
      // showMessage("New role ${model.user.role.toString()}");
      navigatorKey.currentContext!.pushReplacement('/Admin-dashboard');

    }
  }else{
    closeLoadingDialog();
    log("@#4324223: ${response.asLeft()} ${loginModel.toJson()}");
    showMessage(response.asLeft(),isError: true);
  }
    emit(AuthenticationLoaded());
  }

  void getUserRoleLoginScreen(String val){
    emit(AuthenticationLoading());
    selectedRole=val;
    emit(AuthenticationLoaded());
  }


}
