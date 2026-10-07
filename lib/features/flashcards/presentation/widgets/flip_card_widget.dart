import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/models/flashcard_data.dart';
import '../../../../core/theme/app_colors.dart';

class FlipCardWidget extends StatefulWidget {
  final FlashcardData card;
  final bool isFlipped;
  final VoidCallback onTap;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  const FlipCardWidget({
    super.key,
    required this.card,
    required this.isFlipped,
    required this.onTap,
    required this.onSwipeRight,
    required this.onSwipeLeft,
  });

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  late AnimationController _releaseController;
  late Animation<double> _releaseAnimation;
  late AnimationController _entryController;
  late Animation<double> _entryAnimation;
  double _dragOffsetX = 0.0;
  double _releaseStartOffsetX = 0.0;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );

    _releaseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _releaseAnimation = _releaseController.drive(
      CurveTween(curve: Curves.easeOut),
    )..addListener(_handleReleaseTick);

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _entryAnimation = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );

    if (widget.isFlipped) {
      _flipController.value = 1.0;
    }

    _entryController.forward();
  }

  @override
  void didUpdateWidget(FlipCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    }
    if (widget.card != oldWidget.card) {
      _entryController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    _releaseController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  void _handleHorizontalDragUpdate(DragUpdateDetails details) {
    _releaseController.stop();
    setState(() {
      _dragOffsetX += details.delta.dx;
    });
  }

  void _handleHorizontalDragEnd(DragEndDetails details) {
    if (_dragOffsetX > 100) {
      _snapToRest();
      widget.onSwipeRight();
      return;
    }
    if (_dragOffsetX < -100) {
      _snapToRest();
      widget.onSwipeLeft();
      return;
    }
    _animateBackToRest();
  }

  void _handleHorizontalDragCancel() {
    _animateBackToRest();
  }

  void _snapToRest() {
    _releaseController.stop();
    setState(() {
      _dragOffsetX = 0.0;
    });
  }

  void _animateBackToRest() {
    _releaseStartOffsetX = _dragOffsetX;
    _releaseController.forward(from: 0.0);
  }

  void _handleReleaseTick() {
    if (!mounted) {
      return;
    }
    setState(() {
      _dragOffsetX = _releaseStartOffsetX * (1 - _releaseAnimation.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    final dragProgress = (_dragOffsetX / 100).clamp(-1.0, 1.0);
    final rotationAngle = dragProgress * (15 * math.pi / 180);

    return SizedBox(
      height: 400,
      width: 330,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: const Offset(32, 32),
            child: Container(
              height: 380,
              width: 310,
              decoration: BoxDecoration(
                color: colors.card.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: colors.border),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(16, 16),
            child: Container(
              height: 390,
              width: 320,
              decoration: BoxDecoration(
                color: colors.card.withValues(alpha: 0.50),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: colors.border),
              ),
            ),
          ),
          FadeTransition(
            opacity: _entryAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.08),
                end: Offset.zero,
              ).animate(_entryAnimation),
              child: Transform.translate(
                offset: Offset(_dragOffsetX, 0),
                child: Transform.rotate(
                  angle: rotationAngle,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: widget.onTap,
                    onHorizontalDragUpdate: _handleHorizontalDragUpdate,
                    onHorizontalDragEnd: _handleHorizontalDragEnd,
                    onHorizontalDragCancel: _handleHorizontalDragCancel,
                    child: AnimatedBuilder(
                      animation: _flipAnimation,
                      builder: (context, child) {
                        final angle = _flipAnimation.value * math.pi;
                        final isUnder = angle > math.pi / 2;

                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(angle),
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(
                                height: 400,
                                width: 330,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: colors.card.withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(color: colors.border),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.accent.withValues(
                                        alpha: 0.2,
                                      ),
                                      offset: const Offset(0, 8),
                                      blurRadius: 24,
                                    ),
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      colors.accent.withValues(alpha: 0.10),
                                      Colors.transparent,
                                      colors.secondary.withValues(alpha: 0.40),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.spa_rounded,
                                        size: 28,
                                        color: colors.accent.withValues(
                                          alpha: 0.40,
                                        ),
                                      ),
                                    ),
                                    if (_dragOffsetX > 20)
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colors.accent.withValues(
                                              alpha: 0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Text(
                                            'Cherish ♡',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: colors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (_dragOffsetX < -20)
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colors.muted,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Text(
                                            'Revisit',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: colors.mutedForeground,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Center(
                                      child: isUnder
                                          ? Transform(
                                              transform: Matrix4.identity()
                                                ..rotateY(math.pi),
                                              alignment: Alignment.center,
                                              child: _buildBack(colors),
                                            )
                                          : _buildFront(colors),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFront(AppColorScheme colors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.card.kanji,
          style: GoogleFonts.notoSerifJp(
            fontSize: 96,
            fontWeight: FontWeight.w600,
            color: colors.cardForeground,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.card.reading,
          style: GoogleFonts.zenMaruGothic(
            fontSize: 18,
            letterSpacing: 5.4,
            color: colors.mutedForeground,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 12,
              color: colors.mutedForeground.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 4),
            Text(
              'TAP TO REVEAL',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                letterSpacing: 2.2,
                color: colors.mutedForeground.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBack(AppColorScheme colors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.card.meaning,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 48,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: colors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 40, height: 1, color: colors.accent),
            const SizedBox(width: 6),
            Icon(Icons.auto_awesome, size: 12, color: colors.accent),
          ],
        ),
        const SizedBox(height: 16),
        if (widget.card.exampleJp != null) ...[
          Text(
            widget.card.exampleJp!,
            style: GoogleFonts.notoSerifJp(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: colors.cardForeground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
        ],
        if (widget.card.exampleEn != null) ...[
          Text(
            widget.card.exampleEn!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: colors.mutedForeground,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
