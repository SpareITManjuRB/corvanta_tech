import 'package:flutter/material.dart';

import '../animations/fade_in_widget.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.gradientTitle = false,
  });

  final String label;
  final String title;
  final String? subtitle;
  final bool gradientTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);
    return FadeInWidget(
      key: ValueKey('section_header_$title'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 3,
                decoration: BoxDecoration(
                  gradient: colors.accentLineGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                label.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  color: colors.primary,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          gradientTitle
              ? ShaderMask(
                  shaderCallback: (bounds) =>
                      colors.primaryGradient.createShader(bounds),
                  child: Text(
                    title,
                    style: textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(title, style: textTheme.displaySmall),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(subtitle!, style: textTheme.bodyLarge),
            ),
          ],
        ],
      ),
    );
  }
}
