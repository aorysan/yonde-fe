import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/app.dart';

void main() {
  testWidgets('YondeApp boots, renders AppShell, and toggles theme', (tester) async {
    await tester.pumpWidget(const YondeApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    // Verify initial boot has Learn active
    expect(find.text('Kotoba no Hana'), findsOneWidget);
    expect(find.byKey(const Key('theme_toggle_button')), findsOneWidget);

    // Toggle theme
    await tester.tap(find.byKey(const Key('theme_toggle_button')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    // Verify tab navigation exists
    expect(find.byKey(const Key('nav_item_1')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nav_item_1')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  });
}
