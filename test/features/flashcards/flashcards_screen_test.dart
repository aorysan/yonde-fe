import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/features/flashcards/presentation/flashcards_screen.dart';

void main() {
  testWidgets(
    'FlashcardsScreen displays card, session header, and flips on tap',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const DawnPetal(),
            child: FlashcardsScreen(onThemeToggle: () {}),
          ),
        ),
      );

      expect(find.text('✦ Whispered Words · 単語'), findsOneWidget);
      expect(find.text('1 / 5'), findsOneWidget);
      expect(find.text('戦乙女'), findsOneWidget);

      // Tap to flip card
      await tester.tap(find.text('戦乙女'));
      await tester.pumpAndSettle();

      // Verify back side shows meaning
      expect(find.text('Valkyrie'), findsOneWidget);
      expect(find.text('彼女は戦乙女だ。'), findsOneWidget);
    },
  );
}
