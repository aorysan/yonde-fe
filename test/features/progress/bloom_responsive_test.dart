import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/core/theme/app_theme.dart';
import 'package:yonde/features/progress/presentation/bloom_screen.dart';

void main() {
  for (final w in [320.0, 360.0, 411.0]) {
    for (final ts in [1.0, 1.3, 1.6]) {
      testWidgets('BloomScreen responsive check w=$w ts=$ts', (tester) async {
        final errs = <String>[];
        final prev = FlutterError.onError;
        FlutterError.onError = (d) => errs.add(d.exceptionAsString());

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme(),
            home: AppThemeScope(
              colorScheme: const DawnPetal(),
              child: MediaQuery(
                data: MediaQueryData(textScaler: TextScaler.linear(ts)),
                child: Scaffold(
                  body: SizedBox(
                    width: w,
                    height: 900,
                    child: BloomScreen(onThemeToggle: () {}),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        FlutterError.onError = prev;

        expect(
          errs.where((e) => e.contains('overflowed')),
          isEmpty,
          reason: 'Overflows found at width=$w, textScale=$ts: $errs',
        );
      });
    }
  }
}