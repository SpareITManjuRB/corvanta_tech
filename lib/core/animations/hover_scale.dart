import 'package:flutter/material.dart';

import '../responsive/platform_utils.dart';

class HoverScale extends StatefulWidget {
  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.03,
    this.duration = const Duration(milliseconds: 200),
    this.glowColor,
  });

  final Widget child;
  final double scale;
  final Duration duration;
  final Color? glowColor;

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    if (!PlatformUtils.supportsHover) return widget.child;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? widget.scale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: widget.glowColor != null
            ? AnimatedContainer(
                duration: widget.duration,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _hovering
                      ? [
                          BoxShadow(
                            color: widget.glowColor!.withValues(alpha: 0.25),
                            blurRadius: 20,
                            spreadRadius: -2,
                          ),
                        ]
                      : [],
                ),
                child: widget.child,
              )
            : widget.child,
      ),
    );
  }
}
