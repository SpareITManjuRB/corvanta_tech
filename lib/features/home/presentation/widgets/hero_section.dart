import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ghost_button.dart';
import '../../../../core/widgets/gradient_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;
  late final Animation<double> _accentFade;
  late final AnimationController _orbController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _slideUp = Tween<Offset>(begin: const Offset(0, 50), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    ));
    _accentFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _orbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return RepaintBoundary(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: double.infinity,
            color: colors.background.withValues(alpha: 0.55),
            child: Stack(
          children: [
            // Animated gradient orbs
            if (isDesktop)
              Positioned.fill(
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: _orbController,
                    builder: (context, _) => CustomPaint(
                      painter: _OrbPainter(
                        progress: _orbController.value,
                        colors: colors,
                      ),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),
            // Main content
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveLayout.contentWidth(context),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical:
                        isDesktop ? AppSpacing.sectionLarge : AppSpacing.section,
                  ),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeIn.value,
                        child: Transform.translate(
                          offset: _slideUp.value,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: isDesktop
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _accentFade,
                          builder: (context, child) => Opacity(
                            opacity: _accentFade.value,
                            child: child,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: AppDecoration.accentBadge(colors),
                            child: Text(
                              'PRODUCT ENGINEERING STUDIO',
                              style: textTheme.labelSmall?.copyWith(
                                color: colors.style ==
                                        ThemeStyle.skeuomorphic
                                    ? colors.textPrimary
                                    : colors.primaryLight,
                                letterSpacing: 2.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          'Engineering\nDigital Systems\nThat Scale.',
                          style: (isDesktop
                                  ? textTheme.displayLarge
                                  : textTheme.displayMedium)
                              ?.copyWith(height: 1.1),
                          textAlign:
                              isDesktop ? TextAlign.left : TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 560),
                          child: Text(
                            'We architect and build enterprise-grade software platforms \u2014 '
                            'from system design to production deployment.',
                            style: textTheme.bodyLarge?.copyWith(fontSize: 18),
                            textAlign:
                                isDesktop ? TextAlign.left : TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        Wrap(
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.md,
                          alignment: isDesktop
                              ? WrapAlignment.start
                              : WrapAlignment.center,
                          children: [
                            GradientButton(
                              label: 'View Our Work',
                              icon: Icons.arrow_forward,
                              onPressed: () => context.go('/case-studies'),
                            ),
                            GhostButton(
                              label: 'Start a Conversation',
                              onPressed: () => context.go('/contact'),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxxl),
                        _StatsRow(isDesktop: isDesktop),
                      ],
                    ),
                  ),
                ),
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

class _OrbPainter extends CustomPainter {
  _OrbPainter({required this.progress, required this.colors});

  final double progress;
  final AppColors colors;

  @override
  void paint(Canvas canvas, Size size) {
    final t = math.sin(progress * 2 * math.pi) * 0.5 + 0.5;

    final purpleCenter = Offset(
      size.width * 0.75 + 30 * math.sin(progress * 2 * math.pi),
      size.height * 0.25 + 20 * math.cos(progress * 2 * math.pi),
    );
    canvas.drawCircle(
      purpleCenter,
      size.width * 0.25,
      Paint()
        ..shader = RadialGradient(
          colors: [
            colors.primary.withValues(alpha: 0.08 + 0.04 * t),
            colors.primary.withValues(alpha: 0.0),
          ],
        ).createShader(
            Rect.fromCircle(center: purpleCenter, radius: size.width * 0.25)),
    );

    final cyanCenter = Offset(
      size.width * 0.2 + 25 * math.cos(progress * 2 * math.pi + 1),
      size.height * 0.7 + 15 * math.sin(progress * 2 * math.pi + 1),
    );
    canvas.drawCircle(
      cyanCenter,
      size.width * 0.2,
      Paint()
        ..shader = RadialGradient(
          colors: [
            colors.secondary.withValues(alpha: 0.06 + 0.03 * t),
            colors.secondary.withValues(alpha: 0.0),
          ],
        ).createShader(
            Rect.fromCircle(center: cyanCenter, radius: size.width * 0.2)),
    );

    final accentCenter = Offset(
      size.width * 0.5 + 20 * math.sin(progress * 2 * math.pi + 2),
      size.height * 0.45 + 25 * math.cos(progress * 2 * math.pi + 2),
    );
    canvas.drawCircle(
      accentCenter,
      size.width * 0.12,
      Paint()
        ..shader = RadialGradient(
          colors: [
            colors.primaryLight.withValues(alpha: 0.05 + 0.03 * t),
            colors.primaryLight.withValues(alpha: 0.0),
          ],
        ).createShader(
            Rect.fromCircle(center: accentCenter, radius: size.width * 0.12)),
    );
  }

  @override
  bool shouldRepaint(_OrbPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.colors != colors;
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final items = [
      ('50+', 'Projects Delivered'),
      ('8+', 'Years Experience'),
      ('99.9%', 'Uptime SLA'),
    ];

    return Wrap(
      spacing: isDesktop ? AppSpacing.xxl : AppSpacing.lg,
      runSpacing: AppSpacing.md,
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: items.map((item) {
        return Column(
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  colors.primaryGradient.createShader(bounds),
              child: Text(
                item.$1,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(height: 4),
            Text(item.$2, style: Theme.of(context).textTheme.bodySmall),
          ],
        );
      }).toList(),
    );
  }
}
