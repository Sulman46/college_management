import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/features/admin/home/presentation/widgets/home_cards_widget.dart';
import 'package:college_management/features/admin/home/presentation/widgets/student_home_card_widget.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../freez_unfreez_admin/presentation/page/freeze_unfreeze_screen.dart';
import '../../../timetable_manager/presentation/page/timetable_manager_screen.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal:screenPaddingHori),
        child: Column(
          children: [
            StudentHomeCardWidget(),
            SizedBox(height: 10,),
            HomeCardsWidget(title: "Timetable Manager", icon:  Icons.calendar_month, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TimetableManagerScreen()),
              );
            },),
            SizedBox(height: 10,),
            HomeCardsWidget(title: "Freeze/Withdrawal", icon:  Icons.severe_cold, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FreezeUnfreezeScreen()),
              );
            },),
            SafeArea(child: SizedBox(height: 10,))

          ],
        ),
      ),
    );
  }
}
