import 'package:flutter/material.dart';
import '../../../core/widgets/app_header.dart';
import '../data/bloom_dummy_data.dart';
import 'widgets/bloom_level_card.dart';
import 'widgets/keepsake_grid.dart';
import 'widgets/stat_card.dart';
import 'widgets/weekly_petal_chart.dart';

class BloomScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const BloomScreen({
    super.key,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Header
        AppHeader(
          streak: dummyBloomData.streak,
          xpDisplay: dummyBloomData.xpDisplay,
          onThemeToggle: onThemeToggle,
        ),

        // Scrollable Body
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bloom Level Card
                BloomLevelCard(
                  level: dummyBloomData.level,
                  title: dummyBloomData.title,
                  titleKanji: dummyBloomData.titleKanji,
                  name: dummyBloomData.name,
                  subtitle: dummyBloomData.subtitle,
                  currentXp: dummyBloomData.currentXp,
                  nextLevelXp: dummyBloomData.nextLevelXp,
                ),
                const SizedBox(height: 8),

                // 3x StatCard Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          decorator: const Icon(
                            Icons.local_fire_department_rounded,
                            size: 16,
                            color: Color(0xFFEE87AC),
                          ),
                          value: '${dummyBloomData.streak}',
                          label: 'STREAK',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          decorator: const Text(
                            '語',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFEE87AC),
                            ),
                          ),
                          value: '${dummyBloomData.wordsMastered}',
                          label: 'WORDS',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          decorator: const Icon(
                            Icons.auto_awesome,
                            size: 16,
                            color: Color(0xFFEE87AC),
                          ),
                          value: dummyBloomData.xpDisplay,
                          label: 'TOTAL XP',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Weekly Petal Chart
                WeeklyPetalChart(
                  dailyPetals: dummyBloomData.weeklyPetals,
                  highlightedDayIndex: dummyBloomData.highlightedDayIndex,
                ),
                const SizedBox(height: 8),

                // Keepsakes Grid
                KeepsakeGrid(
                  keepsakes: dummyBloomData.keepsakes,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
