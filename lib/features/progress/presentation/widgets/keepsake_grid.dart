import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/models/keepsake_data.dart';
import '../../../../core/theme/app_colors.dart';

class KeepsakeGrid extends StatelessWidget {
  final List<KeepsakeData> keepsakes;

  const KeepsakeGrid({
    super.key,
    required this.keepsakes,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    final unlockedCount = keepsakes.where((k) => k.unlocked).length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Keepsakes',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: colors.foreground,
                ),
              ),
              Text(
                '$unlockedCount / ${keepsakes.length}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: colors.mutedForeground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 3-Column Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: keepsakes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.50,
            ),
            itemBuilder: (context, index) {
              final item = keepsakes[index];
              return _buildKeepsakeCard(context, item, colors);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKeepsakeCard(
    BuildContext context,
    KeepsakeData item,
    AppColorScheme colors,
  ) {
    return Opacity(
      opacity: item.unlocked ? 1.0 : 0.55,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: colors.card.withValues(alpha: 0.90),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: colors.border),
          boxShadow: item.unlocked
                  ? [
                      BoxShadow(
                        color: colors.accent.withValues(alpha: 0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 16,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 56dp Circular Emblem
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: item.unlocked
                        ? LinearGradient(
                            colors: [colors.primary, colors.accent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: item.unlocked ? null : colors.muted,
                    boxShadow: item.unlocked
                        ? [
                            BoxShadow(
                              color: colors.accent.withValues(alpha: 0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: item.unlocked
                      ? SizedBox(
                          width: 56,
                          height: 56,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Text(
                                  item.kanji ?? '',
                                  style: GoogleFonts.notoSerifJp(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: colors.primaryForeground,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Icon(
                                  Icons.favorite_rounded,
                                  size: 10,
                                  color: colors.accent,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Icon(
                          Icons.lock_outline_rounded,
                          size: 20,
                          color: colors.mutedForeground,
                        ),
                ),
                const SizedBox(height: 8),

                // Title
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.cardForeground,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                // Description
                Text(
                  item.description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: colors.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
    );
  }
}
