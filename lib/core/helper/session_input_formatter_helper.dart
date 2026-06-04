import 'package:flutter/services.dart';

class SessionInputFormatterHelper extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    String text = newValue.text;

    // remove everything except digits
    text = text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    // max 8 digits
    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    // auto add -
    if (text.length >= 4) {

      final firstYear =
      text.substring(0, 4);

      final secondYear =
      text.length > 4
          ? text.substring(4)
          : '';

      text = '$firstYear-$secondYear';
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: text.length,
      ),
    );
  }
}