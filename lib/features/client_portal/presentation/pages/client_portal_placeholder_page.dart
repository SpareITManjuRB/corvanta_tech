import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/section_container.dart';

class ClientPortalPlaceholderPage extends StatelessWidget {
  const ClientPortalPlaceholderPage({super.key});

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
              decoration: AppDecoration.iconContainer(colors).copyWith(
                color: colors.secondary.withValues(alpha: 0.15),
              ),
              child: Icon(Icons.dashboard_customize,
                  color: colors.secondary, size: 36),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Client Portal', style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This module is under development.\nProject tracking, deliverables, and communication hub coming soon.',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
