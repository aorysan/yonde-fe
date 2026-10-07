import '../../../core/models/bloom_data.dart';
import '../../../core/models/keepsake_data.dart';

const dummyBloomData = BloomData(
  level: 14,
  title: 'Dreamweaver',
  titleKanji: '逐火',
  name: 'Elysia',
  subtitle: 'Studying Japanese',
  currentXp: 3420,
  nextLevelXp: 5000,
  streak: 7,
  xpDisplay: '3.4k',
  wordsMastered: 284,
  weeklyPetals: [4, 7, 5, 9, 6, 10, 3],
  highlightedDayIndex: 5, // Sabtu (sama dengan mockup)
  keepsakes: [
    KeepsakeData(
      kanji: '初',
      title: 'First Sortie',
      description: 'Clear your first lesson',
      unlocked: true,
    ),
    KeepsakeData(
      kanji: '仮',
      title: 'Kana Master',
      description: 'Learn all hiragana',
      unlocked: true,
    ),
    KeepsakeData(
      kanji: '連',
      title: '7-Day Front',
      description: 'Hold a 7-day streak',
      unlocked: true,
    ),
    KeepsakeData(
      kanji: null,
      title: 'Perfect Combo',
      description: '20 correct in a row',
      unlocked: false,
    ),
    KeepsakeData(
      kanji: null,
      title: 'S-Rank Op',
      description: 'Reach 5,000 XP',
      unlocked: false,
    ),
    KeepsakeData(
      kanji: null,
      title: 'Valkyrie',
      description: 'Complete Chapter I',
      unlocked: false,
    ),
  ],
);
