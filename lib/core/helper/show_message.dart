
import 'package:flutter/material.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMessage(String text,{bool? isError,Color? color}){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: isError==true?2:1,
      backgroundColor:isError==true? color??AppColor.red:color??AppColor.primary,
      textColor: AppColor.white,
      fontSize: 12.0
  );
}