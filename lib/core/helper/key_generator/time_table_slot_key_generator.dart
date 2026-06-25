import 'package:flutter/material.dart';

String generateKeyForTimeSlot({required String day,required String time}){
  return "${day}-$time";
}


bool isTimeInSlot(String slotTime, TimeOfDay time) {
  final parts = slotTime.split('-');

  if (parts.length != 2) return false;

  final start = parts[0].split(':');
  final end = parts[1].split(':');

  final startMinutes =
      int.parse(start[0]) * 60 + int.parse(start[1]);

  final endMinutes =
      int.parse(end[0]) * 60 + int.parse(end[1]);

  final currentMinutes =
      time.hour * 60 + time.minute;

  return currentMinutes >= startMinutes &&
      currentMinutes <= endMinutes;
}


bool isToday(DateTime date, DateTime currentDate) {
  return date.year == currentDate.year &&
      date.month == currentDate.month &&
      date.day == currentDate.day;
}