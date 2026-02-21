import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Scroll-aware reveal widget with fade, slide, and scale effects.
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideOffset = const Offset(0, 60),
    this.scaleFrom = 0.95,
    this.duration = const Duration(milliseconds: 700),
  });

  final Widget child;
  final Duration delay;
  final Offset slideOffset;
  final double scaleFrom;
  final Duration duration;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: widget.slideOffset, end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _scale = Tween<double>(begin: widget.scaleFrom, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisible(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.15) return;
    _triggered = true;
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: _onVisible,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(
              offset: _slide.value,
              child: Transform.scale(
                scale: _scale.value,
                child: child,
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
