import 'dart:developer';

import 'package:college_management/core/app/myapp.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/controllers/screen_resizing/screen_resize_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenResizeCubit extends Cubit<ScreenResizeState>{
  ScreenResizeCubit():super(ScreenResizeInit());

  bool isLargeScreen=false;

  double screenWidth=600;

  void updateScreenSize(double width) {
    emit(ScreenResizeLoading());

    isLargeScreen = width > 1000;
    screenWidth=width;

    emit(ScreenResizeLoaded());
  }



}