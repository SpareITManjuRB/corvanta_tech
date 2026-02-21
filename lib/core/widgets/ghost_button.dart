import 'package:flutter/material.dart';

import '../responsive/platform_utils.dart';
import '../theme/app_colors.dart';
import '../theme/app_decoration.dart';

class GhostButton extends StatefulWidget {
  const GhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _pressed = false;
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final supportsHover = PlatformUtils.supportsHover;
    final colors = AppColors.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: supportsHover ? (_) => setState(() => _hovering = true) : null,
      onExit: supportsHover ? (_) => setState(() => _hovering = false) : null,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: _pressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 52,
            decoration: AppDecoration.ghostButton(colors, hovering: _hovering),
            foregroundDecoration: _hovering &&
                    colors.style == ThemeStyle.glass
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(colors.buttonRadius),
                    border: GradientBorder(
                      gradient: colors.primaryGradient,
                      width: 1.5,
                    ),
                  )
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: _hovering
                            ? colors.textPrimary
                            : colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (widget.icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    widget.icon,
                    size: 18,
                    color: _hovering
                        ? colors.textPrimary
                        : colors.textSecondary,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBorder extends BoxBorder {
  const GradientBorder({
    required this.gradient,
    this.width = 1.0,
  });

  final Gradient gradient;
  final double width;

  @override
  BorderSide get bottom => BorderSide.none;

  @override
  BorderSide get top => BorderSide.none;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  bool get isUniform => true;

  @override
  void paint(Canvas canvas, Rect rect,
      {TextDirection? textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius? borderRadius}) {
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    final rrect = borderRadius != null
        ? borderRadius.toRRect(rect).deflate(width / 2)
        : RRect.fromRectAndRadius(
            rect.deflate(width / 2), Radius.circular(width));
    canvas.drawRRect(rrect, paint);
  }

  @override
  ShapeBorder scale(double t) =>
      GradientBorder(gradient: gradient, width: width * t);
}
