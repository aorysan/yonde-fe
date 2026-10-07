import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AmbientBackground extends StatefulWidget {
  final int petalCount;
  final Widget child;

  const AmbientBackground({
    super.key,
    this.petalCount = 8,
    required this.child,
  });

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_PetalParticle> _petals = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    for (int i = 0; i < widget.petalCount; i++) {
      _petals.add(
        _PetalParticle(
          x: _random.nextDouble(),
          delay: _random.nextDouble(),
          size: 10 + _random.nextDouble() * 11,
          durationFactor: 0.75 + _random.nextDouble() * 0.5,
          rotationSpeed: (_random.nextDouble() - 0.5) * 4,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);

    return Stack(
      children: [
        // Glow Blob Kiri Atas
        Positioned(
          left: -64,
          top: -64,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
            child: Container(
              width: 224,
              height: 224,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.accent.withValues(alpha: 0.20),
              ),
            ),
          ),
        ),

        // Glow Blob Kanan Bawah
        Positioned(
          right: -64,
          bottom: -64,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
            child: Container(
              width: 224,
              height: 224,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primary.withValues(alpha: 0.20),
              ),
            ),
          ),
        ),

        // Kelopak Sakura Jatuh
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                size: Size.infinite,
                painter: _PetalsPainter(
                  petals: _petals,
                  progress: _controller.value,
                  color: colors.accent.withValues(alpha: 0.40),
                ),
              );
            },
          ),
        ),

        // Konten Layar
        widget.child,
      ],
    );
  }
}

class _PetalParticle {
  final double x;
  final double delay;
  final double size;
  final double durationFactor;
  final double rotationSpeed;

  _PetalParticle({
    required this.x,
    required this.delay,
    required this.size,
    required this.durationFactor,
    required this.rotationSpeed,
  });
}

class _PetalsPainter extends CustomPainter {
  final List<_PetalParticle> petals;
  final double progress;
  final Color color;

  _PetalsPainter({
    required this.petals,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (final petal in petals) {
      final adjustedProgress =
          ((progress / petal.durationFactor) + petal.delay) % 1.0;
      final y = adjustedProgress * (size.height + 40) - 20;
      final sway = math.sin(adjustedProgress * math.pi * 4) * 20;
      final x = (petal.x * size.width) + sway;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(adjustedProgress * math.pi * petal.rotationSpeed);

      final path = Path();
      path.moveTo(0, -petal.size / 2);
      path.quadraticBezierTo(petal.size / 2, 0, 0, petal.size / 2);
      path.quadraticBezierTo(-petal.size / 2, 0, 0, -petal.size / 2);
      canvas.drawPath(path, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_PetalsPainter oldDelegate) => true;
}
