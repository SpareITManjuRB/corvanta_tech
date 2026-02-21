import 'package:flutter/material.dart';

import '../responsive/platform_utils.dart';
import '../theme/app_colors.dart';
import '../theme/app_decoration.dart';

class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
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
            padding: const EdgeInsets.symmetric(horizontal: 32),
            decoration: _pressed
                ? AppDecoration.primaryButtonPressed(colors)
                : AppDecoration.primaryButton(colors, hovering: _hovering),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colors.style == ThemeStyle.skeuomorphic
                            ? const Color(0xFF1A1208)
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (widget.icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    widget.icon,
                    size: 18,
                    color: colors.style == ThemeStyle.skeuomorphic
                        ? const Color(0xFF1A1208)
                        : Colors.white,
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
