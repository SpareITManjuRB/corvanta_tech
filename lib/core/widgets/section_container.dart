import 'dart:ui';

import 'package:flutter/material.dart';

import '../responsive/responsive_layout.dart';
import '../theme/app_colors.dart';
import '../theme/app_decoration.dart';
import '../theme/app_spacing.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.showTopDivider = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool showTopDivider;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isLight = colors.style == ThemeStyle.claymorphic;
    final effectiveColor = backgroundColor?.withValues(
            alpha: isLight ? 0.85 : 0.70) ??
        Colors.transparent;

    Widget content = Container(
      width: double.infinity,
      color: effectiveColor,
      padding: padding ?? AppSpacing.sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveLayout.contentWidth(context),
          ),
          child: Padding(
            padding: AppSpacing.pagePadding,
            child: child,
          ),
        ),
      ),
    );

    // Frosted blur — subtle on light theme, stronger on dark themes
    final sigma = isLight ? 2.0 : 6.0;
    content = ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: content,
      ),
    );

    return Column(
      children: [
        if (showTopDivider) AppDecoration.sectionDivider(colors),
        content,
      ],
    );
  }
}
