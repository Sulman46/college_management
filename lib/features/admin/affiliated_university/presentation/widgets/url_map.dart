import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/theme/AppColor.dart';

class UrlMap extends StatefulWidget {
  final String mapUrl;
  final double height;

  const UrlMap({
    super.key,
    required this.mapUrl,
    this.height = 200,
  });

  @override
  State<UrlMap> createState() => _UrlMapState();
}

class _UrlMapState extends State<UrlMap> {
  LatLng? latLng;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    resolveUrl();
  }

  Future<void> resolveUrl() async {
    try {
      final client = http.Client();

      final request = http.Request('GET', Uri.parse(widget.mapUrl));
      request.followRedirects = false;

      final response = await client.send(request);

      String? locationUrl;

      log("434343: ${response.headers}");
      if (response.isRedirect || response.statusCode == 302) {
        locationUrl = response.headers['location'];
      }

      /// If redirect found → use it
      if (locationUrl != null) {
        latLng = extractLatLng(locationUrl);
      }

      /// fallback
      latLng ??= extractLatLng(widget.mapUrl);

    } catch (e) {
      log("Error: $e");
      latLng = null;
    }

    setState(() {
      loading = false;
    });
  }

  LatLng? extractLatLng(String url) {
    try {
      final uri = Uri.parse(url);

      /// ✅ Case 1: ?q=lat,lng
      if (uri.queryParameters.containsKey('q')) {
        final coords = uri.queryParameters['q']!.split(',');
        return LatLng(
          double.parse(coords[0]),
          double.parse(coords[1]),
        );
      }

      /// ✅ Case 2: @lat,lng
      if (url.contains('@')) {
        final start = url.indexOf('@') + 1;
        final end = url.indexOf(',', start);
        final secondEnd = url.indexOf(',', end + 1);

        final lat = double.parse(url.substring(start, end));
        final lng = double.parse(url.substring(end + 1, secondEnd));

        return LatLng(lat, lng);
      }

      /// ✅ Case 3: !3dLAT!4dLNG  (YOUR CURRENT URL TYPE 🔥)
      final latMatch = RegExp(r'!3d(-?\d+\.?\d*)').firstMatch(url);
      final lngMatch = RegExp(r'!4d(-?\d+\.?\d*)').firstMatch(url);

      if (latMatch != null && lngMatch != null) {
        final lat = double.parse(latMatch.group(1)!);
        final lng = double.parse(lngMatch.group(1)!);

        return LatLng(lat, lng);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future openMap() async {
    final Uri uri = Uri.parse(widget.mapUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColor.grey.withOpacity(.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    /// ❌ Still no lat/lng
    if (latLng == null) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColor.grey.withOpacity(.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: openMap,
            child: Text("Open Location"),
          ),
        ),
      );
    }

    /// ✅ Show map
    return GestureDetector(
      onTap: openMap,
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: latLng!,
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate:
              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.college_management',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: latLng!,
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.location_on,
                    color: AppColor.red,
                    size: 35,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}