import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

class ReverieHeroCard extends StatefulWidget {
  final int petalsGathered;
  final int petalsTotal;
  final VoidCallback onBegin;

  const ReverieHeroCard({
    super.key,
    required this.petalsGathered,
    required this.petalsTotal,
    required this.onBegin,
  });

  @override
  State<ReverieHeroCard> createState() => _ReverieHeroCardState();
}

class _ReverieHeroCardState extends State<ReverieHeroCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.card.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: colors.border),
              gradient: LinearGradient(
                colors: [
                  colors.accent.withValues(alpha: 0.20),
                  colors.secondary.withValues(alpha: 0.40),
                  colors.card.withValues(alpha: 0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Icon(
                      Icons.spa_rounded,
                      size: 48,
                      color: colors.accent,
                    ),
                  ),
                ),
                Positioned(
                  right: 28,
                  top: 28,
                  child: Opacity(
                    opacity: 0.3,
                    child: Icon(
                      Icons.spa_rounded,
                      size: 24,
                      color: colors.primary,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colors.card.withValues(alpha: 0.70),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 12,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Today's Reverie · 今日",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Shall we bloom together?',
                      style: TextStyle(
                        fontFamily: 'CormorantGaramond',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: colors.cardForeground,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Three little petals to gather before dusk — keep your streak in flower.',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: colors.mutedForeground,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ...List.generate(widget.petalsTotal, (index) {
                              final isFilled = index < widget.petalsGathered;
                              return Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Icon(
                                  isFilled
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  size: 16,
                                  color: isFilled
                                      ? colors.accent
                                      : colors.mutedForeground.withValues(
                                          alpha: 0.4,
                                        ),
                                ),
                              );
                            }),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.petalsGathered} of ${widget.petalsTotal}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: colors.mutedForeground,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTapDown: (_) => setState(() => _isPressed = true),
                          onTapUp: (_) {
                            setState(() => _isPressed = false);
                            widget.onBegin();
                          },
                          onTapCancel: () => setState(() => _isPressed = false),
                          child: AnimatedScale(
                            scale: _isPressed ? 0.95 : 1.0,
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.easeOut,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    offset: const Offset(0, 4),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Text(
                                'Begin ♡',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: colors.primaryForeground,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
