import 'dart:developer';

import 'package:college_management/core/extensions/dart_extensions.dart';
import 'package:college_management/features/admin/home/models/dashboard_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/usecase.dart';
import 'state.dart';

class AdminHomeCubit extends Cubit<AdminHomeState> {
  final AdminHomeUseCase _useCase;
  AdminHomeCubit(this._useCase) : super(AdminHomeInit());

  DashboardModel? dashboardModel;

  Future<void> get()async{
    emit(AdminHomeLoading());
    var res=await _useCase.get();

    if(res.isRight()){
      dashboardModel=res.asRight();
    }
    emit(AdminHomeLoaded());
  }

}
