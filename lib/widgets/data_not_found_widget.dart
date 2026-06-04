import 'package:flutter/material.dart';

import '../core/theme/AppColor.dart';
import 'app_text.dart';

class DataNotFoundWidget extends StatelessWidget {
   DataNotFoundWidget({super.key,required this.onTap});
VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: "Data not found",
            color: AppColor.grey,
          ),
          SizedBox(height: 10,),
          InkWell(
              onTap:onTap,
              child: Icon(Icons.refresh,size: 20,color: AppColor.primary,)),
        ],
      ),
    );
  }
}
