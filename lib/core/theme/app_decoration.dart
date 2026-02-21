import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Theme-aware decoration factory.
///
/// Each method returns visually distinct decorations per [ThemeStyle]:
/// - **Glass**: flat cards, colored glow shadows, gradient borders
/// - **Skeuomorphic**: embossed look via directional shadows, warm surfaces
/// - **Claymorphic**: puffy rounded shapes, inner highlight + outer shadow
abstract final class AppDecoration {
  // ─── Card decoration ───
  static BoxDecoration card(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          color: c.surfaceCard,
          borderRadius: BorderRadius.circular(c.cardRadius),
          border: Border.all(color: c.border),
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: c.surfaceCard,
          borderRadius: BorderRadius.circular(c.cardRadius),
          border: Border.all(color: c.border),
          boxShadow: [
            // Top-left highlight (light from above-left)
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.08),
              blurRadius: 1,
              offset: const Offset(-1, -1),
            ),
            // Bottom-right shadow (depth)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 6,
              offset: const Offset(3, 4),
            ),
            // Ambient shadow
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(1, 2),
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: c.surfaceCard,
          borderRadius: BorderRadius.circular(c.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(5, 6),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 30,
              offset: const Offset(3, 4),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.80),
              blurRadius: 14,
              offset: const Offset(-4, -4),
              spreadRadius: -2,
            ),
          ],
        );
    }
  }

  // ─── Elevated card (e.g. hover state, important panels) ───
  static BoxDecoration cardElevated(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          color: c.surfaceCard,
          borderRadius: BorderRadius.circular(c.cardRadius),
          border: Border.all(color: c.primary.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: c.surfaceElevated,
          borderRadius: BorderRadius.circular(c.cardRadius),
          border: Border.all(color: c.border, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.10),
              blurRadius: 1,
              offset: const Offset(-1, -1),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 10,
              offset: const Offset(4, 6),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(2, 3),
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: c.surfaceCard,
          borderRadius: BorderRadius.circular(c.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 20,
              offset: const Offset(6, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 36,
              offset: const Offset(4, 5),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.85),
              blurRadius: 18,
              offset: const Offset(-5, -5),
              spreadRadius: -2,
            ),
          ],
        );
    }
  }

  // ─── Primary (gradient) button decoration ───
  static BoxDecoration primaryButton(
    AppColors c, {
    bool hovering = false,
  }) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          gradient: c.primaryGradient,
          borderRadius: BorderRadius.circular(c.buttonRadius),
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: hovering ? 0.5 : 0.3),
              blurRadius: hovering ? 20 : 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: c.secondary.withValues(alpha: hovering ? 0.2 : 0.1),
              blurRadius: hovering ? 30 : 16,
              offset: const Offset(0, 6),
            ),
          ],
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: c.primary,
          borderRadius: BorderRadius.circular(c.buttonRadius),
          border: Border.all(
            color: Color.lerp(c.primary, Colors.black, 0.3)!,
            width: 1.5,
          ),
          boxShadow: [
            // Top highlight for raised look
            BoxShadow(
              color: Color.lerp(c.primary, Colors.white, 0.4)!
                  .withValues(alpha: 0.5),
              blurRadius: 1,
              offset: const Offset(0, -1),
              spreadRadius: -0.5,
            ),
            // Bottom shadow for depth
            BoxShadow(
              color: Colors.black.withValues(alpha: hovering ? 0.6 : 0.5),
              blurRadius: hovering ? 8 : 4,
              offset: const Offset(2, 3),
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: c.primary,
          borderRadius: BorderRadius.circular(c.buttonRadius),
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: 0.30),
              blurRadius: hovering ? 20 : 12,
              offset: const Offset(3, 5),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(3, 5),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.70),
              blurRadius: 10,
              offset: const Offset(-3, -3),
              spreadRadius: -2,
            ),
          ],
        );
    }
  }

  // ─── Primary button pressed (inset) decoration ───
  static BoxDecoration primaryButtonPressed(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          gradient: c.primaryGradient,
          borderRadius: BorderRadius.circular(c.buttonRadius),
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: Color.lerp(c.primary, Colors.black, 0.15),
          borderRadius: BorderRadius.circular(c.buttonRadius),
          border: Border.all(
            color: Color.lerp(c.primary, Colors.black, 0.4)!,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: Color.lerp(c.primary, Colors.black, 0.1),
          borderRadius: BorderRadius.circular(c.buttonRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(2, 3),
            ),
          ],
        );
    }
  }

  // ─── Ghost button decoration ───
  static BoxDecoration ghostButton(
    AppColors c, {
    bool hovering = false,
  }) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(c.buttonRadius),
          border: Border.all(
            width: 1.5,
            color: hovering ? Colors.transparent : c.border,
          ),
          gradient: hovering
              ? LinearGradient(colors: [
                  c.primary.withValues(alpha: 0.12),
                  c.secondary.withValues(alpha: 0.08),
                ])
              : null,
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(c.buttonRadius),
          color: hovering ? c.surfaceCard : c.surfaceVariant,
          border: Border.all(color: c.border),
          boxShadow: hovering
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: hovering ? c.surfaceElevated : c.surfaceCard,
          borderRadius: BorderRadius.circular(c.buttonRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: hovering ? 0.14 : 0.10),
              blurRadius: hovering ? 14 : 8,
              offset: const Offset(3, 4),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: hovering ? 0.80 : 0.65),
              blurRadius: 10,
              offset: const Offset(-3, -3),
              spreadRadius: -2,
            ),
          ],
        );
    }
  }

  // ─── Inset field decoration (for text inputs) ───
  static BoxDecoration insetField(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          color: c.surfaceVariant,
          borderRadius: BorderRadius.circular(c.buttonRadius),
          border: Border.all(color: c.border),
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: Color.lerp(c.surfaceVariant, Colors.black, 0.06),
          borderRadius: BorderRadius.circular(c.buttonRadius),
          border: Border.all(color: c.border),
          boxShadow: [
            // Inner shadow effect
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(1, 2),
              spreadRadius: -1,
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: Color.lerp(c.surfaceCard, Colors.black, 0.03),
          borderRadius: BorderRadius.circular(c.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 6,
              offset: const Offset(2, 2),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.60),
              blurRadius: 6,
              offset: const Offset(-2, -2),
              spreadRadius: -2,
            ),
          ],
        );
    }
  }

  // ─── Icon container (the small 48x48 icon boxes in cards) ───
  static BoxDecoration iconContainer(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          color: c.primary.withValues(alpha: 0.20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: c.primary.withValues(alpha: 0.30)),
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: 0.15),
              blurRadius: 8,
              spreadRadius: -2,
            ),
          ],
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: c.primary.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: c.border.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 3,
              offset: const Offset(1, 2),
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: c.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.65),
              blurRadius: 6,
              offset: const Offset(-2, -2),
              spreadRadius: -1,
            ),
          ],
        );
    }
  }

  // ─── Section divider ───
  static Widget sectionDivider(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                c.primary.withValues(alpha: 0.4),
                c.secondary.withValues(alpha: 0.3),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: c.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        );

      case ThemeStyle.skeuomorphic:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black.withValues(alpha: 0.5),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return Container(
          width: double.infinity,
          height: 2,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: c.divider,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.50),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        );
    }
  }

  // ─── Logo container ───
  static BoxDecoration logoBox(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          gradient: c.primaryGradient,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              spreadRadius: -2,
            ),
            BoxShadow(
              color: c.secondary.withValues(alpha: 0.2),
              blurRadius: 16,
              spreadRadius: -4,
            ),
          ],
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: c.primary,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color.lerp(c.primary, Colors.black, 0.3)!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.lerp(c.primary, Colors.white, 0.4)!
                  .withValues(alpha: 0.4),
              blurRadius: 1,
              offset: const Offset(0, -1),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: c.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: c.primary.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(3, 4),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.70),
              blurRadius: 8,
              offset: const Offset(-2, -2),
              spreadRadius: -2,
            ),
          ],
        );
    }
  }

  // ─── Accent badge / pill decoration ───
  static BoxDecoration accentBadge(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          color: c.primary.withValues(alpha: 0.20),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: c.primary.withValues(alpha: 0.40)),
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: c.primary.withValues(alpha: 0.20),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: c.border.withValues(alpha: 0.4),
          ),
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: c.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
        );
    }
  }

  // ─── Surface panel (containers with surface background) ───
  static BoxDecoration surfacePanel(AppColors c) {
    switch (c.style) {
      case ThemeStyle.glass:
        return BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(c.cardRadius),
          border: Border.all(color: c.border),
        );

      case ThemeStyle.skeuomorphic:
        return BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(c.cardRadius),
          border: Border.all(color: c.border),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.06),
              blurRadius: 1,
              offset: const Offset(-1, -1),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 5,
              offset: const Offset(2, 3),
            ),
          ],
        );

      case ThemeStyle.claymorphic:
        return BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(c.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 12,
              offset: const Offset(4, 5),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.70),
              blurRadius: 10,
              offset: const Offset(-3, -3),
              spreadRadius: -2,
            ),
          ],
        );
    }
  }
}
