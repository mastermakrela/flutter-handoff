import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'handoff_platform_interface.dart';

/// An implementation of [HandoffPlatform] that uses method channels.
class MethodChannelHandoff extends HandoffPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(
    'com.mastermakrela.flutter-handoff',
  );

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
