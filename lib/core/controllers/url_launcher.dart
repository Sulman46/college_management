import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class WebUrlLauncher {
  // Function to open any URL in web browser
  static Future<void> launchInBrowser(String url) async {
    try {
      // Ensure the URL has proper scheme
      String formattedUrl = _formatUrl(url);

      final Uri uri = Uri.parse(formattedUrl);

      // Always launch in browser (external application)
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Opens in browser
      );

    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Failed to open URL: $e';
    }
  }

  // Helper function to format URL with proper scheme
  static String _formatUrl(String url) {
    // If URL doesn't start with http/https, add https://
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  // Function to open specific Pinterest pin in browser
  static Future<void> launchPinterestInBrowser(String pinId) async {
    final String url = 'https://www.pinterest.com/pin/$pinId/';
    await launchInBrowser(url);
  }
}