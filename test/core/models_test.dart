// All six model libraries are imported to verify they compile together;
// FlashcardData/KeepsakeData are not referenced by any assertion below.
// ignore_for_file: unused_import
import 'package:flutter_test/flutter_test.dart';
import 'package:yonde/core/models/node_state.dart';
import 'package:yonde/core/models/lesson_node.dart';
import 'package:yonde/core/models/chapter.dart';
import 'package:yonde/core/models/flashcard_data.dart';
import 'package:yonde/core/models/keepsake_data.dart';
import 'package:yonde/core/models/bloom_data.dart';

void main() {
  group('Core Models Tests', () {
    test('LessonNode calculates progress correctly', () {
      const node1 = LessonNode(
        kanji: '挨',
        title: 'Greetings',
        reading: 'あいさつ',
        petalsEarned: 6,
        petalsTotal: 12,
        state: NodeState.active,
      );
      expect(node1.progress, 0.5);

      const nodeZero = LessonNode(
        kanji: '時',
        title: 'Time',
        reading: 'じかん',
        petalsEarned: 0,
        petalsTotal: 0,
        state: NodeState.locked,
      );
      expect(nodeZero.progress, 0.0);
    });

    test('Chapter computes numeral and completedCount correctly', () {
      const chapter = Chapter(
        number: 1,
        title: 'Awakening Signals',
        nodes: [
          LessonNode(kanji: '挨', title: 'N1', reading: 'r1', petalsEarned: 10, petalsTotal: 10, state: NodeState.completed),
          LessonNode(kanji: '自', title: 'N2', reading: 'r2', petalsEarned: 10, petalsTotal: 10, state: NodeState.completed),
          LessonNode(kanji: '数', title: 'N3', reading: 'r3', petalsEarned: 5, petalsTotal: 10, state: NodeState.active),
        ],
      );

      expect(chapter.numeral, 'I');
      expect(chapter.completedCount, 2);
    });

    test('BloomData calculates xpProgress correctly', () {
      const bloom = BloomData(
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
        highlightedDayIndex: 5,
        keepsakes: [],
      );

      expect(bloom.xpProgress, closeTo(3420 / 5000, 0.001));
    });
  });
}
