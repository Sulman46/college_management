// ignore_for_file: must_be_immutable

import 'package:college_management/core/theme/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart' as animatedText;
import 'package:google_fonts/google_fonts.dart';


class AppText extends StatelessWidget {
   AppText(
      {super.key,
        required this.text,
         this.letterSpacing,
      this.color,
        this.fontSize,
        this.maxLines,
        this.decoration,
        this.style,
      this.fontStyle,
      this.fontWeight, this.overflow, this.textAlign, this.height});
  final String text;
 final double? height;
 final int? maxLines;
  final Color? color;
  TextStyle? style;
  final  TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
   double? letterSpacing;
   FontStyle? fontStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",overflow: overflow,
      textAlign:textAlign ,maxLines: maxLines,
      style:style?? GoogleFonts.inter(fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight??FontWeight.w600,
        decorationColor:AppColor.primary,
          decoration: decoration,
          color: color ?? AppColor.black,
          height:height ,
          fontSize: fontSize ?? 12,
          // fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
