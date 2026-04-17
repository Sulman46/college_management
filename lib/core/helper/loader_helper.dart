import 'dart:ui';

import 'package:flutter/material.dart';

import '../app/myapp.dart';
import '../theme/AppColor.dart';

class LoaderHelper{
static  showLoadingDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => PopScope(
        canPop: false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 4,sigmaX: 4),
          child: Dialog(
            backgroundColor: AppColor.black.withOpacity(.1),
            insetPadding: EdgeInsets.zero,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(color: AppColor.primary))
                  ],
                )]),
          ),
        ),
      ),
    );
  }

 static void closeDialog() {
    if (navigatorKey.currentContext != null) {
      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }
}