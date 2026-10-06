import 'package:flutter/widgets.dart';

abstract class AppColorScheme {
  const AppColorScheme();

  Color get background;
  Color get foreground;
  Color get card;
  Color get cardForeground;
  Color get primary;
  Color get primaryForeground;
  Color get secondary;
  Color get secondaryForeground;
  Color get accent;
  Color get muted;
  Color get mutedForeground;
  Color get border;

  static AppColorScheme of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
    return scope?.colorScheme ?? const DawnPetal();
  }
}

class DawnPetal extends AppColorScheme {
  const DawnPetal();

  @override
  Color get background => const Color(0xFFFDF1F6);
  @override
  Color get foreground => const Color(0xFF4A0C22);
  @override
  Color get card => const Color(0xFFFFFFFF);
  @override
  Color get cardForeground => const Color(0xFF4A0C22);
  @override
  Color get primary => const Color(0xFFA53860);
  @override
  Color get primaryForeground => const Color(0xFFFFFFFF);
  @override
  Color get secondary => const Color(0xFFFCE0EC);
  @override
  Color get secondaryForeground => const Color(0xFFA53860);
  @override
  Color get accent => const Color(0xFFEE87AC);
  @override
  Color get muted => const Color(0xFFF8E6EE);
  @override
  Color get mutedForeground => const Color(0xFFB5738C);
  @override
  Color get border => const Color(0xFFF3DCE5);
}

class TwilightBloom extends AppColorScheme {
  const TwilightBloom();

  @override
  Color get background => const Color(0xFF2C0512);
  @override
  Color get foreground => const Color(0xFFFFE6EF);
  @override
  Color get card => const Color(0xFF45091E);
  @override
  Color get cardForeground => const Color(0xFFFFE6EF);
  @override
  Color get primary => const Color(0xFFEF88AD);
  @override
  Color get primaryForeground => const Color(0xFF2C0512);
  @override
  Color get secondary => const Color(0xFF5C1130);
  @override
  Color get secondaryForeground => const Color(0xFFFFD3E2);
  @override
  Color get accent => const Color(0xFFEF88AD);
  @override
  Color get muted => const Color(0xFF571029);
  @override
  Color get mutedForeground => const Color(0xFFE0A9BF);
  @override
  Color get border => const Color(0xFF421323);
}

class AppThemeScope extends InheritedWidget {
  final AppColorScheme colorScheme;

  const AppThemeScope({
    super.key,
    required this.colorScheme,
    required super.child,
  });

  @override
  bool updateShouldNotify(AppThemeScope oldWidget) {
    return colorScheme != oldWidget.colorScheme;
  }
}
