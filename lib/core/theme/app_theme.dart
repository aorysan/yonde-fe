import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData lightTheme() {
    const colors = DawnPetal();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.card,
      textTheme: AppTypography.appTextTheme(colors),
      colorScheme: ColorScheme.light(
        surface: colors.card,
        primary: colors.primary,
        onPrimary: colors.primaryForeground,
        secondary: colors.secondary,
        onSecondary: colors.secondaryForeground,
      ),
    );
  }

  static ThemeData darkTheme() {
    const colors = TwilightBloom();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.card,
      textTheme: AppTypography.appTextTheme(colors),
      colorScheme: ColorScheme.dark(
        surface: colors.card,
        primary: colors.primary,
        onPrimary: colors.primaryForeground,
        secondary: colors.secondary,
        onSecondary: colors.secondaryForeground,
      ),
    );
  }
}
