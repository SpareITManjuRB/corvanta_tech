import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_colors.dart';

final themeStyleProvider = StateProvider<ThemeStyle>((ref) => ThemeStyle.glass);
