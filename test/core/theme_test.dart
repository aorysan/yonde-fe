// The theme and typography libraries are imported to verify they compile
// together; AppTheme/AppTypography are not referenced by any assertion below.
// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/core/theme/app_theme.dart';
import 'package:yonde/core/theme/app_typography.dart';

void main() {
  group('Theme System Tests', () {
    test('DawnPetal has correct hex values', () {
      const colors = DawnPetal();
      expect(colors.background, const Color(0xFFFDF1F6));
      expect(colors.foreground, const Color(0xFF4A0C22));
      expect(colors.primary, const Color(0xFFA53860));
      expect(colors.secondary, const Color(0xFFFCE0EC));
      expect(colors.accent, const Color(0xFFEE87AC));
      expect(colors.muted, const Color(0xFFF8E6EE));
      expect(colors.border, const Color(0xFFF3DCE5));
    });

    test('TwilightBloom has correct hex values', () {
      const colors = TwilightBloom();
      expect(colors.background, const Color(0xFF2C0512));
      expect(colors.foreground, const Color(0xFFFFE6EF));
      expect(colors.card, const Color(0xFF45091E));
      expect(colors.primary, const Color(0xFFEF88AD));
      expect(colors.secondary, const Color(0xFF5C1130));
      expect(colors.accent, const Color(0xFFEF88AD));
      expect(colors.muted, const Color(0xFF571029));
      expect(colors.border, const Color(0xFF421323));
    });

    testWidgets('AppThemeScope provides correct AppColorScheme down the tree', (tester) async {
      late AppColorScheme resolvedColors;

      await tester.pumpWidget(
        AppThemeScope(
          colorScheme: const TwilightBloom(),
          child: Builder(
            builder: (context) {
              resolvedColors = AppColorScheme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(resolvedColors, isA<TwilightBloom>());
      expect(resolvedColors.background, const Color(0xFF2C0512));
    });
  });
}
