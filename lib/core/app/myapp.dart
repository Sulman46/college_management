// ignore_for_file: must_be_immutable
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/app/router.dart';
import 'package:college_management/core/controllers/screen_resizing/screen_resize_cubit.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey= GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
   const MyApp({super.key,});
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
        builder: (context, constraints) {

          screenSizeCubit.updateScreenSize(constraints.maxWidth);
      // context.read<ScreenResizeCubit>()
      //     .updateScreenSize(constraints.maxWidth);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: AppColor.bgPrimary,brightness: Brightness.light,),
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerConfig: goRouter,
        );
      }
    );
  }
}

var screenSizeCubit=DiContainer().sl<ScreenResizeCubit>();
