import 'package:flutter/foundation.dart';

abstract final class PlatformUtils {
  static bool get isWeb => kIsWeb;

  static bool get isMobileOS {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  static bool get isDesktopOS {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;
  }

  /// Hover effects only make sense on web/desktop
  static bool get supportsHover => isWeb || isDesktopOS;
}
