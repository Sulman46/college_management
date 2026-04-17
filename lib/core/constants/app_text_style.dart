import 'package:college_management/core/theme/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle{
  AppTextStyle._();

 static TextStyle hintTextStyle({double? fontSize}){
    return GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize: fontSize??14,color:AppColor.grey.withOpacity(.8),);
  }
 static TextStyle hintTextStyleWithFont({double? fontSize}){
    return  GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize: fontSize??14,);
  }


  static TextStyle fieldTextStyle(){
    return  GoogleFonts.inter(fontWeight: FontWeight.w500,color:AppColor.primary.withOpacity(.7),fontSize: 13);
  }
}