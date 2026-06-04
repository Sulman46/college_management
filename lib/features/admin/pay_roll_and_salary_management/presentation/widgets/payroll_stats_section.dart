import 'dart:async';

import 'package:college_management/core/constants/app_widgets_size.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../faculty_workload/presentation/widgets/stat_card_widget.dart';

class PayrollStatsSection extends StatefulWidget {
  const PayrollStatsSection({super.key});

  @override
  State<PayrollStatsSection> createState() => _PayrollStatsSectionState();
}

class _PayrollStatsSectionState extends State<PayrollStatsSection> {
  final PageController _controller = PageController(
    viewportFraction: 0.33,
    initialPage: 1000, // start from middle
  );
  Timer? _timer;
  int _currentPage = 1000;@override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _currentPage++;

      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> stats = [
    {"title": "Net Payable", "value": "1"},
    {"title": "Total Lectures", "value": "0"},
    {"title": "Deduction", "value": "1"},
    {"title": "Teachers (Pend)", "value": "1"},
    {"title": "Teachers (Proc)", "value": "0"},
    {"title": "Courses", "value": "1"},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [



        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _controller,
            padEnds: false,
            itemCount: 2000,
            onPageChanged: (index) {
              _currentPage = index;
            },
            itemBuilder: (context, index) {
              final item = stats[index % stats.length];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: StatCardWidget(
                  title: item["title"],
                  value: item["value"],
                  color: AppColor.primary.withOpacity(.6),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}
