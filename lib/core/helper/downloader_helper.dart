import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:universal_html/html.dart' as html;

class FileDownloader {
  static final Dio _dio = Dio();

  static Future<String?> download({
    required String url,
    required String fileName,
    Function(double progress)? onProgress,
  }) async {
    try {
      if (kIsWeb) {
        return _downloadWeb(url, fileName);
      }

      if (io.Platform.isAndroid) {
        return _downloadAndroid(
          url,
          fileName,
          onProgress,
        );
      }

      if (io.Platform.isIOS) {
        return _downloadIOS(
          url,
          fileName,
          onProgress,
        );
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // ================= WEB =================

  static Future<String?> _downloadWeb(
      String url,
      String fileName,
      ) async {
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();

    return "Browser Download Started";
  }

  // ================= ANDROID =================

  static Future<String?> _downloadAndroid(
      String url,
      String fileName,
      Function(double)? progress,
      ) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt < 33) {
      final permission = await Permission.storage.request();

      if (!permission.isGranted) {
        throw Exception("Storage permission denied");
      }
    }

    final dir = io.Directory("/storage/emulated/0/Download");

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final path = "${dir.path}/$fileName";

    await _dio.download(
      url,
      path,
      onReceiveProgress: (received, total) {
        if (total > 0 && progress != null) {
          progress(received / total);
        }
      },
    );

    return path;
  }

  // ================= IOS =================

  static Future<String?> _downloadIOS(
      String url,
      String fileName,
      Function(double)? progress,
      ) async {
    final dir = await getApplicationDocumentsDirectory();

    final path = "${dir.path}/$fileName";

    await _dio.download(
      url,
      path,
      onReceiveProgress: (received, total) {
        if (total > 0 && progress != null) {
          progress(received / total);
        }
      },
    );

    return path;
  }
}