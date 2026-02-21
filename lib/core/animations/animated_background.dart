import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Full-page animated background that renders theme-specific visuals.
/// Place behind page content in a [Stack].
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    final offset = widget.scrollController.offset;
    if ((_scrollOffset - offset).abs() > 1) {
      setState(() => _scrollOffset = offset);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return RepaintBoundary(
      child: Container(
        color: colors.background,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: switch (colors.style) {
                ThemeStyle.glass => _GlassBackgroundPainter(
                    progress: _controller.value,
                    scrollOffset: _scrollOffset,
                    colors: colors,
                  ),
                ThemeStyle.skeuomorphic => _SkeuBackgroundPainter(
                    progress: _controller.value,
                    scrollOffset: _scrollOffset,
                    colors: colors,
                  ),
                ThemeStyle.claymorphic => _ClayBackgroundPainter(
                    progress: _controller.value,
                    scrollOffset: _scrollOffset,
                    colors: colors,
                  ),
              },
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

// ── Glass: pulsing grid dots + drifting gradient orbs ──

class _GlassBackgroundPainter extends CustomPainter {
  _GlassBackgroundPainter({
    required this.progress,
    required this.scrollOffset,
    required this.colors,
  });

  final double progress;
  final double scrollOffset;
  final AppColors colors;

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * 2 * math.pi;
    final parallax = scrollOffset * 0.05;

    // Grid lines — use white-based color for visibility on dark navy
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 0.5;

    const spacing = 80.0;
    for (var x = 0.0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (var y = -parallax % spacing; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // Pulsing dots at intersections — bright, solid dots
    for (var x = 0.0; x < size.width; x += spacing) {
      for (var y = -parallax % spacing; y < size.height; y += spacing) {
        final pulse = math.sin(t + x * 0.01 + y * 0.01) * 0.5 + 0.5;
        // Solid bright purple/cyan dots
        canvas.drawCircle(
          Offset(x, y),
          1.5 + 1.0 * pulse,
          Paint()..color = colors.primary.withValues(alpha: 0.35 + 0.40 * pulse),
        );
      }
    }

    // 3 drifting orbs — draw as solid filled circles with high alpha
    _drawOrb(canvas, size, t, 0.78, 0.18, size.width * 0.30,
        colors.primary, 0.20, parallax);
    _drawOrb(canvas, size, t + 2.1, 0.18, 0.65, size.width * 0.25,
        colors.secondary, 0.16, parallax);
    _drawOrb(canvas, size, t + 4.2, 0.52, 0.42, size.width * 0.20,
        colors.primaryLight, 0.14, parallax);
  }

  void _drawOrb(Canvas canvas, Size size, double t, double cx, double cy,
      double radius, Color baseColor, double peakAlpha, double parallax) {
    final center = Offset(
      size.width * cx + 50 * math.sin(t),
      size.height * cy + 35 * math.cos(t) - parallax,
    );
    // Inner bright core
    canvas.drawCircle(
      center,
      radius * 0.4,
      Paint()..color = baseColor.withValues(alpha: peakAlpha),
    );
    // Mid glow
    canvas.drawCircle(
      center,
      radius * 0.7,
      Paint()..color = baseColor.withValues(alpha: peakAlpha * 0.5),
    );
    // Outer glow
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = baseColor.withValues(alpha: peakAlpha * 0.2),
    );
  }

  @override
  bool shouldRepaint(_GlassBackgroundPainter old) =>
      old.progress != progress ||
      old.scrollOffset != scrollOffset ||
      old.colors != colors;
}

// ── Skeuomorphic: floating ember/spark particles ──

class _SkeuBackgroundPainter extends CustomPainter {
  _SkeuBackgroundPainter({
    required this.progress,
    required this.scrollOffset,
    required this.colors,
  });

  final double progress;
  final double scrollOffset;
  final AppColors colors;

  static const _particleCount = 40;

  @override
  void paint(Canvas canvas, Size size) {
    final parallax = scrollOffset * 0.03;
    final rng = math.Random(42);

    for (var i = 0; i < _particleCount; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final speed = 0.3 + rng.nextDouble() * 0.7;
      final phase = rng.nextDouble() * 2 * math.pi;

      final t = progress * 2 * math.pi;
      final driftY = (baseY - speed * progress * size.height * 0.5) %
              size.height -
          parallax;
      final swayX = baseX + math.sin(t * speed + phase) * 20;

      final edgeFade = _edgeFade(driftY, size.height);
      if (edgeFade <= 0) continue;

      final particleSize = 2.0 + rng.nextDouble() * 3.0;
      final isGold = i % 3 != 0;
      final color = isGold
          ? colors.primary.withValues(alpha: 0.50 * edgeFade)
          : colors.secondary.withValues(alpha: 0.40 * edgeFade);

      // Glow halo
      canvas.drawCircle(
        Offset(swayX, driftY),
        particleSize * 3,
        Paint()
          ..color = (isGold ? colors.primary : colors.secondary)
              .withValues(alpha: 0.08 * edgeFade),
      );

      // Particle core
      canvas.drawCircle(
        Offset(swayX, driftY),
        particleSize,
        Paint()..color = color,
      );
    }
  }

  double _edgeFade(double y, double height) {
    const fadeZone = 80.0;
    if (y < fadeZone) return (y / fadeZone).clamp(0, 1);
    if (y > height - fadeZone) return ((height - y) / fadeZone).clamp(0, 1);
    return 1.0;
  }

  @override
  bool shouldRepaint(_SkeuBackgroundPainter old) =>
      old.progress != progress ||
      old.scrollOffset != scrollOffset ||
      old.colors != colors;
}

// ── Claymorphic: gentle pastel watercolor waves on warm beige ──

class _ClayBackgroundPainter extends CustomPainter {
  _ClayBackgroundPainter({
    required this.progress,
    required this.scrollOffset,
    required this.colors,
  });

  final double progress;
  final double scrollOffset;
  final AppColors colors;

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * 2 * math.pi;
    final parallax = scrollOffset * 0.04;

    // Soft large pastel washes — slow drifting shapes
    final washes = [
      (0.20, 0.15, 0.28, colors.primary, 0.10),
      (0.80, 0.35, 0.24, colors.secondary, 0.08),
      (0.45, 0.70, 0.22, colors.primaryLight, 0.09),
      (0.70, 0.80, 0.20, colors.primary, 0.07),
      (0.15, 0.55, 0.18, colors.secondary, 0.08),
    ];

    for (var i = 0; i < washes.length; i++) {
      final (cx, cy, radiusFactor, color, alpha) = washes[i];
      final phase = i * 1.3;
      final speed = 0.3 + i * 0.1;
      final pulse = math.sin(t * speed + phase) * 0.5 + 0.5;
      final radius = size.width * radiusFactor;

      final center = Offset(
        size.width * cx + math.sin(t * speed + phase) * 45,
        size.height * cy + math.cos(t * speed + phase) * 35 - parallax,
      );

      // Soft outer wash
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: radius * 2.2,
          height: radius * 1.6,
        ),
        Paint()..color = color.withValues(alpha: alpha * 0.5 + alpha * 0.3 * pulse),
      );
      // Inner brighter core
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: radius * 1.2,
          height: radius * 0.9,
        ),
        Paint()..color = color.withValues(alpha: alpha + alpha * 0.4 * pulse),
      );
    }

    // Floating tiny dots / sparkles
    final rng = math.Random(55);
    for (var i = 0; i < 20; i++) {
      final bx = rng.nextDouble() * size.width;
      final by = rng.nextDouble() * size.height;
      final phase = rng.nextDouble() * 2 * math.pi;
      final sparkle = (math.sin(t * 0.8 + phase) * 0.5 + 0.5);

      canvas.drawCircle(
        Offset(bx, by - parallax * 0.5),
        1.5 + sparkle,
        Paint()..color = colors.primary.withValues(alpha: 0.12 + 0.15 * sparkle),
      );
    }
  }

  @override
  bool shouldRepaint(_ClayBackgroundPainter old) =>
      old.progress != progress ||
      old.scrollOffset != scrollOffset ||
      old.colors != colors;
}
