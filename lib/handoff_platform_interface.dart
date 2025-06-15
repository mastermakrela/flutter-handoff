import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'handoff_method_channel.dart';

abstract class HandoffPlatform extends PlatformInterface {
  /// Constructs a HandoffPlatform.
  HandoffPlatform() : super(token: _token);

  static final Object _token = Object();

  static HandoffPlatform _instance = MethodChannelHandoff();

  /// The default instance of [HandoffPlatform] to use.
  ///
  /// Defaults to [MethodChannelHandoff].
  static HandoffPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HandoffPlatform] when
  /// they register themselves.
  static set instance(HandoffPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
