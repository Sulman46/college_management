import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/constants/media_query.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

class StudentHomeCardWidget extends StatelessWidget {
  StudentHomeCardWidget({super.key});

  final _authCubit = DiContainer().sl<AuthenticationCubit>();

  @override
  Widget build(BuildContext context) {
    final user = _authCubit.userModel;

    return Container(
      width: mdWidth(context),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            AppColor.primary,
            AppColor.primary.withOpacity(.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.school,
                  color: AppColor.primary,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     AppText(
                      text: "Welcome Back 👋",
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      text: user?.name ?? "",
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _infoTile(
            Icons.account_balance,
            "Department",
            user?.studentDepartment ?? "-",
          ),

          const SizedBox(height: 10),

          _infoTile(
            Icons.menu_book,
            "Program",
            user?.programName ?? "-",
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _smallInfo(
                  Icons.class_,
                  "Section",
                  user?.section ?? "-",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _smallInfo(
                  Icons.calendar_today,
                  "Session",
                  user?.session ?? "-",
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _smallInfo(
                  Icons.confirmation_number,
                  "Roll No",
                  user?.rollNo ?? "-",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _smallInfo(
                  Icons.badge,
                  "SR No",
                  user?.srNo ?? "-",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: AppText(
              text: "$title: $value",
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallInfo(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 6),
          AppText(
            text: title,
            color: Colors.white70,
            fontSize: 11,
          ),
          const SizedBox(height: 2),
          AppText(
            text: value,
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}