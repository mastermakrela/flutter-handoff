export 'handoff_platform_interface.dart';
export 'handoff_method_channel.dart';

import 'dart:async';
import 'package:flutter/material.dart';
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

/// A [MaterialPageRoute] that automatically manages handoff URLs.
///
/// When the route is pushed onto the navigation stack, it will automatically
/// set the handoff URL. When the route is popped, it will clear the handoff.
class HandoffPageRoute<T> extends MaterialPageRoute<T> {
  /// The URL to set for handoff when this route is active.
  final String handoffUrl;
  
  /// Optional title for the handoff activity.
  final String? handoffTitle;

  /// Creates a [HandoffPageRoute] with the specified [handoffUrl] and [builder].
  HandoffPageRoute({
    required this.handoffUrl,
    this.handoffTitle,
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
    super.allowSnapshotting,
    super.barrierDismissible,
  });

  @override
  void didPush() {
    super.didPush();
    _setHandoffUrl();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _setHandoffUrl();
  }

  @override
  void didPop(T? result) {
    super.didPop(result);
    _clearHandoff();
  }

  @override
  void didReplace(Route<dynamic>? oldRoute) {
    super.didReplace(oldRoute);
    _setHandoffUrl();
  }

  void _setHandoffUrl() {
    // Don't await this to avoid blocking navigation
    Handoff.setHandoffUrl(handoffUrl, title: handoffTitle).catchError((error) {
      // Log error but don't throw to avoid disrupting navigation
      debugPrint('Failed to set handoff URL: $error');
    });
  }

  void _clearHandoff() {
    // Don't await this to avoid blocking navigation
    Handoff.clearHandoff().catchError((error) {
      // Log error but don't throw to avoid disrupting navigation
      debugPrint('Failed to clear handoff: $error');
    });
  }
}
