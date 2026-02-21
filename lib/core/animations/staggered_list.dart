import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StaggeredList extends StatefulWidget {
  const StaggeredList({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.animationDuration = const Duration(milliseconds: 500),
    this.offset = const Offset(0, 40),
  });

  final List<Widget> children;
  final Duration staggerDelay;
  final Duration animationDuration;
  final Offset offset;

  @override
  State<StaggeredList> createState() => _StaggeredListState();
}

class _StaggeredListState extends State<StaggeredList>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.children.length,
      (_) => AnimationController(vsync: this, duration: widget.animationDuration),
    );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onVisible(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.15) return;
    _triggered = true;
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.staggerDelay * i, () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: _onVisible,
      child: Column(
        children: List.generate(widget.children.length, (i) {
          final opacity = CurvedAnimation(
            parent: _controllers[i],
            curve: Curves.easeOut,
          );
          final slide = Tween<Offset>(begin: widget.offset, end: Offset.zero)
              .animate(CurvedAnimation(
            parent: _controllers[i],
            curve: Curves.easeOutCubic,
          ));
          return AnimatedBuilder(
            animation: _controllers[i],
            builder: (context, child) {
              return Opacity(
                opacity: opacity.value,
                child: Transform.translate(offset: slide.value, child: child),
              );
            },
            child: widget.children[i],
          );
        }),
      ),
    );
  }
}
