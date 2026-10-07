import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/petal_progress_bar.dart';

class BloomLevelCard extends StatelessWidget {
  final int level;
  final String title;
  final String titleKanji;
  final String name;
  final String subtitle;
  final int currentXp;
  final int nextLevelXp;

  const BloomLevelCard({
    super.key,
    required this.level,
    required this.title,
    required this.titleKanji,
    required this.name,
    required this.subtitle,
    required this.currentXp,
    required this.nextLevelXp,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    final progress =
        (nextLevelXp == 0 ? 0.0 : currentXp / nextLevelXp).clamp(0.0, 1.0);

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
                  colors.secondary.withValues(alpha: 0.40),
                  colors.card.withValues(alpha: 0.85),
                  colors.accent.withValues(alpha: 0.15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Ornamen Sakura Kanan Atas dengan animasi lembut
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.spa_rounded,
                    size: 32,
                    color: colors.accent.withValues(alpha: 0.40),
                  )
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .moveY(begin: 0, end: -6, duration: 2000.ms, curve: Curves.easeInOut),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Tag Chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.card.withValues(alpha: 0.70),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome, size: 12, color: colors.primary),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '✦ $title · $titleKanji',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: colors.primary,
                              ).copyWith(fontFamilyFallback: const ['NotoSerifJP']),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Main Row: Gauge 144dp + Profile Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Circular Gauge 144x144dp
                        SizedBox(
                          width: 144,
                          height: 144,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(144, 144),
                                painter: _CircularGaugePainter(
                                  progress: progress,
                                  trackColor: colors.muted,
                                  primaryColor: colors.primary,
                                  accentColor: colors.accent,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$level',
                                    style: GoogleFonts.cormorantGaramond(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: colors.primary,
                                      height: 1.0,
                                    ),
                                  ),
                                  Text(
                                    'LEVEL',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      letterSpacing: 2.2,
                                      color: colors.mutedForeground,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Profile Info & XP
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  color: colors.cardForeground,
                                ),
                              ),
                              Text(
                                subtitle,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  color: colors.mutedForeground,
                                ),
                              ),
                              const SizedBox(height: 14),
                              PetalProgressBar(
                                progress: progress,
                                height: 8,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${_formatNumber(currentXp)} / ${_formatNumber(nextLevelXp)} XP to next bloom',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: colors.mutedForeground,
                                ),
                              ),
                            ],
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

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

class _CircularGaugePainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color primaryColor;
  final Color accentColor;

  _CircularGaugePainter({
    required this.progress,
    required this.trackColor,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 18) / 2;
    const strokeWidth = 9.0;

    // Track Paint
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress Arc Paint (Starting at 12 o'clock = -pi/2)
    final sweepAngle = (2 * math.pi) * progress.clamp(0.0, 1.0);
    final rect = Rect.fromCircle(center: center, radius: radius);

    final progressPaint = Paint()
      ..shader = SweepGradient(
        colors: [primaryColor, accentColor],
        startAngle: -math.pi / 2,
        endAngle: (3 * math.pi) / 2,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Glow Shadow & Progress Arc (only when progress > 0 to avoid zero-progress round cap dot)
    if (progress > 0) {
      final glowPaint = Paint()
        ..color = accentColor.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 4
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, glowPaint);
      canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(_CircularGaugePainter oldDelegate) =>
      progress != oldDelegate.progress ||
      trackColor != oldDelegate.trackColor ||
      primaryColor != oldDelegate.primaryColor ||
      accentColor != oldDelegate.accentColor;
}
