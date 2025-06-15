import 'package:flutter_test/flutter_test.dart';
import 'package:handoff/handoff_platform_interface.dart';
import 'package:handoff/handoff_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHandoffPlatform
    with MockPlatformInterfaceMixin
    implements HandoffPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HandoffPlatform initialPlatform = HandoffPlatform.instance;

  test('$MethodChannelHandoff is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHandoff>());
  });

  test('getPlatformVersion', () async {
    MockHandoffPlatform fakePlatform = MockHandoffPlatform();
    HandoffPlatform.instance = fakePlatform;

    expect(await fakePlatform.getPlatformVersion(), '42');
  });
}
