class FlashcardData {
  final String kanji;
  final String reading;
  final String meaning;
  final String? exampleJp;
  final String? exampleEn;

  const FlashcardData({
    required this.kanji,
    required this.reading,
    required this.meaning,
    this.exampleJp,
    this.exampleEn,
  });
}
