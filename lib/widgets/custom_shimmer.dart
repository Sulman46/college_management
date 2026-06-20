// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/constants/media_query.dart';
import '../core/theme/AppColor.dart';

class CustomShimmer extends StatelessWidget {
   CustomShimmer({super.key, this.height,this.width,this.borderRadius});
double? width;
double? height;
double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius??20),
      child: Shimmer.fromColors(
        baseColor: AppColor.darkContainerShade.withOpacity(.5),
        highlightColor: AppColor.white,
        child: Container(
          height:height?? 150,
          width:width?? mdWidth(context) * 1,
          color: AppColor.white, // You must give a background color
        ),
      ),
    );
  }
}
