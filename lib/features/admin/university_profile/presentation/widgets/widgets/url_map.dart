import 'dart:developer';

import 'package:college_management/core/theme/AppColor.dart';
import 'package:college_management/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UrlMap extends StatefulWidget {
 double? latitude;
 double? longitude;
String title;
   UrlMap({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.title,
  });

  @override
  State<UrlMap> createState() => _UrlMapState();
}

class _UrlMapState extends State<UrlMap> {
  LatLng? location;

  @override
  void initState() {
    super.initState();

    location = LatLng(widget.latitude??0, widget.longitude??0);
    log("#2423 ${location}");
  }


  @override
  Widget build(BuildContext context) {
    if (location == null) {
      return  Center(
        child: AppText(text:"Location not found",color: AppColor.white,),
      );
    }

    return SizedBox(
      height: 250,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: CameraPosition(
          target: location!,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("campus"),
            position: location!,
            infoWindow:  InfoWindow(
              title: widget.title,
            ),
          ),
        },
      ),
    );
  }
}

