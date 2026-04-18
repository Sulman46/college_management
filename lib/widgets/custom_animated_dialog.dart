import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:flutter/material.dart';

import '../core/theme/AppColor.dart';

class CustomAnimatedDialog extends StatelessWidget {
  final Widget child;

  const CustomAnimatedDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          padding: EdgeInsets.all(screenPaddingHori),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: child,
        ),
      ),
    );
  }
}