import 'package:flutter/material.dart';

import '../../../../core/animations/fade_in_widget.dart';
import '../../../../core/animations/hover_scale.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../home/domain/models/case_study.dart';

class CaseStudiesPage extends StatelessWidget {
  const CaseStudiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'Portfolio',
                  title: 'Case Studies',
                  subtitle:
                      'Detailed breakdowns of our most impactful engagements across industries.',
                ),
                const SizedBox(height: AppSpacing.xxl),
                ...List.generate(CaseStudy.featured.length, (i) {
                  final study = CaseStudy.featured[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                    child: FadeInWidget(
                      key: ValueKey('cs_detail_$i'),
                      delay: Duration(milliseconds: 200 * i),
                      child: HoverScale(
                        child: _ExpandedCaseStudy(
                          study: study,
                          isDesktop: isDesktop,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}

class _ExpandedCaseStudy extends StatelessWidget {
  const _ExpandedCaseStudy({required this.study, required this.isDesktop});

  final CaseStudy study;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return Container(
      padding: EdgeInsets.all(isDesktop ? AppSpacing.xl : AppSpacing.lg),
      decoration: AppDecoration.surfacePanel(colors),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: AppDecoration.primaryButton(colors),
                child: Text(
                  study.industry,
                  style: textTheme.labelMedium?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(study.client, style: textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(study.title, style: textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          Text(study.description, style: textTheme.bodyLarge),
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(colors.cardRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: study.metrics.map((m) {
                return Column(
                  children: [
                    Text(
                      m.value,
                      style: textTheme.headlineLarge?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(m.label, style: textTheme.bodySmall),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'TECHNOLOGY STACK',
            style: textTheme.labelSmall?.copyWith(
              color: colors.textTertiary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: study.technologies.map((tech) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(colors.buttonRadius),
                  border: Border.all(color: colors.border),
                ),
                child: Text(tech, style: textTheme.titleSmall),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
