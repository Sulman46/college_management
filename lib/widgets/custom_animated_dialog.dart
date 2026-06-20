import 'dart:ui';

import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:flutter/material.dart';

import '../core/theme/AppColor.dart';

class CustomAnimatedDialog extends StatelessWidget {
  final Widget child;

  const CustomAnimatedDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 3,sigmaX: 3),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: screenPaddingHori),
        backgroundColor: AppColor.transparent,
        elevation: 0,
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0.8, end: 1),
          curve: Curves.decelerate,
          builder: (context, value, childWidget) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value.clamp(0.0, 1.0), // ✅ FIX
                child: childWidget,
              ),
            );
          },
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX:3,sigmaY: 3),
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.all(screenPaddingHori),
                decoration: AppColor.containerNeon,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}