// ignore_for_file: must_be_immutable
import 'package:college_management/core/theme/AppColor.dart';
import 'package:flutter/material.dart';

import '../../features/splash/presentation/page/splash_screen.dart';


final GlobalKey<NavigatorState> navigatorKey= GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
   MyApp({super.key,});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColor.bgPrimary,brightness: Brightness.light,),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: '/',
      routes: {
        // 'appDashBoard':(context)=>AppDashboard(),
        '/':(context)=>const SplashScreen(),
      },
      // home: NeumorphicApp(
      //   theme: NeumorphicThemeData(
      //     baseColor: Color(0xFFFFFFFF),
      //     lightSource: LightSource.topLeft,
      //     depth: 10,
      //   ),
      //   darkTheme: NeumorphicThemeData(
      //     baseColor: Color(0xFF3E3E3E),
      //     lightSource: LightSource.topLeft,
      //     depth: 6,
      //   ),
      //
      // ),
    );
  }
}
