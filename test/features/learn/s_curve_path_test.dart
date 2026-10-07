import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/features/learn/data/learn_dummy_data.dart';
import 'package:yonde/features/learn/presentation/widgets/s_curve_path.dart';

void main() {
  testWidgets('SCurvePath renders chapter header and all 5 node tiles', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AppThemeScope(
          colorScheme: const DawnPetal(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: SCurvePath(chapter: dummyChapter),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1));

    // Chapter header elements
    expect(find.text('Chapter I'), findsOneWidget);
    expect(find.text('Awakening Signals'), findsOneWidget);
    expect(find.text('2 / 5 in bloom'), findsOneWidget);

    // Node items
    expect(find.text('Greetings'), findsOneWidget);
    expect(find.text('Self Intro'), findsOneWidget);
    expect(find.text('Numbers'), findsOneWidget);
    expect(find.text('Time & Days'), findsOneWidget);
    expect(find.text('Directions'), findsOneWidget);
  });
}
