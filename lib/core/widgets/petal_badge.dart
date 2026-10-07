import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/node_state.dart';
import '../theme/app_colors.dart';

class PetalBadge extends StatelessWidget {
  final String kanji;
  final NodeState state;
  final double size;

  const PetalBadge({
    super.key,
    required this.kanji,
    required this.state,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);

    Color bgColor;
    Color textColor;
    BoxBorder? border;

    switch (state) {
      case NodeState.completed:
        bgColor = colors.secondary;
        textColor = colors.secondaryForeground;
        border = Border.all(
          color: colors.accent.withValues(alpha: 0.4),
          width: 2,
        );
        break;
      case NodeState.active:
        bgColor = colors.primary;
        textColor = colors.primaryForeground;
        break;
      case NodeState.locked:
        bgColor = colors.muted;
        textColor = colors.mutedForeground;
        break;
    }

    Widget badgeContent = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: border,
      ),
      alignment: Alignment.center,
      child: Text(
        kanji,
        style: GoogleFonts.zenMaruGothic(
          fontSize: size * 0.43,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
    );

    if (state == NodeState.active) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
                width: size + 16,
                height: size + 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.accent.withValues(alpha: 0.25),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.15, 1.15),
                duration: 2400.ms,
                curve: Curves.easeInOut,
              ),
          badgeContent,
        ],
      );
    }

    return badgeContent;
  }
}
