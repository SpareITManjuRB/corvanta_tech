import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/theme_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class CorvantaApp extends ConsumerWidget {
  const CorvantaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = ref.watch(themeStyleProvider);

    return MaterialApp.router(
      title: 'Corvanta Technologies',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.forStyle(style),
      routerConfig: appRouter,
    );
  }
}
