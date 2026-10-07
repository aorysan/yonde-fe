import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class AppHeader extends StatefulWidget {
  final int streak;
  final String xpDisplay;
  final VoidCallback onThemeToggle;

  const AppHeader({
    super.key,
    required this.streak,
    required this.xpDisplay,
    required this.onThemeToggle,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _handleThemeToggle() {
    if (_rotationController.status == AnimationStatus.completed) {
      _rotationController.reverse();
    } else {
      _rotationController.forward();
    }
    widget.onThemeToggle();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    final isDark = colors is TwilightBloom;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Logo 40dp
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [colors.primary, colors.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.local_florist_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              // App Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kotoba no Hana',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: colors.foreground,
                      ),
                    ),
                    Text(
                      '言葉の花 · FLOWERS OF WORDS',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2.5,
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              // Theme Toggle Button
              GestureDetector(
                key: const Key('theme_toggle_button'),
                onTap: _handleThemeToggle,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.card.withValues(alpha: 0.7),
                    border: Border.all(color: colors.border),
                  ),
                  alignment: Alignment.center,
                  child: RotationTransition(
                    turns: _rotationController,
                    child: Icon(
                      isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      size: 18,
                      color: colors.accent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Status Chips: Streak & XP
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _buildChip(
                icon: Icons.local_fire_department_rounded,
                label: '${widget.streak}-day streak',
                colors: colors,
              ),
              _buildChip(
                icon: Icons.auto_awesome,
                label: '${widget.xpDisplay} XP',
                colors: colors,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required String label,
    required AppColorScheme colors,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.accent),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.secondaryForeground,
            ),
          ),
        ],
      ),
    );
  }
}
