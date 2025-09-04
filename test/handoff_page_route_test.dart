import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handoff/handoff.dart';

void main() {
  group('HandoffPageRoute', () {
    testWidgets('should create route with required parameters', (tester) async {
      final route = HandoffPageRoute<void>(
        handoffUrl: 'https://example.com',
        builder: (context) => const Scaffold(body: Text('Test')),
      );

      expect(route.handoffUrl, equals('https://example.com'));
      expect(route.handoffTitle, isNull);
    });

    testWidgets('should create route with title', (tester) async {
      final route = HandoffPageRoute<void>(
        handoffUrl: 'https://example.com',
        handoffTitle: 'Example Title',
        builder: (context) => const Scaffold(body: Text('Test')),
      );

      expect(route.handoffUrl, equals('https://example.com'));
      expect(route.handoffTitle, equals('Example Title'));
    });

    testWidgets('should create route with all MaterialPageRoute parameters', (tester) async {
      const settings = RouteSettings(name: '/test');
      final route = HandoffPageRoute<void>(
        handoffUrl: 'https://example.com',
        builder: (context) => const Scaffold(body: Text('Test')),
        settings: settings,
        maintainState: false,
        fullscreenDialog: true,
      );

      expect(route.settings, equals(settings));
      expect(route.maintainState, isFalse);
      expect(route.fullscreenDialog, isTrue);
    });

    testWidgets('should be a MaterialPageRoute', (tester) async {
      final route = HandoffPageRoute<void>(
        handoffUrl: 'https://example.com',
        builder: (context) => const Scaffold(body: Text('Test')),
      );

      expect(route, isA<MaterialPageRoute<void>>());
    });

    testWidgets('should support generic type parameter', (tester) async {
      final route = HandoffPageRoute<String>(
        handoffUrl: 'https://example.com',
        builder: (context) => const Scaffold(body: Text('Test')),
      );

      expect(route, isA<MaterialPageRoute<String>>());
    });
  });
}