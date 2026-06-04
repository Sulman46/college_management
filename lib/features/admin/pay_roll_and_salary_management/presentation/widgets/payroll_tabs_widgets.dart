import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';
import '../../../../../widgets/app_text.dart';

class PayrollTabsWidgets extends StatelessWidget {
  const PayrollTabsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.white.withOpacity(.9),
        boxShadow: AppColor.blackShadow,
      ),
      child: Row(
        children: [
          Expanded(child: _tabButton(text: "Active Billing", isSelected: true, onTap: () {},)),
          Expanded(child: _tabButton(text: "History & Paid", isSelected: false, onTap: () {},)),
        ],
      ),
    );
  }
}

Widget _tabButton({required String text,required bool isSelected,required VoidCallback? onTap}){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal:8,vertical: 8),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:isSelected? AppColor.primary:AppColor.transparent),
    child: AppText(text: text,fontSize: 12,color: isSelected?AppColor.white:AppColor.black,),
  );
}
