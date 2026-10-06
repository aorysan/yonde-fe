import 'keepsake_data.dart';

class BloomData {
  final int level;
  final String title;
  final String titleKanji;
  final String name;
  final String subtitle;
  final int currentXp;
  final int nextLevelXp;
  final int streak;
  final String xpDisplay;
  final int wordsMastered;
  final List<int> weeklyPetals;
  final int highlightedDayIndex;
  final List<KeepsakeData> keepsakes;

  const BloomData({
    required this.level,
    required this.title,
    required this.titleKanji,
    required this.name,
    required this.subtitle,
    required this.currentXp,
    required this.nextLevelXp,
    required this.streak,
    required this.xpDisplay,
    required this.wordsMastered,
    required this.weeklyPetals,
    required this.highlightedDayIndex,
    required this.keepsakes,
  });

  double get xpProgress => nextLevelXp == 0 ? 0.0 : currentXp / nextLevelXp;
}
