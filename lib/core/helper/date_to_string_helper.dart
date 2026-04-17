import 'package:intl/intl.dart';

class DateToStringHelper{
  static String dateMonthYearConvert(DateTime val) {
    return DateFormat('d MMM yyyy').format(val);
  }

}