// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:college_management/core/app/myapp.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityController {
  final Connectivity connectivity = Connectivity();

  bool _isFirstTime = true;

  Future<void> init() async {
    checkConnectivity();
  }

  Future<bool> get isConnectedCheck async {
    List<ConnectivityResult> result = await connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

   void checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      bool isNotConnected = result.contains(ConnectivityResult.none);
      if (_isFirstTime==true && isNotConnected==false) {
        _isFirstTime=false;
      } else {
        _isFirstTime=false;
        isNotConnected
            ? const SizedBox()
            : scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: isNotConnected ? AppColor.red : AppColor.primary,
            duration: Duration(seconds: isNotConnected ? 6000 : 3),
            content: Text(
              isNotConnected ? "No Connection" : "Connected",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    });
  }
}