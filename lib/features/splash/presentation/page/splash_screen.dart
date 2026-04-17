import 'dart:async';
import 'dart:developer';
import 'package:college_management/features/Authentication/presentation/page/login.dart';
import 'package:flutter/material.dart';
import 'package:college_management/widgets/app_text.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/media_query.dart';
import '../../../../core/theme/AppColor.dart';
import 'package:animated_text_kit/animated_text_kit.dart' as animatedText;


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Timer? timer;

  late AnimationController controllerArch;
  late Animation<double> animationArch;

  late AnimationController controller1;
  late Animation<double> animation1;

  int playCountArch = 0;
  int playCount1 = 0;
  bool showLoader = false;

  @override
  void initState() {
    super.initState();

    timer = Timer(Duration(seconds: 2), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

    });

    controllerArch = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animationArch = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: controllerArch,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    // Listen to animation status
    controllerArch.addStatusListener((statusArch) {
      if (statusArch == AnimationStatus.completed && playCountArch < 0) {
        log("986");
        playCountArch++;
        controllerArch.reset();
        controllerArch.forward();
      }
    });
    controllerArch.forward();
  }

  @override
  void dispose() {
    controllerArch.dispose();
    controller1.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgPrimary,
      body: Container(
        height: mdHeight(context),
        width: mdWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ScaleTransition(
                scale: animationArch,
                child: Container(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 17),
                      child:
                      Image.asset(AppAssets.appLogo,height: 120,fit: BoxFit.fitHeight,)
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                animatedText.AnimatedTextKit(
                  displayFullTextOnTap: true,
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    animatedText.TyperAnimatedText("Class",textAlign:TextAlign.start ,textStyle:  TextStyle(
                        fontSize: 13,color: AppColor.blue,
                        decorationColor:AppColor.primary,
                        fontWeight:FontWeight.w400
                    ),speed:Duration(milliseconds: 100) ),
                  ],
                ),
                animatedText.AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    animatedText.TyperAnimatedText(" Master",textAlign:TextAlign.start ,textStyle:  TextStyle(
                        fontSize: 13,color: AppColor.primary,
                        decorationColor:AppColor.primary,
                        fontWeight:FontWeight.w400
                    ),speed:Duration(milliseconds: 100) ),
                  ],
                ),

                ],
            )
          ],
        ),
      ),
    );
  }
}



