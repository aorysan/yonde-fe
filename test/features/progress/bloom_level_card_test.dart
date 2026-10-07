import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/core/widgets/petal_progress_bar.dart';
import 'package:yonde/features/progress/presentation/widgets/bloom_level_card.dart';

void main() {
  testWidgets(
    'BloomLevelCard displays user info, XP progress, and level number',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const DawnPetal(),
            child: const Scaffold(
              body: BloomLevelCard(
                level: 14,
                title: 'Dreamweaver',
                titleKanji: '逐火',
                name: 'Elysia',
                subtitle: 'Studying Japanese',
                currentXp: 3420,
                nextLevelXp: 5000,
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.text('14'), findsOneWidget);
      expect(find.text('LEVEL'), findsOneWidget);
      expect(find.text('Elysia'), findsOneWidget);
      expect(find.text('Studying Japanese'), findsOneWidget);
      expect(find.text('3,420 / 5,000 XP to next bloom'), findsOneWidget);
      expect(find.text('✦ Dreamweaver · 逐火'), findsOneWidget);
      expect(find.byType(PetalProgressBar), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    },
  );

  testWidgets(
    'BloomLevelCard renders in TwilightBloom dark theme without error',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const TwilightBloom(),
            child: const Scaffold(
              body: BloomLevelCard(
                level: 20,
                title: 'Herrscher of Human',
                titleKanji: '人之律者',
                name: 'Elysia',
                subtitle: 'Ego Bloom',
                currentXp: 4800,
                nextLevelXp: 5000,
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.text('20'), findsOneWidget);
      expect(find.text('LEVEL'), findsOneWidget);
      expect(find.text('✦ Herrscher of Human · 人之律者'), findsOneWidget);
      expect(find.text('4,800 / 5,000 XP to next bloom'), findsOneWidget);
    },
  );

  testWidgets(
    'BloomLevelCard handles 0 nextLevelXp gracefully without division by zero',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppThemeScope(
            colorScheme: const DawnPetal(),
            child: const Scaffold(
              body: BloomLevelCard(
                level: 1,
                title: 'Novice',
                titleKanji: '初心者',
                name: 'Mei',
                subtitle: 'Starting Out',
                currentXp: 0,
                nextLevelXp: 0,
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.text('1'), findsOneWidget);
      expect(find.text('0 / 0 XP to next bloom'), findsOneWidget);
    },
  );
}
