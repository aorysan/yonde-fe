import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/app.dart';

void main() {
  testWidgets(
    'Full Integration Test: Tab switching, state preservation, and theme toggling',
    (tester) async {
      Future<void> pumpAndAdvance([int ms = 500]) async {
        await tester.pump();
        await tester.pump(Duration(milliseconds: ms));
      }

      await tester.pumpWidget(const YondeApp());
      await pumpAndAdvance();

      // 1. Tab 0: Learn Screen is initially visible
      expect(find.text("Today's Reverie · 今日"), findsOneWidget);
      expect(find.text('Awakening Signals'), findsOneWidget);

      // 2. Switch to Tab 1: Cards Screen
      await tester.tap(find.byKey(const Key('nav_item_1')));
      await pumpAndAdvance();
      expect(find.text('✦ Whispered Words · 単語'), findsOneWidget);
      expect(find.text('戦乙女'), findsOneWidget);

      // Flip card in Cards screen
      await tester.tap(find.text('戦乙女'));
      await pumpAndAdvance();
      expect(find.text('Valkyrie'), findsOneWidget);

      // 3. Switch to Tab 2: Bloom Screen
      await tester.tap(find.byKey(const Key('nav_item_2')));
      await pumpAndAdvance();
      expect(find.text('Petal Diary'), findsOneWidget);
      expect(find.text('Elysia'), findsOneWidget);
      expect(find.text('Keepsakes'), findsOneWidget);

      // 4. Switch back to Tab 1 (Cards): verify state preserved (card remains flipped)
      await tester.tap(find.byKey(const Key('nav_item_1')));
      await pumpAndAdvance();
      expect(find.text('Valkyrie'), findsOneWidget);

      // 5. Toggle theme to Dark Mode (Twilight Bloom)
      await tester.tap(find.byKey(const Key('theme_toggle_button')).first);
      await pumpAndAdvance();

      // Verify still stable in dark mode
      expect(find.text('Valkyrie'), findsOneWidget);
    },
  );
}
