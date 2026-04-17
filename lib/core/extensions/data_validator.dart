import 'package:flutter/widgets.dart';

int validateInt(var data) {
  try {
    if (data != null && data is int) {
      return data;
    } else if (data is String) {
      return int.parse(data);
    } else if (data is double) {
      return data.toInt();
    }
  } catch (e) {
    return 0;
  }
  return 0;
}

String? validateString(var data) {
  try {
    if (data == null) {
      return null;
    }
    if (data is String) {
      return data;
    } else {
      return "$data";
    }
  } catch (e) {
    return "";
  }
}

double validateDouble(var data) {
  try {
    if (data != null && data is double) {
      return data;
    } else if (data is String) {
      return double.parse(data);
    } else if (data is int) {
      return data.toDouble();
    }
  } catch (e) {
    debugPrint("cap_log 383838_2 e: ${e.toString()}");
    return 0.00;
  }
  debugPrint("cap_log 383838_3 no condition matched");
  return 0.00;
}

bool validateBool(var data) {
  try {
    if (data != null && data is bool) {
      return data;
    } else if (data is String) {
      if (data == "true") {
        return true;
      } else {
        return false;
      }
    } else if (data is int) {
      if (data > 0) {
        return true;
      } else {
        return false;
      }
    }
  } catch (e) {
    return false;
  }
  return false;
}

final nameRegex = RegExp(r'^[a-zA-Z ]+$|^[\u0600-\u06FF ]+$|^[\u0980-\u09FF ]+$');

bool isValidName(String? name) {
  debugPrint("cap_log 477473 $name");
  var data = nameRegex.hasMatch(name ?? "");
  debugPrint("cap_log 477473 $data");
  return data;
}
