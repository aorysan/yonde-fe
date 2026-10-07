import 'package:flutter/material.dart';

import '../../../core/widgets/app_header.dart';
import '../data/learn_dummy_data.dart';
import 'widgets/reverie_hero_card.dart';
import 'widgets/s_curve_path.dart';

class LearnScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const LearnScreen({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeader(
          streak: dummyStreak,
          xpDisplay: dummyXpDisplay,
          onThemeToggle: onThemeToggle,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReverieHeroCard(
                  petalsGathered: dummyPetalsGathered,
                  petalsTotal: dummyPetalsTotal,
                  onBegin: () {
                    // No-op for current UI shell phase
                  },
                ),
                SCurvePath(
                  chapter: dummyChapter,
                  onNodeTap: (node) {
                    // No-op for current UI shell phase
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
