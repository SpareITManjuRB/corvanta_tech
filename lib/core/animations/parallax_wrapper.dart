import 'package:flutter/material.dart';

import '../responsive/platform_utils.dart';

/// Subtle parallax effect for web — shifts child vertically
/// based on scroll position. No-ops on mobile for performance.
class ParallaxWrapper extends StatelessWidget {
  const ParallaxWrapper({
    super.key,
    required this.child,
    this.factor = 0.3,
  });

  final Widget child;
  final double factor;

  @override
  Widget build(BuildContext context) {
    if (!PlatformUtils.supportsHover) return child;

    return _WebParallax(factor: factor, child: child);
  }
}

class _WebParallax extends StatefulWidget {
  const _WebParallax({required this.child, required this.factor});

  final Widget child;
  final double factor;

  @override
  State<_WebParallax> createState() => _WebParallaxState();
}

class _WebParallaxState extends State<_WebParallax> {
  double _offset = 0;
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _updateOffset();
        return false;
      },
      child: Builder(
        builder: (context) {
          // Also listen to parent scrollable
          final scrollable = Scrollable.maybeOf(context);
          if (scrollable != null) {
            scrollable.position.addListener(_updateOffset);
          }
          return RepaintBoundary(
            child: Transform.translate(
              key: _key,
              offset: Offset(0, _offset * widget.factor),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }

  void _updateOffset() {
    final renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;

    final viewportHeight = MediaQuery.sizeOf(context).height;
    final position = renderBox.localToGlobal(Offset.zero);
    final centerOffset = position.dy - viewportHeight / 2;

    if (mounted && (_offset - centerOffset).abs() > 0.5) {
      setState(() => _offset = centerOffset);
    }
  }
}
