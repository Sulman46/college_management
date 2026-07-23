import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/app/di_container.dart';
import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';
import '../../models/dashboard_model.dart';
import '../controller/cubit.dart';

class OverviewSliderWidget extends StatefulWidget {
   OverviewSliderWidget({super.key,required this.dashboardWidget});
   DashboardModel? dashboardWidget;
  @override
  State<OverviewSliderWidget> createState() =>
      _OverviewSliderWidgetState();
}

class _OverviewSliderWidgetState
    extends State<OverviewSliderWidget> {

  late final PageController controller;

  Timer? timer;

  int page = 0;

  List<DashboardOverviewModel> items =[];


    List<List<DashboardOverviewModel>> pages=[];

  @override
  void initState() {
    super.initState();
    items = _buildItems();   // <-- Missing

    pages = [

      [items[0], items[1]],

      [items[2], items[3]],
    ];

    controller = PageController(viewportFraction: .95);

    timer = Timer.periodic(
      const Duration(seconds: 8),
          (_) {

        page++;

        if (page >= pages.length) {
          page = 0;
        }

        controller.animateToPage(
          page,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();    super.dispose();
  }


  @override
  void didUpdateWidget(covariant OverviewSliderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    items = _buildItems();
    pages = [
      [items[0], items[1]],
      [items[2], items[3]],
    ];
  }


  List<DashboardOverviewModel> _buildItems() {
    return [
      DashboardOverviewModel(
        title: "Teachers",
        value: "${widget.dashboardWidget?.totalTeacherLength ?? "-"}",
        icon: Icons.groups,
        color: Colors.blue,
      ),
      DashboardOverviewModel(
        title: "Students",
        value: "${widget.dashboardWidget?.totalStudent ?? "-"}",
        icon: Icons.school,
        color: Colors.green,
      ),
      DashboardOverviewModel(
        title: "Departments",
        value: "${widget.dashboardWidget?.totalDepartment ?? "-"}",
        icon: Icons.apartment,
        color: Colors.deepPurple,
      ),
      DashboardOverviewModel(
        title: "Leave Requests",
        value: "${widget.dashboardWidget?.totalLeaveRequest ?? "-"}",
        icon: Icons.event_busy,
        color: Colors.orange,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: controller,
            itemCount: pages.length,
            itemBuilder: (_, index) {

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Row(
                  children: [

                    DashboardStatCard(
                      item: pages[index][0],
                    ),

                    const SizedBox(width: 12),

                    DashboardStatCard(
                      item: pages[index][1],
                    ),

                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 14),

        SmoothPageIndicator(
          controller: controller,
          count: pages.length,
          effect: ExpandingDotsEffect(
            dotColor: AppColor.white.withOpacity(.5),
            activeDotColor: AppColor.primary,
            dotHeight: 8,
            dotWidth: 8,
            expansionFactor: 3,
          ),
        ),
      ],
    );
  }
}


class DashboardOverviewModel {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  DashboardOverviewModel({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({
    super.key,
    required this.item,
  });

  final DashboardOverviewModel item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              item.color,
              item.color.withOpacity(.82),
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.18),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                item.icon,
                color: Colors.white,
                size: 15,
              ),
            ),

            const Spacer(),

            AppText(
              text: item.value,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 3),

            AppText(
              text: item.title,
              color: Colors.white70,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}