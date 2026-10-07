import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/features/flashcards/presentation/flashcards_screen.dart';
import 'package:yonde/features/flashcards/presentation/widgets/flip_card_widget.dart';

void main() {
  Widget buildScreen() {
    return MaterialApp(
      home: AppThemeScope(
        colorScheme: const DawnPetal(),
        child: FlashcardsScreen(onThemeToggle: () {}),
      ),
    );
  }

  Future<TestGesture> startCardDrag(WidgetTester tester) {
    return tester.startGesture(tester.getCenter(find.byType(FlipCardWidget)));
  }

  Future<void> dragCardBy(WidgetTester tester, double dx) async {
    final gesture = await startCardDrag(tester);
    const step = 20.0;
    final steps = (dx.abs() / step).ceil();
    final delta = Offset(dx / steps, 0);
    for (var i = 0; i < steps; i++) {
      await gesture.moveBy(delta);
      await tester.pump();
    }
    await gesture.up();
  }

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

  testWidgets('swipe right past the threshold advances to the next card', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen());

    await dragCardBy(tester, 140);
    await tester.pumpAndSettle();

    expect(find.text('2 / 5'), findsOneWidget);
    expect(find.text('桜'), findsOneWidget);
    expect(find.text('1 / 5'), findsNothing);
  });

  testWidgets('swipe left past the threshold goes back and wraps around', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen());

    await dragCardBy(tester, -140);
    await tester.pumpAndSettle();

    expect(find.text('5 / 5'), findsOneWidget);
    expect(find.text('夢'), findsOneWidget);
  });

  testWidgets(
    'a threshold-crossing release hands over an at-rest incoming card',
    (tester) async {
      await tester.pumpWidget(buildScreen());

      final gesture = await startCardDrag(tester);
      for (var i = 0; i < 7; i++) {
        await gesture.moveBy(const Offset(20, 0));
        await tester.pump();
      }
      expect(find.text('Cherish ♡'), findsOneWidget);

      await gesture.up();
      await tester.pump();

      final slotCenter = tester.getCenter(find.byType(FlipCardWidget));
      final kanji = tester.getCenter(find.text('桜'));
      expect(
        (kanji.dx - slotCenter.dx).abs(),
        lessThan(4),
        reason: 'incoming card must render at rest, not at the drag offset',
      );
      expect(find.text('Cherish ♡'), findsNothing);
      expect(find.text('桜'), findsOneWidget);

      await tester.pumpAndSettle();
    },
  );

  testWidgets('drag under the threshold shows the Cherish chip and holds', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen());

    final gesture = await startCardDrag(tester);
    await gesture.moveBy(const Offset(20, 0));
    await tester.pump();
    await gesture.moveBy(const Offset(20, 0));
    await tester.pump();
    await gesture.moveBy(const Offset(20, 0));
    await tester.pump();

    expect(find.text('Cherish ♡'), findsOneWidget);

    await gesture.up();
    await tester.pumpAndSettle();

    expect(find.text('1 / 5'), findsOneWidget);
    expect(find.text('戦乙女'), findsOneWidget);
    expect(find.text('Cherish ♡'), findsNothing);
  });

  testWidgets('drag left under the threshold shows the Revisit chip', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen());

    final gesture = await startCardDrag(tester);
    await gesture.moveBy(const Offset(-20, 0));
    await tester.pump();
    await gesture.moveBy(const Offset(-20, 0));
    await tester.pump();
    await gesture.moveBy(const Offset(-20, 0));
    await tester.pump();

    expect(find.text('Revisit'), findsOneWidget);

    await gesture.up();
    await tester.pumpAndSettle();

    expect(find.text('1 / 5'), findsOneWidget);
    expect(find.text('Revisit'), findsNothing);
  });

  testWidgets('a card change resets the flip so the front face is showing', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen());

    await tester.tap(find.byKey(const Key('btn_flip')));
    await tester.pumpAndSettle();
    expect(find.text('Valkyrie'), findsOneWidget);

    await tester.tap(find.byKey(const Key('btn_cherish')));
    await tester.pumpAndSettle();

    expect(find.text('2 / 5'), findsOneWidget);
    expect(find.text('桜'), findsOneWidget);
    expect(find.text('Cherry Blossom'), findsNothing);
  });

  testWidgets('cherish advances and revisit goes back with wrap-around', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen());

    await tester.tap(find.byKey(const Key('btn_cherish')));
    await tester.pumpAndSettle();
    expect(find.text('2 / 5'), findsOneWidget);
    expect(find.text('桜'), findsOneWidget);

    await tester.tap(find.byKey(const Key('btn_cherish')));
    await tester.pumpAndSettle();
    expect(find.text('3 / 5'), findsOneWidget);
    expect(find.text('月'), findsOneWidget);

    await tester.tap(find.byKey(const Key('btn_revisit')));
    await tester.pumpAndSettle();
    expect(find.text('2 / 5'), findsOneWidget);
    expect(find.text('桜'), findsOneWidget);
  });

  testWidgets('revisit on the first card wraps to the last card', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen());

    await tester.tap(find.byKey(const Key('btn_revisit')));
    await tester.pumpAndSettle();

    expect(find.text('5 / 5'), findsOneWidget);
    expect(find.text('夢'), findsOneWidget);
    expect(find.text('4 / 5'), findsNothing);
  });
}
