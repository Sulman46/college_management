import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateToStringHelper{
  static String dateMonthYearConvert(DateTime val) {
    return DateFormat('d MMM yyyy').format(val);
  }

  static String formatTime(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

}