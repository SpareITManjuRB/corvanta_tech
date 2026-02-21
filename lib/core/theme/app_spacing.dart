import 'package:flutter/material.dart';

/// 8pt spacing grid system
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
  static const double section = 80;
  static const double sectionLarge = 120;

  // Padding presets
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(vertical: section);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);

  // Content max widths
  static const double maxContentWidth = 1200;
  static const double maxNarrowWidth = 800;
}
