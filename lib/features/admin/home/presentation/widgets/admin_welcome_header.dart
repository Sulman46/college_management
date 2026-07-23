
import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  WelcomeHeaderWidget({super.key});

  final _authCubit = DiContainer().sl<AuthenticationCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.primary,
            AppColor.primary.withOpacity(.85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 AppText(
                  text: "Welcome Back 👋",
                  color: AppColor.whiteLight,
                  fontSize: 11,
                ),

                const SizedBox(height: 5),

                AppText(
                  text: _authCubit.userModel?.name ?? "-",
                  color: AppColor.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),

                const SizedBox(height: 4),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(.18),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child:  AppText(
                    text:_authCubit.userModel?.role.toJson()?? "-",
                    color: AppColor.white,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}