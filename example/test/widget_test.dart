import 'package:flutter_test/flutter_test.dart';

import 'package:handoff_example/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Handoff Plugin Example'), findsOneWidget);
    expect(find.text('Set Handoff URL'), findsOneWidget);
    expect(find.text('Clear Handoff'), findsOneWidget);
    expect(find.text('Navigate with Handoff Route'), findsOneWidget);
  });
}
