import 'package:flutter/material.dart';

import '../../../../../core/constants/media_query.dart';
import '../widgets/admin_dashboard_drawar.dart';
import '../widgets/admin_home_top_bar.dart';
import '../widgets/home_cards_widget.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:AdminDashboardDrawar(),
      body: Column(
        children: [
          AdminHomeTopBar(),
          SizedBox(height: 13,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeCardsWidget(title: "Students",onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AllStudents(),));
              }, icon: Icons.groups_outlined,),
              HomeCardsWidget(onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent(),));
              },title: "Add Student", icon: Icons.girl),
            ],
          ),
          SizedBox(height: 13,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeCardsWidget(onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentScreen(),));
              },title: "Departments", icon: Icons.select_all,),
              HomeCardsWidget(onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => FeeSummary(),));
              },title: "Fee Summary", icon: Icons.insert_chart_outlined),
            ],
          ),
          SizedBox(height: 13,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeCardsWidget(onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ExamSections(),));
              },title: "Exams", icon: Icons.event_available,),
              SizedBox(width:  mdWidth(context)*.43,),
              // HomeCardsWidget(title: "Trainers", icon: Icons.groups_outlined),
            ],
          ),


        ],
      ),
    );
  }
}
