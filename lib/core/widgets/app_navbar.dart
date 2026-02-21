import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/theme_provider.dart';
import '../responsive/platform_utils.dart';
import '../responsive/responsive_layout.dart';
import '../theme/app_colors.dart';
import '../theme/app_decoration.dart';
import '../theme/app_spacing.dart';

class AppNavbar extends ConsumerWidget implements PreferredSizeWidget {
  const AppNavbar({super.key});

  static const _navItems = [
    ('Home', '/'),
    ('Services', '/services'),
    ('Case Studies', '/case-studies'),
    ('Consulting', '/consulting'),
    ('Contact', '/contact'),
  ];

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final currentPath = GoRouterState.of(context).uri.path;
    final colors = AppColors.of(context);
    final useBlur = colors.useBackdropBlur &&
        (PlatformUtils.isWeb || PlatformUtils.isDesktopOS);

    Widget navbar = Container(
      height: 72,
      decoration: BoxDecoration(
        color: useBlur
            ? colors.background.withValues(alpha: 0.8)
            : colors.background.withValues(alpha: 0.95),
        border: colors.style == ThemeStyle.skeuomorphic
            ? Border(
                bottom: BorderSide(color: colors.shadowEdge, width: 2),
              )
            : null,
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveLayout.contentWidth(context),
                ),
                child: Padding(
                  padding: AppSpacing.pagePadding,
                  child: Row(
                    children: [
                      _Logo(),
                      const Spacer(),
                      if (isDesktop) ...[
                        ..._navItems.map((item) => _NavItem(
                              label: item.$1,
                              path: item.$2,
                              isActive: currentPath == item.$2,
                            )),
                        const SizedBox(width: 8),
                        _ThemeToggle(ref: ref),
                      ] else
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _ThemeToggle(ref: ref),
                            _MobileMenuButton(
                              navItems: _navItems,
                              currentPath: currentPath,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom border
          if (colors.style != ThemeStyle.skeuomorphic)
            Container(
              height: colors.style == ThemeStyle.claymorphic ? 2 : 1,
              decoration: colors.style == ThemeStyle.claymorphic
                  ? BoxDecoration(
                      color: colors.divider.withValues(alpha: 0.4),
                    )
                  : BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          colors.primary.withValues(alpha: 0.5),
                          colors.secondary.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
            ),
        ],
      ),
    );

    if (useBlur) {
      navbar = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: navbar,
        ),
      );
    }

    return navbar;
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({required this.ref});

  final WidgetRef ref;

  static const _cycle = [
    ThemeStyle.glass,
    ThemeStyle.skeuomorphic,
    ThemeStyle.claymorphic,
  ];

  static const _icons = {
    ThemeStyle.glass: Icons.auto_awesome,
    ThemeStyle.skeuomorphic: Icons.layers,
    ThemeStyle.claymorphic: Icons.palette_outlined,
  };

  static const _labels = {
    ThemeStyle.glass: 'Glass',
    ThemeStyle.skeuomorphic: 'Skeuomorphic',
    ThemeStyle.claymorphic: 'Clay',
  };

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final current = ref.watch(themeStyleProvider);
    final nextIndex = (_cycle.indexOf(current) + 1) % _cycle.length;
    final next = _cycle[nextIndex];

    return IconButton(
      icon: Icon(
        _icons[current],
        color: colors.primary,
        size: 20,
      ),
      tooltip: 'Switch to ${_labels[next]}',
      onPressed: () {
        ref.read(themeStyleProvider.notifier).state = next;
      },
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return GestureDetector(
      onTap: () => context.go('/'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: AppDecoration.logoBox(colors),
              child: Center(
                child: Text(
                  'C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Corvanta',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.path,
    required this.isActive,
  });

  final String label;
  final String path;
  final bool isActive;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = widget.isActive || _hovering;
    final colors = AppColors.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => context.go(widget.path),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: isHighlighted
                          ? colors.textPrimary
                          : colors.textSecondary,
                      fontWeight:
                          widget.isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isHighlighted ? 24 : 0,
                decoration: BoxDecoration(
                  gradient: colors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color: colors.primary.withValues(alpha: 0.5),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({
    required this.navItems,
    required this.currentPath,
  });

  final List<(String, String)> navItems;
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return IconButton(
      icon: Icon(Icons.menu, color: colors.textPrimary),
      onPressed: () => _showMobileMenu(context),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final router = GoRouter.of(context);
    final colors = AppColors.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(colors.cardRadius),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: navItems.map((item) {
                final isActive = currentPath == item.$2;
                return ListTile(
                  title: Text(
                    item.$1,
                    style:
                        Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                              color: isActive
                                  ? colors.primary
                                  : colors.textPrimary,
                              fontWeight:
                                  isActive ? FontWeight.w600 : FontWeight.w400,
                            ),
                  ),
                  trailing: isActive
                      ? Icon(Icons.circle, size: 8, color: colors.primary)
                      : null,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    router.go(item.$2);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
