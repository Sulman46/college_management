
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class AppColor{
  AppColor._();

  // static  Color primary = HexColor("#972cb7");
  static  Color primary = HexColor("#db2e23");
  static  Color secondaryColor = HexColor("#2f1e73");
  static Color bgPrimary=whiteLight;
  static const Color black = Color(0xFF000000);
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color orange = Colors.orange;
  static const Color fieldGreyColor = Color(0xff292929);
  static  Color grey = HexColor('#817E77');
  static  Color greyLight = HexColor('#AEB0B3');
  static  Color greyLight1 = HexColor('#cccccc');
  static const Color red = Color(0xFFD63434);
  static Color whiteLight=HexColor("#F7F2EE");
  static Color fieldYellowBorder=Color(0xffebe3d8);
  static  Color blue = Color(0xFF007aff);
  static Color darkContainerShade=Color(0xff232333);
  static Color buttonColor=primary;
  static Color green=Colors.green;
  static Color teal=Colors.teal;
  static Color purple=Colors.purple;


 static LinearGradient logoContainerGradient=LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [
   Color(0xffd0e9fd),
   Color(0xffa4cffe),
 ]);

 static List<BoxShadow> blackShadow=[
   BoxShadow(color: AppColor.greyLight,blurRadius: 1,spreadRadius: .1,),
 ];


  static Decoration decorationDialog=BoxDecoration(
      color: AppColor.white.withOpacity(.6),
      borderRadius: BorderRadius.circular(15),
      // border: Border.all(width: 1,color: AppColor.primary.withOpacity(.5))
  );


}


enum ThemeType{dark,light,red}