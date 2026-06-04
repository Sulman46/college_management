import 'package:flutter/material.dart';

import '../core/app/myapp.dart';
import '../core/theme/AppColor.dart';

showLoadingDialog() {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
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
                    child: CircularProgressIndicator(color: AppColor.white))
              ],
            )]),
      ),
    ),
  );
}

void closeLoadingDialog() {
  if (navigatorKey.currentContext != null) {
    Navigator.of(navigatorKey.currentContext!).pop();
  }
}