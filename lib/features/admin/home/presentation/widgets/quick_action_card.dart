import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class QuickActionModel {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  QuickActionModel({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.item,
  });

  final QuickActionModel item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: item.onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColor.primary.withOpacity(.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    item.icon,
                    color: AppColor.primary,
                    size: 26,
                  ),
                ),

                const SizedBox(height: 14),

                AppText(
                  text: item.title,
                  textAlign: TextAlign.center,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class QuickActionsWidget extends StatelessWidget {
  QuickActionsWidget({super.key});

  final List<QuickActionModel> actions = [

    QuickActionModel(
      title: "Students",
      icon: Icons.school,
    ),

    QuickActionModel(
      title: "Teachers",
      icon: Icons.groups,
    ),

    QuickActionModel(
      title: "Departments",
      icon: Icons.apartment,
    ),

    QuickActionModel(
      title: "Courses",
      icon: Icons.menu_book,
    ),

    QuickActionModel(
      title: "Attendance",
      icon: Icons.fact_check,
    ),

    QuickActionModel(
      title: "Marks",
      icon: Icons.analytics_outlined,
    ),

    QuickActionModel(
      title: "Timetable",
      icon: Icons.calendar_month,
    ),

    QuickActionModel(
      title: "Leave",
      icon: Icons.event_busy,
    ),

    QuickActionModel(
      title: "Reports",
      icon: Icons.bar_chart,
    ),

    QuickActionModel(
      title: "Notice",
      icon: Icons.campaign,
    ),

    QuickActionModel(
      title: "Requests",
      icon: Icons.description,
    ),

    QuickActionModel(
      title: "Settings",
      icon: Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: .9,
      ),
      itemBuilder: (_, index) {
        return QuickActionCard(
          item: actions[index],
        );
      },
    );
  }
}

