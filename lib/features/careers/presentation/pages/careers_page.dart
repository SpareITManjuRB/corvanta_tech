import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/section_container.dart';

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SectionContainer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(Icons.work_outline,
                        color: colors.primary, size: 36),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Careers at Corvanta', style: textTheme.headlineMedium),
                  const SizedBox(height: AppSpacing.sm),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'We\'re always looking for talented engineers who are passionate '
                      'about building high-quality software. If you thrive on solving '
                      'complex problems and care deeply about craft, we\'d love to '
                      'hear from you.',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Open positions will be listed here as they become available. '
                      'In the meantime, reach out via our contact page — we\'re '
                      'always open to conversations with exceptional people.',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}
