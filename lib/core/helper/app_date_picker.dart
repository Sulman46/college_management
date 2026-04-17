import 'package:flutter/material.dart';

import '../theme/AppColor.dart';

class AppDatePicker{


 static Future<DateTime?> pickCustomDate({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime lastDate,
    DateTime? firstDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1990),
      lastDate: lastDate,

      /// 🔥 THEME
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColor.primary,   // header + selected date
              onPrimary: AppColor.white,
              onSurface: AppColor.black,
            ), dialogTheme: DialogThemeData(backgroundColor: AppColor.white),
          ),
          child: child!,
        );
      },
    );

    return picked; // 👈 returns selected date or null
  }
}