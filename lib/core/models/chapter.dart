import 'lesson_node.dart';
import 'node_state.dart';

class Chapter {
  final int number;
  final String title;
  final List<LessonNode> nodes;

  const Chapter({
    required this.number,
    required this.title,
    required this.nodes,
  });

  int get completedCount =>
      nodes.where((n) => n.state == NodeState.completed).length;

  String get numeral {
    switch (number) {
      case 1:
        return 'I';
      case 2:
        return 'II';
      case 3:
        return 'III';
      case 4:
        return 'IV';
      case 5:
        return 'V';
      default:
        return number.toString();
    }
  }
}
