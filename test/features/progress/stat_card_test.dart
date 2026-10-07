import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/features/progress/data/bloom_dummy_data.dart';
import 'package:yonde/features/progress/presentation/widgets/stat_card.dart';

void main() {
  testWidgets('StatCard displays value, label, and decorator correctly', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AppThemeScope(
          colorScheme: const DawnPetal(),
          child: const Scaffold(
            body: StatCard(
              decorator: Icon(Icons.local_fire_department_rounded),
              value: '7',
              label: 'STREAK',
            ),
          ),
        ),
      ),
    );

    expect(find.text('7'), findsOneWidget);
    expect(find.text('STREAK'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('StatCard renders in TwilightBloom dark theme without error', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AppThemeScope(
          colorScheme: const TwilightBloom(),
          child: const Scaffold(
            body: StatCard(
              decorator: Icon(Icons.bolt_rounded),
              value: '3.4k',
              label: 'TOTAL XP',
            ),
          ),
        ),
      ),
    );

    expect(find.text('3.4k'), findsOneWidget);
    expect(find.text('TOTAL XP'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  test('dummyBloomData provides expected values and keepsakes', () {
    expect(dummyBloomData.level, 14);
    expect(dummyBloomData.title, 'Dreamweaver');
    expect(dummyBloomData.titleKanji, '逐火');
    expect(dummyBloomData.name, 'Elysia');
    expect(dummyBloomData.streak, 7);
    expect(dummyBloomData.xpDisplay, '3.4k');
    expect(dummyBloomData.wordsMastered, 284);
    expect(dummyBloomData.weeklyPetals.length, 7);
    expect(dummyBloomData.highlightedDayIndex, 5);
    expect(dummyBloomData.keepsakes.length, 6);
    expect(dummyBloomData.xpProgress, closeTo(3420 / 5000, 0.001));
  });
}
