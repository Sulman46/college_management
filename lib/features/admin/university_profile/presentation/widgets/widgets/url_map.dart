import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UrlMap extends StatefulWidget {
  final String mapUrl;
String title;
   UrlMap({
    super.key,
    required this.mapUrl,
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
    location = extractLatLng(widget.mapUrl);
  }

  LatLng? extractLatLng(String url) {
    final latMatch =
    RegExp(r'!3d(-?\d+(?:\.\d+)?)').firstMatch(url);

    final lngMatch =
    RegExp(r'!4d(-?\d+(?:\.\d+)?)').firstMatch(url);

    if (latMatch != null && lngMatch != null) {
      return LatLng(
        double.parse(latMatch.group(1)!),
        double.parse(lngMatch.group(1)!),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (location == null) {
      return const Center(
        child: Text("Location not found"),
      );
    }

    return SizedBox(
      height: 250,
      child: GoogleMap(
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

