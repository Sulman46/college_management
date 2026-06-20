
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class AppColor{
  AppColor._();

  // static  Color primary = HexColor("#972cb7");
  static  Color primary = HexColor("#6d28d9");
  static  Color primaryDark = HexColor("#4C1D95");
  static  Color secondaryColor =Colors.red;
  static Color bgPrimary=HexColor("#221246");
  static const Color black = Color(0xFF000000);
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color orange = Colors.orange;
  static const Color fieldGreyColor = Color(0xff292929);
  static  Color grey = HexColor('#817E77');
  static  Color greyLight = HexColor('#AEB0B3');
  static  Color greyLight1 = HexColor('#cccccc');
  static const Color red = Color(0xFFD63434);
  static const Color blueLight = Color(0xFF22d3ee);
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

 static LinearGradient drawerGradient= LinearGradient(
   begin: Alignment.centerLeft,
   end: Alignment.centerRight,
   colors: [
     AppColor.white.withOpacity(0.05),
     AppColor.primary.withOpacity(0.25),
     AppColor.primary.withOpacity(0.05),
   ],
 );

 static LinearGradient topBarGradient= LinearGradient(
   begin: Alignment.topCenter,
   end: Alignment.bottomCenter,
   colors: [
     AppColor.white.withOpacity(0.05),
     AppColor.primary.withOpacity(0.25),
     AppColor.primary.withOpacity(0.05),
   ],
 );

  static List<BoxShadow> shadowBlack = [

    // middle glow
    BoxShadow(
      color: AppColor.bgPrimary.withOpacity(0.18),
      blurRadius: 7,
      spreadRadius: .6,
    ),
    // strong core glow
    BoxShadow(
      color: AppColor.bgPrimary.withOpacity(0.3),
      blurRadius: 5,
      spreadRadius: 0.4,
    ),
    // white highlight (neon shine effect)
    BoxShadow(
      color: Colors.white.withOpacity(0.1),
      blurRadius: 3,
      spreadRadius: .1,
    ),
  ];




  static Decoration decorationDialog=BoxDecoration(
    color: bgPrimary.withOpacity(.8), // glass tint
    borderRadius: BorderRadius.circular(15),
    border: Border.all(
      color: primary.withOpacity(.5),
      width: .5,
    ),
    boxShadow: shadowBlack,
      // border: Border.all(width: 1,color: AppColor.primary.withOpacity(.5))
  );

  static Decoration containerNeon=BoxDecoration(
    color: bgPrimary.withOpacity(.8), // glass tint
    borderRadius: BorderRadius.circular(15),
    border: Border.all(
      color: primary.withOpacity(.5),
      width: .5,
    ),
    boxShadow: shadowBlack,
  );

  static Decoration containerDecoration=BoxDecoration(
    color: bgPrimary.withOpacity(.5), // glass tint
    borderRadius: BorderRadius.circular(15),
    border: Border.all(
      color: primary.withOpacity(.5),
      width: .5,
    ),
    boxShadow: shadowBlack,
  );


}


enum ThemeType{dark,light,red}