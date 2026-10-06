class KeepsakeData {
  final String? kanji;
  final String title;
  final String description;
  final bool unlocked;

  const KeepsakeData({
    this.kanji,
    required this.title,
    required this.description,
    required this.unlocked,
  });
}
