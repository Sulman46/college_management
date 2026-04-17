// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../widgets/app_text.dart';

class BadgeWidget extends StatelessWidget {
   BadgeWidget({super.key,required this.text,required this.color});
  String text; Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: AppText(
        text: text,
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
