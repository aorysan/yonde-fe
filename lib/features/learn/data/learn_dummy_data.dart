import '../../../core/models/chapter.dart';
import '../../../core/models/lesson_node.dart';
import '../../../core/models/node_state.dart';

const dummyChapter = Chapter(
  number: 1,
  title: 'Awakening Signals',
  nodes: [
    LessonNode(
      kanji: '挨',
      title: 'Greetings',
      reading: 'あいさつ',
      petalsEarned: 12,
      petalsTotal: 12,
      state: NodeState.completed,
    ),
    LessonNode(
      kanji: '自',
      title: 'Self Intro',
      reading: 'じこしょうかい',
      petalsEarned: 10,
      petalsTotal: 10,
      state: NodeState.completed,
    ),
    LessonNode(
      kanji: '数',
      title: 'Numbers',
      reading: 'すうじ',
      petalsEarned: 7,
      petalsTotal: 15,
      state: NodeState.active,
    ),
    LessonNode(
      kanji: '時',
      title: 'Time & Days',
      reading: 'じかん',
      petalsEarned: 0,
      petalsTotal: 14,
      state: NodeState.locked,
    ),
    LessonNode(
      kanji: '方',
      title: 'Directions',
      reading: 'ほうこう',
      petalsEarned: 0,
      petalsTotal: 12,
      state: NodeState.locked,
    ),
  ],
);

const dummyStreak = 7;
const dummyXpDisplay = '3.4k';
const dummyPetalsGathered = 2;
const dummyPetalsTotal = 3;
