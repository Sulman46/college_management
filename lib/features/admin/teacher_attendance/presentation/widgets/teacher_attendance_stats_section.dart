import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../faculty_workload/presentation/widgets/stat_card_widget.dart';

class TeacherAttendanceStatsSection extends StatelessWidget {
  const TeacherAttendanceStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: StatCardWidget(title: "Total", color: AppColor.blue, value:"1")),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Present", color: AppColor.green, value:"1")),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Absent", color: AppColor.red, value:"1")),
        SizedBox(width: 10,),
        Expanded(child: StatCardWidget(title: "Late/Early", color: AppColor.purple, value:"1")),
      ],
    );
  }
}
