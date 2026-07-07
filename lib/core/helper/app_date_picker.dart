import 'dart:ui';

import 'package:college_management/core/constants/app_text_style.dart';
import 'package:flutter/material.dart';

import '../theme/AppColor.dart';

class AppDatePicker{
  static Future<DateTime?> pickCustomDate({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime lastDate,
    DateTime? firstDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1990),
      lastDate: lastDate,
      builder: (context, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4,sigmaY: 4),
          child: Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.copyWith(
                titleMedium: AppTextStyle.fieldTextStyle( ),
                bodyLarge: AppTextStyle.fieldTextStyle(),
                bodyMedium: AppTextStyle.fieldTextStyle(),
              ),
              dialogTheme: DialogThemeData(

                backgroundColor: AppColor.bgPrimary.withOpacity(.85),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: AppColor.primary.withOpacity(.5),
                    width: .5,
                  ),
                ),
              ),

              colorScheme: ColorScheme.dark(
                primary: AppColor.primary, // selected date & header
                onPrimary: AppColor.white,
                surface: AppColor.bgPrimary.withOpacity(.85),
                onSurface: AppColor.white,
              ),

              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.white,
                ),
              ),
              datePickerTheme: DatePickerThemeData(
                backgroundColor: AppColor.bgPrimary.withOpacity(.85),

                headerBackgroundColor: AppColor.primaryDark.withOpacity(.9),
                headerForegroundColor: AppColor.white,

                dayForegroundColor:
                WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColor.white;
                  }
                  return AppColor.greyLight;
                }),

                dayBackgroundColor:
                WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColor.primary;
                  }
                  return Colors.transparent;
                }),

                todayForegroundColor:
                WidgetStateProperty.all(AppColor.white),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: AppColor.primary.withOpacity(.5),
                    width: .5,
                  ),
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );
  }

  static Future<TimeOfDay?> timePicker(BuildContext context,{TimeOfDay? initialTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime??TimeOfDay.now(),
      builder: (context, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
          child: Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.copyWith(
                titleMedium: AppTextStyle.fieldTextStyle( ),
                bodyLarge: AppTextStyle.fieldTextStyle(),
                bodyMedium: AppTextStyle.fieldTextStyle(),
              ),
              dialogTheme: DialogThemeData(

                backgroundColor: AppColor.bgPrimary.withOpacity(.85),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: AppColor.primary.withOpacity(.5),
                    width: .5,
                  ),
                ),
              ),

              colorScheme: ColorScheme.dark(
                primary: AppColor.primary, // selected date & header
                onPrimary: AppColor.white,
                surface: AppColor.bgPrimary.withOpacity(.85),
                onSurface: AppColor.white,
              ),

              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.white,
                ),
              ),
              datePickerTheme: DatePickerThemeData(
                backgroundColor: AppColor.bgPrimary.withOpacity(.85),

                headerBackgroundColor: AppColor.primaryDark.withOpacity(.9),
                headerForegroundColor: AppColor.white,

                dayForegroundColor:
                WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColor.white;
                  }
                  return AppColor.greyLight;
                }),

                dayBackgroundColor:
                WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColor.primary;
                  }
                  return Colors.transparent;
                }),

                todayForegroundColor:
                WidgetStateProperty.all(AppColor.white),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: AppColor.primary.withOpacity(.5),
                    width: .5,
                  ),
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    return pickedTime;
  }





}


String formatDate(DateTime date) {
  return "${date.year.toString().padLeft(4, '0')}-"
      "${date.month.toString().padLeft(2, '0')}-"
      "${date.day.toString().padLeft(2, '0')}";
}
String formatDateMonthOnly(DateTime date) {
  return "${date.year.toString().padLeft(4, '0')}-"
      "${date.month.toString().padLeft(2, '0')}";
}