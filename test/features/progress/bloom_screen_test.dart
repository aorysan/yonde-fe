import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/models/keepsake_data.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/features/progress/presentation/bloom_screen.dart';
import 'package:yonde/features/progress/presentation/widgets/keepsake_grid.dart';
import 'package:yonde/features/progress/presentation/widgets/weekly_petal_chart.dart';

void main() {
  testWidgets(
    'BloomScreen renders AppHeader, BloomLevelCard, StatCards, Chart, and KeepsakeGrid',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const DawnPetal(),
            child: BloomScreen(onThemeToggle: () {}),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.text('Petal Diary'), findsOneWidget);
      expect(find.text('THIS WEEK'), findsOneWidget);
      expect(find.text('Keepsakes'), findsOneWidget);
      expect(find.text('3 / 6'), findsOneWidget);
      expect(find.text('First Sortie'), findsOneWidget);
      expect(find.text('Kana Master'), findsOneWidget);
    },
  );

  testWidgets(
    'BloomScreen triggers onThemeToggle callback when theme toggle button is tapped',
    (tester) async {
      var toggled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const DawnPetal(),
            child: BloomScreen(onThemeToggle: () {
              toggled = true;
            }),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1));

      final toggleButton = find.byKey(const Key('theme_toggle_button'));
      expect(toggleButton, findsOneWidget);
      await tester.tap(toggleButton);
      expect(toggled, isTrue);
    },
  );

  testWidgets(
    'BloomScreen renders in TwilightBloom dark theme without error',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const TwilightBloom(),
            child: BloomScreen(onThemeToggle: () {}),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.text('Petal Diary'), findsOneWidget);
      expect(find.text('Keepsakes'), findsOneWidget);
    },
  );

  testWidgets(
    'WeeklyPetalChart displays 7 day labels and highlights the specified day',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const DawnPetal(),
            child: const Scaffold(
              body: WeeklyPetalChart(
                dailyPetals: [4, 7, 5, 9, 6, 10, 3],
                highlightedDayIndex: 5,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Petal Diary'), findsOneWidget);
      expect(find.text('THIS WEEK'), findsOneWidget);
      // 'M', 'T', 'W', 'T', 'F', 'S', 'S'
      expect(find.text('M'), findsOneWidget);
      expect(find.text('T'), findsNWidgets(2));
      expect(find.text('W'), findsOneWidget);
      expect(find.text('F'), findsOneWidget);
      expect(find.text('S'), findsNWidgets(2));
    },
  );

  testWidgets(
    'KeepsakeGrid renders unlocked items with kanji and locked items with lock icons',
    (tester) async {
      const keepsakes = [
        KeepsakeData(
          kanji: '初',
          title: 'First Sortie',
          description: 'Clear your first lesson',
          unlocked: true,
        ),
        KeepsakeData(
          kanji: null,
          title: 'Locked Item',
          description: 'Not unlocked yet',
          unlocked: false,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const DawnPetal(),
            child: const Scaffold(
              body: KeepsakeGrid(keepsakes: keepsakes),
            ),
          ),
        ),
      );

      expect(find.text('Keepsakes'), findsOneWidget);
      expect(find.text('1 / 2'), findsOneWidget);
      expect(find.text('First Sortie'), findsOneWidget);
      expect(find.text('Clear your first lesson'), findsOneWidget);
      expect(find.text('初'), findsOneWidget);
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

      expect(find.text('Locked Item'), findsOneWidget);
      expect(find.text('Not unlocked yet'), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
    },
  );
}
