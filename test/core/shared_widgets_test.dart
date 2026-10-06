import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/models/node_state.dart';
import 'package:yonde/core/theme/app_colors.dart';
import 'package:yonde/core/widgets/petal_progress_bar.dart';
import 'package:yonde/core/widgets/petal_badge.dart';
import 'package:yonde/core/widgets/app_header.dart';
import 'package:yonde/core/widgets/floating_nav_bar.dart';

void main() {
  Widget testHarness(Widget child, [AppColorScheme scheme = const DawnPetal()]) {
    return MaterialApp(
      home: AppThemeScope(
        colorScheme: scheme,
        child: Scaffold(body: child),
      ),
    );
  }

  testWidgets('PetalProgressBar renders properly with clamp value', (tester) async {
    await tester.pumpWidget(testHarness(const PetalProgressBar(progress: 0.5, height: 6)));
    expect(find.byType(PetalProgressBar), findsOneWidget);
  });

  testWidgets('PetalBadge renders kanji in active and completed states', (tester) async {
    await tester.pumpWidget(testHarness(
      const PetalBadge(kanji: '挨', state: NodeState.active),
    ));
    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text('挨'), findsOneWidget);
  });

  testWidgets('AppHeader triggers onThemeToggle callback when tapped', (tester) async {
    var toggled = false;
    await tester.pumpWidget(testHarness(
      AppHeader(streak: 7, xpDisplay: '3.4k', onThemeToggle: () => toggled = true),
    ));

    expect(find.text('Kotoba no Hana'), findsOneWidget);
    expect(find.text('7-day streak'), findsOneWidget);
    expect(find.text('3.4k XP'), findsOneWidget);

    await tester.tap(find.byKey(const Key('theme_toggle_button')));
    expect(toggled, isTrue);
  });

  testWidgets('FloatingNavBar switches tabs and fires callback', (tester) async {
    var selectedTab = 0;
    await tester.pumpWidget(testHarness(
      FloatingNavBar(currentIndex: 0, onTap: (idx) => selectedTab = idx),
    ));

    expect(find.text('Learn'), findsOneWidget);
    await tester.tap(find.byKey(const Key('nav_item_1')));
    expect(selectedTab, 1);
  });
}
