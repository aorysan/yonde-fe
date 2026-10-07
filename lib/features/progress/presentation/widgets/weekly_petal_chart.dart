import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class WeeklyPetalChart extends StatelessWidget {
  final List<int> dailyPetals;
  final int highlightedDayIndex;

  const WeeklyPetalChart({
    super.key,
    required this.dailyPetals,
    required this.highlightedDayIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final maxPetals = dailyPetals.isEmpty ? 1 : dailyPetals.reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.card.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Petal Diary',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: colors.cardForeground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'THIS WEEK',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        letterSpacing: 2.2,
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Chart Bars Area (Height: 128dp)
                SizedBox(
                  height: 128,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(7, (index) {
                      final val = index < dailyPetals.length ? dailyPetals[index] : 0;
                      final factor = (maxPetals == 0 || val == 0)
                          ? 0.0
                          : (val / maxPetals).clamp(0.1, 1.0);
                      final isHighlighted = index == highlightedDayIndex;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Vertical Bar
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: FractionallySizedBox(
                                    heightFactor: factor,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: isHighlighted
                                            ? LinearGradient(
                                                colors: [colors.primary, colors.accent],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              )
                                            : null,
                                        color: isHighlighted ? null : colors.accent.withValues(alpha: 0.40),
                                        boxShadow: isHighlighted
                                            ? [
                                                BoxShadow(
                                                  color: colors.accent.withValues(alpha: 0.3),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 10,
                                                ),
                                              ]
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Day Label
                              Text(
                                days[index],
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: colors.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
