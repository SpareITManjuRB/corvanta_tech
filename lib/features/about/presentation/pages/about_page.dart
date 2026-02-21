import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/section_container.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                    child: Icon(Icons.business,
                        color: colors.primary, size: 36),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('About Corvanta', style: textTheme.headlineMedium),
                  const SizedBox(height: AppSpacing.sm),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Corvanta Technologies is a product engineering studio '
                      'focused on building enterprise-grade digital systems that scale. '
                      'We partner with ambitious teams to architect, build, and ship '
                      'software platforms — from initial system design through '
                      'production deployment and beyond.',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Our mission is to raise the standard of software engineering '
                      'by combining deep technical expertise with pragmatic delivery. '
                      'Every engagement is driven by measurable outcomes — performance, '
                      'reliability, and maintainability.',
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
