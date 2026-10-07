import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

class CardActionControls extends StatelessWidget {
  final VoidCallback onRevisit;
  final VoidCallback onFlip;
  final VoidCallback onCherish;

  const CardActionControls({
    super.key,
    required this.onRevisit,
    required this.onFlip,
    required this.onCherish,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              key: const Key('btn_revisit'),
              behavior: HitTestBehavior.opaque,
              onTap: onRevisit,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.card,
                  border: Border.all(color: colors.border),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.08),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.replay_rounded,
                  size: 24,
                  color: colors.mutedForeground,
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              key: const Key('btn_flip'),
              behavior: HitTestBehavior.opaque,
              onTap: onFlip,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: colors.border),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.08),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Text(
                  'Flip',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              key: const Key('btn_cherish'),
              behavior: HitTestBehavior.opaque,
              onTap: onCherish,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.3),
                      offset: const Offset(0, 6),
                      blurRadius: 16,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_rounded,
                  size: 24,
                  color: colors.primaryForeground,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'swipe right to cherish · left to revisit',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            color: colors.mutedForeground.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
