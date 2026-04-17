import 'package:flutter/material.dart';

import '../theme/AppColor.dart';

class DatePickerClass{
  DatePickerClass._();
 static DateTime firstDate = DateTime(1900);
 static DateTime initDate = DateTime.now();
 static DateTime lastDate = DateTime(3000);

  static Future<DateTime?> datePicker( BuildContext  context)async{
   DateTime? pickedDate=await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
              AppColor.black, // header background color
              onPrimary: AppColor.white, // selected date color
              onSurface: AppColor.black, // default text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                AppColor.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      firstDate: firstDate,
      initialDate: initDate,
      lastDate: lastDate,
    );
   return pickedDate;
  }
}