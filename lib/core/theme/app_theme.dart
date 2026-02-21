import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData _buildTheme(AppColors colors) {
    final isLight = colors.style == ThemeStyle.claymorphic;
    final textTheme = AppTypography.textTheme(
      textPrimary: colors.textPrimary,
      textSecondary: colors.textSecondary,
      textTertiary: colors.textTertiary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isLight ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      extensions: [colors],
      colorScheme: isLight
          ? ColorScheme.light(
              primary: colors.primary,
              onPrimary: Colors.white,
              secondary: colors.secondary,
              onSecondary: Colors.white,
              surface: colors.surface,
              onSurface: colors.textPrimary,
              onSurfaceVariant: colors.textSecondary,
              surfaceContainerHighest: colors.surfaceCard,
              error: colors.error,
              onError: Colors.white,
              outline: colors.border,
              outlineVariant: colors.divider,
            )
          : ColorScheme.dark(
              primary: colors.primary,
              onPrimary: colors.style == ThemeStyle.skeuomorphic
                  ? colors.background
                  : colors.textPrimary,
              secondary: colors.secondary,
              onSecondary: colors.background,
              surface: colors.surface,
              onSurface: colors.textPrimary,
              onSurfaceVariant: colors.textSecondary,
              surfaceContainerHighest: colors.surfaceCard,
              error: colors.error,
              onError: colors.textPrimary,
              outline: colors.border,
              outlineVariant: colors.divider,
            ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceCard,
        elevation: colors.style == ThemeStyle.skeuomorphic ? 4 : 2,
        shadowColor: colors.style == ThemeStyle.skeuomorphic
            ? Colors.black.withValues(alpha: 0.4)
            : colors.primary.withValues(alpha: 0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(colors.cardRadius),
          side: colors.style == ThemeStyle.claymorphic
              ? BorderSide.none
              : BorderSide(color: colors.border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.style == ThemeStyle.skeuomorphic
              ? const Color(0xFF1C1410)
              : colors.textPrimary,
          elevation: colors.style == ThemeStyle.skeuomorphic ? 4 : 2,
          shadowColor: Colors.black.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(colors.buttonRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.border, width: 1.5),
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(colors.buttonRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            colors.style == ThemeStyle.claymorphic
                ? colors.cardRadius
                : colors.buttonRadius,
          ),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            colors.style == ThemeStyle.claymorphic
                ? colors.cardRadius
                : colors.buttonRadius,
          ),
          borderSide: colors.style == ThemeStyle.claymorphic
              ? BorderSide.none
              : BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            colors.style == ThemeStyle.claymorphic
                ? colors.cardRadius
                : colors.buttonRadius,
          ),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: colors.textTertiary),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
      ),
      iconTheme: IconThemeData(
        color: colors.textSecondary,
        size: 24,
      ),
    );
  }

  static ThemeData get dark => _buildTheme(AppColors.glass());
  static ThemeData get skeuomorphic => _buildTheme(AppColors.skeu());
  static ThemeData get claymorphic => _buildTheme(AppColors.clay());

  static ThemeData forStyle(ThemeStyle style) {
    switch (style) {
      case ThemeStyle.glass:
        return dark;
      case ThemeStyle.skeuomorphic:
        return skeuomorphic;
      case ThemeStyle.claymorphic:
        return claymorphic;
    }
  }
}
