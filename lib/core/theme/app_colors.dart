import 'package:flutter/material.dart';

enum ThemeStyle { glass, skeuomorphic, claymorphic }

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.surfaceElevated,
    required this.surfaceCard,
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.secondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.success,
    required this.error,
    required this.warning,
    required this.border,
    required this.divider,
    required this.glowPurple,
    required this.glowCyan,
    required this.glassSurface,
    required this.glassBorder,
    required this.primaryGradient,
    required this.surfaceGradient,
    required this.heroGradient,
    required this.accentLineGradient,
    required this.highlightEdge,
    required this.shadowEdge,
    required this.innerHighlight,
    required this.innerShadow,
    required this.cardRadius,
    required this.buttonRadius,
    required this.useBackdropBlur,
    required this.style,
  });

  // Base surfaces
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color surfaceElevated;
  final Color surfaceCard;

  // Accent
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color secondary;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  // Semantic
  final Color success;
  final Color error;
  final Color warning;

  // Borders & Dividers
  final Color border;
  final Color divider;

  // Glow & Glass
  final Color glowPurple;
  final Color glowCyan;
  final Color glassSurface;
  final Color glassBorder;

  // Gradients
  final LinearGradient primaryGradient;
  final LinearGradient surfaceGradient;
  final LinearGradient heroGradient;
  final LinearGradient accentLineGradient;

  // 3D / Depth
  final Color highlightEdge; // lighter bevel (top-left)
  final Color shadowEdge; // darker bevel (bottom-right)
  final Color innerHighlight; // inner glow for clay/emboss
  final Color innerShadow; // inner shadow for inset effects

  // Shape
  final double cardRadius;
  final double buttonRadius;
  final bool useBackdropBlur;
  final ThemeStyle style;

  // ── Glassmorphism theme ──
  factory AppColors.glass() {
    const primary = Color(0xFF6C63FF);
    const secondary = Color(0xFF00D9FF);
    const surface = Color(0xFF222240);
    const surfaceVariant = Color(0xFF2A2A4A);
    const background = Color(0xFF1A1A2E);

    return const AppColors(
      background: background,
      surface: surface,
      surfaceVariant: surfaceVariant,
      surfaceElevated: Color(0xFF303055),
      surfaceCard: Color(0xFF282850),
      primary: primary,
      primaryLight: Color(0xFF8B83FF),
      primaryDark: Color(0xFF4A42DB),
      secondary: secondary,
      textPrimary: Color(0xFFF0F0F5),
      textSecondary: Color(0xFFB0B0C8),
      textTertiary: Color(0xFF7A7A9A),
      success: Color(0xFF4CAF50),
      error: Color(0xFFEF5350),
      warning: Color(0xFFFF9800),
      border: Color(0xFF4A4A70),
      divider: Color(0xFF3E3E60),
      glowPurple: primary,
      glowCyan: secondary,
      glassSurface: Color(0x1AFFFFFF),
      glassBorder: Color(0x33FFFFFF),
      primaryGradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      surfaceGradient: LinearGradient(
        colors: [surface, surfaceVariant],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      heroGradient: LinearGradient(
        colors: [background, surface, background],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentLineGradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      highlightEdge: Color(0x00000000),
      shadowEdge: Color(0x00000000),
      innerHighlight: Color(0x00000000),
      innerShadow: Color(0x00000000),
      cardRadius: 12,
      buttonRadius: 8,
      useBackdropBlur: true,
      style: ThemeStyle.glass,
    );
  }

  // ── Skeuomorphic theme (realistic 3D, tactile, embossed) ──
  factory AppColors.skeu() {
    const primary = Color(0xFFEBB030); // vivid gold
    const secondary = Color(0xFFD88540); // vivid copper
    const surface = Color(0xFF4A3828); // medium brown — clearly visible
    const surfaceVariant = Color(0xFF564434); // warm medium-light
    const background = Color(0xFF1A1208); // very dark walnut base

    return const AppColors(
      background: background,
      surface: surface,
      surfaceVariant: surfaceVariant,
      surfaceElevated: Color(0xFF5E4C3A), // lighter warm brown
      surfaceCard: Color(0xFF52402E), // clearly distinct card
      primary: primary,
      primaryLight: Color(0xFFF5D070), // bright light gold
      primaryDark: Color(0xFFC09020),
      secondary: secondary,
      textPrimary: Color(0xFFFFFFFF), // pure white
      textSecondary: Color(0xFFE8D8C4), // bright cream
      textTertiary: Color(0xFFBBA888), // warm but readable
      success: Color(0xFF8BBF30),
      error: Color(0xFFE06848),
      warning: Color(0xFFEBB030),
      border: Color(0xFF6E5C44), // clearly visible border
      divider: Color(0xFF5E4C38),
      glowPurple: primary,
      glowCyan: secondary,
      glassSurface: Color(0x1AFFFFFF),
      glassBorder: Color(0x22FFFFFF),
      primaryGradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      surfaceGradient: LinearGradient(
        colors: [surface, surfaceVariant],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      heroGradient: LinearGradient(
        colors: [background, Color(0xFF382818), background],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentLineGradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      // Bevel: bright highlight, strong shadow
      highlightEdge: Color(0x66FFFFFF),
      shadowEdge: Color(0x88000000),
      innerHighlight: Color(0x28FFFFFF),
      innerShadow: Color(0x40000000),
      cardRadius: 6,
      buttonRadius: 6,
      useBackdropBlur: false,
      style: ThemeStyle.skeuomorphic,
    );
  }

  // ── Claymorphic theme (soft, rounded, inflated, warm beige/white) ──
  factory AppColors.clay() {
    const primary = Color(0xFF9B7BF4);
    const secondary = Color(0xFF60B8E0);
    const surface = Color(0xFFEDE7E0);
    const surfaceVariant = Color(0xFFE3DCD4);
    const background = Color(0xFFF5F0EB);

    return const AppColors(
      background: background,
      surface: surface,
      surfaceVariant: surfaceVariant,
      surfaceElevated: Color(0xFFFFFBF7),
      surfaceCard: Color(0xFFFAF5F0),
      primary: primary,
      primaryLight: Color(0xFFB9A4F8),
      primaryDark: Color(0xFF7C3AED),
      secondary: secondary,
      textPrimary: Color(0xFF1A1818),
      textSecondary: Color(0xFF5C5652),
      textTertiary: Color(0xFF8A837C),
      success: Color(0xFF3B9B4F),
      error: Color(0xFFD94444),
      warning: Color(0xFFD4960C),
      border: Color(0xFFD5CEC6),
      divider: Color(0xFFDDD6CE),
      glowPurple: primary,
      glowCyan: secondary,
      glassSurface: Color(0x08000000),
      glassBorder: Color(0x10000000),
      primaryGradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      surfaceGradient: LinearGradient(
        colors: [surface, surfaceVariant],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      heroGradient: LinearGradient(
        colors: [background, surface, background],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentLineGradient: LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      // Clay: soft neumorphic shadows on light surface
      highlightEdge: Color(0x99FFFFFF),
      shadowEdge: Color(0x28000000),
      innerHighlight: Color(0x66FFFFFF),
      innerShadow: Color(0x18000000),
      cardRadius: 22,
      buttonRadius: 16,
      useBackdropBlur: false,
      style: ThemeStyle.claymorphic,
    );
  }

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? surfaceElevated,
    Color? surfaceCard,
    Color? primary,
    Color? primaryLight,
    Color? primaryDark,
    Color? secondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? success,
    Color? error,
    Color? warning,
    Color? border,
    Color? divider,
    Color? glowPurple,
    Color? glowCyan,
    Color? glassSurface,
    Color? glassBorder,
    LinearGradient? primaryGradient,
    LinearGradient? surfaceGradient,
    LinearGradient? heroGradient,
    LinearGradient? accentLineGradient,
    Color? highlightEdge,
    Color? shadowEdge,
    Color? innerHighlight,
    Color? innerShadow,
    double? cardRadius,
    double? buttonRadius,
    bool? useBackdropBlur,
    ThemeStyle? style,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
      secondary: secondary ?? this.secondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      glowPurple: glowPurple ?? this.glowPurple,
      glowCyan: glowCyan ?? this.glowCyan,
      glassSurface: glassSurface ?? this.glassSurface,
      glassBorder: glassBorder ?? this.glassBorder,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      surfaceGradient: surfaceGradient ?? this.surfaceGradient,
      heroGradient: heroGradient ?? this.heroGradient,
      accentLineGradient: accentLineGradient ?? this.accentLineGradient,
      highlightEdge: highlightEdge ?? this.highlightEdge,
      shadowEdge: shadowEdge ?? this.shadowEdge,
      innerHighlight: innerHighlight ?? this.innerHighlight,
      innerShadow: innerShadow ?? this.innerShadow,
      cardRadius: cardRadius ?? this.cardRadius,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      useBackdropBlur: useBackdropBlur ?? this.useBackdropBlur,
      style: style ?? this.style,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      glowPurple: Color.lerp(glowPurple, other.glowPurple, t)!,
      glowCyan: Color.lerp(glowCyan, other.glowCyan, t)!,
      glassSurface: Color.lerp(glassSurface, other.glassSurface, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      primaryGradient: LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
      surfaceGradient: LinearGradient.lerp(surfaceGradient, other.surfaceGradient, t)!,
      heroGradient: LinearGradient.lerp(heroGradient, other.heroGradient, t)!,
      accentLineGradient: LinearGradient.lerp(accentLineGradient, other.accentLineGradient, t)!,
      highlightEdge: Color.lerp(highlightEdge, other.highlightEdge, t)!,
      shadowEdge: Color.lerp(shadowEdge, other.shadowEdge, t)!,
      innerHighlight: Color.lerp(innerHighlight, other.innerHighlight, t)!,
      innerShadow: Color.lerp(innerShadow, other.innerShadow, t)!,
      cardRadius: lerpDouble(cardRadius, other.cardRadius, t)!,
      buttonRadius: lerpDouble(buttonRadius, other.buttonRadius, t)!,
      useBackdropBlur: t < 0.5 ? useBackdropBlur : other.useBackdropBlur,
      style: t < 0.5 ? style : other.style,
    );
  }

  static double? lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
