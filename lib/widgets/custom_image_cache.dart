// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/constants/app_assets.dart';
import '../core/theme/AppColor.dart';

class CustomImageCache extends StatelessWidget {
   CustomImageCache({super.key,required this.url,this.radius,this.height,this.width});
String url;
double? width;
double? height;
double? radius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius??500),
      child: Container(
        child: CachedNetworkImage(
          height: height??80,
          width: width??80,
          fit: BoxFit.cover,
          imageUrl:url,placeholder: (context, url) => ClipRRect(
          borderRadius: BorderRadius.circular(radius??500),
          child: Shimmer.fromColors(
            baseColor: AppColor.darkContainerShade.withOpacity(.5),
            highlightColor: AppColor.black,
            child: Container(
              height: height??80,
              width: width??80,
              color: AppColor.white, // You must give a background color
            ),
          ),
        ),errorWidget: (context, url, error) => ClipRRect(
          borderRadius: BorderRadius.circular(radius??500),
          child: Shimmer.fromColors(
            baseColor: AppColor.darkContainerShade.withOpacity(.5),
            highlightColor: AppColor.black,
            child: Container(
              height: height??80,
              width: width??80,
              color: AppColor.white, // You must give a background color
            ),
          ),
        ),),
      ),
    );
  }
}
