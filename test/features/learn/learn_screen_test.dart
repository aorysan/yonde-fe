import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/features/learn/presentation/learn_screen.dart';

void main() {
  testWidgets('LearnScreen renders AppHeader, ReverieHeroCard, and SCurvePath', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AppThemeScope(
          colorScheme: const DawnPetal(),
          child: LearnScreen(onThemeToggle: () {}),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1));

    expect(find.text("Today's Reverie · 今日"), findsOneWidget);
    expect(find.text('Shall we bloom together?'), findsOneWidget);
    expect(find.text('Begin ♡'), findsOneWidget);
    expect(find.text('Awakening Signals'), findsOneWidget);
  });
}