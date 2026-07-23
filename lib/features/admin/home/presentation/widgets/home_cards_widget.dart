// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class HomeCardsWidget extends StatelessWidget {
  HomeCardsWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        splashColor: AppColor.white.withOpacity(.08),
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.primary,
                  AppColor.primary.withOpacity(.88),
                  AppColor.primary.withOpacity(.75),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primary.withOpacity(.28),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -35,
                  right: -35,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.white.withOpacity(.08),
                    ),
                  ),
                ),

                Positioned(
                  bottom: -25,
                  left: -25,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.white.withOpacity(.05),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding:  EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColor.white.withOpacity(.18),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              icon,
                              color: AppColor.white,
                              size: 20,
                            ),
                          ),

                          const Spacer(),

                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.white.withOpacity(.15),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColor.white,
                              size: 15,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      AppText(
                        text: title,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                        maxLines: 2,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}