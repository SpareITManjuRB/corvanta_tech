import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../responsive/platform_utils.dart';
import '../responsive/responsive_layout.dart';
import '../theme/app_colors.dart';
import '../theme/app_decoration.dart';
import '../theme/app_spacing.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  static const _companyLinks = [
    ('About', '/about'),
    ('Careers', '/careers'),
    ('Blog', '/blog'),
  ];

  static const _serviceLinks = [
    ('Web', '/services'),
    ('Mobile', '/services'),
    ('Cloud', '/services'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final colors = AppColors.of(context);

    return Column(
      children: [
        // Top separator
        AppDecoration.sectionDivider(colors),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: colors.style == ThemeStyle.claymorphic ? 2 : 6,
              sigmaY: colors.style == ThemeStyle.claymorphic ? 2 : 6,
            ),
            child: Container(
              width: double.infinity,
              color: colors.surfaceVariant.withValues(
                  alpha: colors.style == ThemeStyle.claymorphic ? 0.90 : 0.75),
              child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ResponsiveLayout.contentWidth(context),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xxl,
                ),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2, child: _branding(textTheme, colors)),
                          Expanded(
                              child:
                                  _links(context, 'Company', _companyLinks)),
                          Expanded(
                              child:
                                  _links(context, 'Services', _serviceLinks)),
                          Expanded(child: _socialColumn(context)),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _branding(textTheme, colors),
                          const SizedBox(height: AppSpacing.xl),
                          Wrap(
                            spacing: AppSpacing.xxl,
                            runSpacing: AppSpacing.xl,
                            alignment: WrapAlignment.center,
                            children: [
                              _links(context, 'Company', _companyLinks),
                              _links(context, 'Services', _serviceLinks),
                              _socialColumn(context),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
          ),
        ),
      ],
    );
  }

  Widget _branding(TextTheme textTheme, AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              colors.primaryGradient.createShader(bounds),
          child: Text(
            'Corvanta Technologies',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Engineering digital systems that scale.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          '\u00a9 2025 Corvanta Technologies. All rights reserved.',
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _links(
      BuildContext context, String title, List<(String, String)> items) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title.toUpperCase(),
          style: textTheme.labelSmall?.copyWith(
            color: colors.textTertiary,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: GestureDetector(
                onTap: () => context.go(item.$2),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(item.$1, style: textTheme.bodyMedium),
                ),
              ),
            )),
      ],
    );
  }

  Widget _socialColumn(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'CONNECT',
          style: textTheme.labelSmall?.copyWith(
            color: colors.textTertiary,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SocialIcon(icon: Icons.code, label: 'GitHub'),
            const SizedBox(width: AppSpacing.sm),
            _SocialIcon(icon: Icons.business, label: 'LinkedIn'),
            const SizedBox(width: AppSpacing.sm),
            _SocialIcon(icon: Icons.email_outlined, label: 'Email'),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final supportsHover = PlatformUtils.supportsHover;
    final colors = AppColors.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: supportsHover ? (_) => setState(() => _hovering = true) : null,
      onExit: supportsHover ? (_) => setState(() => _hovering = false) : null,
      child: Tooltip(
        message: widget.label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovering
                ? colors.primary.withValues(alpha: 0.15)
                : colors.background.withValues(alpha: 0.5),
            border: Border.all(
              color: _hovering
                  ? colors.primary.withValues(alpha: 0.5)
                  : colors.border,
            ),
            boxShadow: _hovering && colors.style == ThemeStyle.skeuomorphic
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 3,
                      offset: const Offset(1, 2),
                    ),
                  ]
                : _hovering && colors.style == ThemeStyle.claymorphic
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(3, 3),
                        ),
                      ]
                    : _hovering
                        ? [
                            BoxShadow(
                              color: colors.primary.withValues(alpha: 0.2),
                              blurRadius: 8,
                              spreadRadius: -1,
                            ),
                          ]
                        : [],
          ),
          child: Icon(
            widget.icon,
            size: 18,
            color: _hovering ? colors.primary : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
