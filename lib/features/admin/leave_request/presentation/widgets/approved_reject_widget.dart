import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';


class ApprovedRejectWidget extends StatelessWidget {
  final LeaveRequestStatusEnum status;

  const ApprovedRejectWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case LeaveRequestStatusEnum.approved:
        borderColor = AppColor.green;
        bgColor = AppColor.green.withOpacity(.1);
        textColor = AppColor.green;
        text = "Approved";
        break;

      case LeaveRequestStatusEnum.reject:
        borderColor = AppColor.red;
        bgColor = AppColor.red.withOpacity(.1);
        textColor = AppColor.red;
        text = "Rejected";
        break;

      case LeaveRequestStatusEnum.pending:
        borderColor = Colors.orange;
        bgColor = Colors.orange.withOpacity(.1);
        textColor = Colors.orange;
        text = "Pending";
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: .5),
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: text,
        fontSize: 10,
        color: textColor,
      ),
    );
  }
}
enum LeaveRequestStatusEnum{
  reject, approved, pending
}
