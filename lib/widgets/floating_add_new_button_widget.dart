import 'package:flutter/material.dart';

import 'custom_button.dart';

class FloatingAddNewButtonWidget extends StatelessWidget {
  const FloatingAddNewButtonWidget({super.key,required this.text,required this.onTap});
final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onTap,
      text: text,
      fontSize: 15,
      width: 110,
      height: 50,
    );
  }
}
