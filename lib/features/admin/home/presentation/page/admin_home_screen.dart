import 'dart:async';

import 'package:college_management/core/app/di_container.dart';
import 'package:college_management/core/enums/user_enums.dart';
import 'package:college_management/features/Authentication/presentation/controller/cubit.dart';
import 'package:college_management/features/admin/home/presentation/page/admin_home.dart';
import 'package:college_management/features/admin/home/presentation/page/student_home.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/media_query.dart';
import '../widgets/admin_dashboard_drawar.dart';
import '../widgets/admin_home_top_bar.dart';
import '../widgets/home_cards_widget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var _authCubit=DiContainer().sl<AuthenticationCubit>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(Duration(seconds: 2)).then((value)async {
        await _authCubit.statusCheck();
      },);
      _timer = Timer.periodic(const Duration(seconds: 30), (_) async {
        if (!mounted) return;
        await _authCubit.statusCheck();
      });
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:AdminDashboardDrawar(),
      body: Column(
        children: [
          AdminHomeTopBar(),
          SizedBox(height: 13,),
          if(_authCubit.userModel!.role==UserRole.student)
            StudentHome()
          else
    AdminHome()

        ],
      ),
    );
  }
}
