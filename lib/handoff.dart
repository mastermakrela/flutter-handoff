export 'handoff_platform_interface.dart';
export 'handoff_method_channel.dart';

import 'dart:async';
import 'package:flutter/services.dart';

class Handoff {
  static const MethodChannel _channel = MethodChannel(
    'com.mastermakrela.flutter-handoff',
  );

  /// Set a URL for handoff to browser on other devices
  static Future<void> setHandoffUrl(String url, {String? title}) async {
    // Validate URL scheme - must be http or https
    final uri = Uri.tryParse(url);
    if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
      throw Exception(
        'Invalid URL scheme. Only http and https URLs are supported for handoff.',
      );
    }

    try {
      await _channel.invokeMethod('setHandoffUrl', {
        'url': url,
        'title': title ?? 'Browse URL',
      });
    } on PlatformException catch (e) {
      throw Exception('Failed to set handoff URL: ${e.message}');
    }
  }

  /// Set a URI for handoff to browser on other devices
  static Future<void> setHandoffUri(Uri uri, {String? title}) async {
    // Validate URI scheme - must be http or https
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      throw Exception(
        'Invalid URI scheme. Only http and https URIs are supported for handoff.',
      );
    }

    try {
      await _channel.invokeMethod('setHandoffUrl', {
        'url': uri.toString(),
        'title': title ?? 'Browse URL',
      });
    } on PlatformException catch (e) {
      throw Exception('Failed to set handoff URI: ${e.message}');
    }
  }

  /// Clear current handoff activity
  static Future<void> clearHandoff() async {
    try {
      await _channel.invokeMethod('clearHandoff');
    } on PlatformException catch (e) {
      throw Exception('Failed to clear handoff: ${e.message}');
    }
  }
}
