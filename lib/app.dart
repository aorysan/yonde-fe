import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/ambient_background.dart';
import 'core/widgets/app_header.dart';
import 'core/widgets/floating_nav_bar.dart';

class YondeApp extends StatefulWidget {
  const YondeApp({super.key});

  @override
  State<YondeApp> createState() => _YondeAppState();
}

class _YondeAppState extends State<YondeApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark;
    final colorScheme = isDark ? const TwilightBloom() : const DawnPetal();

    return AppThemeScope(
      colorScheme: colorScheme,
      child: MaterialApp(
        title: 'Kotoba no Hana',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: _themeMode,
        home: AppShell(onThemeToggle: _toggleTheme),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const AppShell({super.key, required this.onThemeToggle});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: AmbientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // In-Flow Tab Screens
              Expanded(
                child: IndexedStack(
                  index: _currentTab,
                  children: [
                    // Placeholder for Learn Screen (will be replaced in Part 2)
                    _buildPlaceholderScreen('Learn Screen', colors),
                    // Placeholder for Cards Screen (will be replaced in Part 2)
                    _buildPlaceholderScreen('Cards Screen', colors),
                    // Placeholder for Bloom Screen (will be replaced in Part 3)
                    _buildPlaceholderScreen('Bloom Screen', colors),
                  ],
                ),
              ),
              // In-Flow Navigation Bar
              FloatingNavBar(
                currentIndex: _currentTab,
                onTap: (index) {
                  setState(() {
                    _currentTab = index;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderScreen(String title, AppColorScheme colors) {
    return Column(
      children: [
        AppHeader(
          streak: 7,
          xpDisplay: '3.4k',
          onThemeToggle: widget.onThemeToggle,
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: colors.foreground, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
