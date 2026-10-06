import 'node_state.dart';

class LessonNode {
  final String kanji;
  final String title;
  final String reading;
  final int petalsEarned;
  final int petalsTotal;
  final NodeState state;

  const LessonNode({
    required this.kanji,
    required this.title,
    required this.reading,
    required this.petalsEarned,
    required this.petalsTotal,
    required this.state,
  });

  double get progress => petalsTotal == 0 ? 0.0 : petalsEarned / petalsTotal;
}
