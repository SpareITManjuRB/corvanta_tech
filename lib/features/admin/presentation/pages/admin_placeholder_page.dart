import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/section_container.dart';

class AdminPlaceholderPage extends StatelessWidget {
  const AdminPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return SectionContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: AppDecoration.iconContainer(colors),
              child: Icon(Icons.admin_panel_settings,
                  color: colors.primary, size: 36),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Admin Dashboard', style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This module is under development.\nAuthentication and role-based access will be required.',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
