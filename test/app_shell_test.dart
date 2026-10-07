import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/app.dart';

void main() {
  testWidgets('YondeApp boots, renders AppShell, and toggles theme', (
    tester,
  ) async {
    await tester.pumpWidget(const YondeApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    // Verify initial boot has Learn active
    expect(find.text('Kotoba no Hana'), findsOneWidget);
    expect(find.byKey(const Key('theme_toggle_button')), findsOneWidget);
    expect(find.text("Today's Reverie · 今日"), findsOneWidget);
    expect(find.text('✦ Whispered Words · 単語'), findsNothing);
    expect(find.text('Petal Diary'), findsNothing);
    expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);

    // Toggle theme
    await tester.tap(find.byKey(const Key('theme_toggle_button')));
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pump(const Duration(milliseconds: 250));

    // Verify theme actually changed to dark (icon flipped to light-mode glyph)
    expect(find.byIcon(Icons.dark_mode_rounded), findsNothing);
    expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);

    // Verify tab navigation exists
    expect(find.byKey(const Key('nav_item_1')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nav_item_1')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify tab actually switched to Cards
    expect(find.text('✦ Whispered Words · 単語'), findsOneWidget);
    expect(find.text("Today's Reverie · 今日"), findsNothing);
  });
}
