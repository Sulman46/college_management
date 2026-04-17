import 'package:flutter/material.dart';

import 'AppColor.dart';

class ThemeChange{
  ThemeChange._();

 static ThemeData darkTheme(){
    return ThemeData(
      scaffoldBackgroundColor: AppColor.black,
    );
  }

 static ThemeData lightTheme(){
    return ThemeData(
      scaffoldBackgroundColor: AppColor.white,

    );
  }
}