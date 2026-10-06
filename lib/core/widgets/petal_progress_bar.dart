import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PetalProgressBar extends StatelessWidget {
  final double progress;
  final double height;

  const PetalProgressBar({
    super.key,
    required this.progress,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    final clampedProgress = progress.clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final fillWidth = totalWidth * clampedProgress;

        return Container(
          height: height,
          width: totalWidth,
          decoration: BoxDecoration(
            color: colors.muted,
            borderRadius: BorderRadius.circular(height),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            width: fillWidth,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height),
              gradient: LinearGradient(
                colors: [colors.primary, colors.accent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        );
      },
    );
  }
}
