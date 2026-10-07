import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/models/chapter.dart';
import '../../../../core/models/lesson_node.dart';
import '../../../../core/models/node_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/petal_badge.dart';
import '../../../../core/widgets/petal_progress_bar.dart';

class SCurvePath extends StatelessWidget {
  final Chapter chapter;
  final void Function(LessonNode node)? onNodeTap;

  const SCurvePath({
    super.key,
    required this.chapter,
    this.onNodeTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chapter ${chapter.numeral}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.2,
                  color: colors.accent,
                ),
              ),
              Text(
                '${chapter.completedCount} / ${chapter.nodes.length} in bloom',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: colors.mutedForeground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            chapter.title,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: colors.foreground,
            ),
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _DashedLinePainter(color: colors.border),
                ),
              ),
              Column(
                children: List.generate(chapter.nodes.length, (index) {
                  final node = chapter.nodes[index];
                  final isEven = index % 2 == 0;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: isEven
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: _buildNodeTile(context, node, colors),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNodeTile(
    BuildContext context,
    LessonNode node,
    AppColorScheme colors,
  ) {
    final isLocked = node.state == NodeState.locked;
    final isActive = node.state == NodeState.active;

    return FractionallySizedBox(
      widthFactor: 0.85,
      child: GestureDetector(
        onTap: () => onNodeTap?.call(node),
        child: Opacity(
          opacity: isLocked ? 0.55 : 1.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.card.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: colors.border),
                  boxShadow: [
                    BoxShadow(
                      color: (isActive ? colors.accent : colors.primary)
                          .withValues(alpha: 0.12),
                      offset: const Offset(0, 6),
                      blurRadius: 24,
                      spreadRadius: -12,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    PetalBadge(
                      kanji: node.kanji,
                      state: node.state,
                      size: 56,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  node.title,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: colors.cardForeground,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                node.reading,
                                style: GoogleFonts.zenMaruGothic(
                                  fontSize: 12,
                                  color: colors.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          PetalProgressBar(
                            progress: node.progress,
                            height: 6,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                size: 12,
                                color: colors.accent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${node.petalsEarned}/${node.petalsTotal} petals',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: colors.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusIcon(node.state, colors),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(NodeState state, AppColorScheme colors) {
    switch (state) {
      case NodeState.completed:
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.accent.withValues(alpha: 0.15),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.check_rounded, size: 18, color: colors.accent),
        );
      case NodeState.active:
        return Icon(
          Icons.auto_awesome,
          size: 20,
          color: colors.primary,
        );
      case NodeState.locked:
        return Icon(
          Icons.lock_outline_rounded,
          size: 16,
          color: colors.mutedForeground,
        );
    }
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;

  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const dashHeight = 6.0;
    const dashSpace = 6.0;
    final x = size.width / 2;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(x, startY),
        Offset(x, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) =>
      color != oldDelegate.color;
}
