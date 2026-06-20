import 'package:flutter/material.dart';

import '../../../../../core/theme/AppColor.dart';

class SmallButtonsOnlyIcon extends StatelessWidget {
   SmallButtonsOnlyIcon({super.key,required this.icon,required this.onTap, this.onLongPress,required this.color});
IconData icon;
VoidCallback onTap;
VoidCallback? onLongPress;
Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:color.withOpacity(.2),
              border: Border.all(width: 1,color: color)
          ),
          child: Icon(icon,size: 18,color:color,)),
    );
  }
}
