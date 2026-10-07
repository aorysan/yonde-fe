import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/features/flashcards/presentation/widgets/card_action_controls.dart';

void main() {
  testWidgets('CardActionControls triggers callbacks on button taps', (
    tester,
  ) async {
    var revisited = false;
    var flipped = false;
    var cherished = false;

    await tester.pumpWidget(
      MaterialApp(
        home: AppThemeScope(
          colorScheme: const DawnPetal(),
          child: Scaffold(
            body: CardActionControls(
              onRevisit: () => revisited = true,
              onFlip: () => flipped = true,
              onCherish: () => cherished = true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Flip'), findsOneWidget);
    expect(
      find.text('swipe right to cherish · left to revisit'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('btn_revisit')));
    expect(revisited, isTrue);

    await tester.tap(find.byKey(const Key('btn_flip')));
    expect(flipped, isTrue);

    await tester.tap(find.byKey(const Key('btn_cherish')));
    expect(cherished, isTrue);
  });
}
