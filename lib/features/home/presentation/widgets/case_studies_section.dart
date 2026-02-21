import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/animations/hover_scale.dart';
import '../../../../core/animations/scroll_reveal.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ghost_button.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/models/case_study.dart';

class CaseStudiesSection extends StatelessWidget {
  const CaseStudiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final colors = AppColors.of(context);

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Proven Results',
            title: 'Case Studies',
            subtitle: 'Selected engagements showcasing measurable outcomes.',
          ),
          const SizedBox(height: AppSpacing.xxl),
          ...List.generate(CaseStudy.featured.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: ScrollReveal(
                key: ValueKey('case_study_$i'),
                delay: Duration(milliseconds: 200 * i),
                child: HoverScale(
                  glowColor: colors.primary,
                  child: _CaseStudyCard(
                    study: CaseStudy.featured[i],
                    isDesktop: isDesktop,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: GhostButton(
              label: 'View All Case Studies',
              icon: Icons.arrow_forward,
              onPressed: () => context.go('/case-studies'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaseStudyCard extends StatelessWidget {
  const _CaseStudyCard({required this.study, required this.isDesktop});

  final CaseStudy study;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: AppDecoration.card(colors),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _content(textTheme, colors)),
                const SizedBox(width: AppSpacing.xl),
                Expanded(flex: 2, child: _metrics(textTheme, colors)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _content(textTheme, colors),
                const SizedBox(height: AppSpacing.lg),
                _metrics(textTheme, colors),
              ],
            ),
    );
  }

  Widget _content(TextTheme textTheme, AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: AppDecoration.accentBadge(colors),
              child: Text(
                study.industry,
                style: textTheme.labelSmall?.copyWith(
                  color: colors.primary,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(study.client, style: textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(study.title,
            style: textTheme.headlineSmall
                ?.copyWith(color: colors.textPrimary)),
        const SizedBox(height: AppSpacing.sm),
        Text(study.description,
            style: textTheme.bodyMedium
                ?.copyWith(color: colors.textSecondary)),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xs,
          children: study.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: colors.border),
              ),
              child: Text(tech, style: textTheme.labelMedium),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _metrics(TextTheme textTheme, AppColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: study.metrics.map((m) {
        return Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  colors.primaryGradient.createShader(bounds),
              child: Text(
                m.value,
                style: textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(m.label, style: textTheme.bodySmall),
          ],
        );
      }).toList(),
    );
  }
}
