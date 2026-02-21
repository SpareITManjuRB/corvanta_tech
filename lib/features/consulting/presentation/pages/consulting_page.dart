import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/animations/fade_in_widget.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';

class ConsultingPage extends StatelessWidget {
  const ConsultingPage({super.key});

  static const _engagements = [
    (
      'Technical Discovery Sprint',
      '1-2 Weeks',
      'Comprehensive audit of your existing architecture, identifying performance bottlenecks, security gaps, and scalability constraints.',
      ['Architecture Review', 'Risk Assessment', 'Recommendations Report'],
    ),
    (
      'System Design Workshop',
      '2-4 Weeks',
      'Collaborative design sessions producing production-ready architecture blueprints, data models, and implementation roadmaps.',
      ['System Blueprints', 'Technology Selection', 'Implementation Plan'],
    ),
    (
      'Embedded Engineering',
      'Ongoing',
      'Senior architects working alongside your team, setting patterns, mentoring engineers, and accelerating feature delivery.',
      ['Code Reviews', 'Pair Programming', 'Best Practices'],
    ),
    (
      'Performance Engineering',
      '2-6 Weeks',
      'Systematic analysis and optimization of application performance from infrastructure through frontend rendering.',
      ['Profiling & Analysis', 'Optimization', 'Monitoring Setup'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final colors = AppColors.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'Consulting',
                  title: 'Engagement Models',
                  subtitle:
                      'Flexible consulting formats designed to match your project phase and team needs.',
                ),
                const SizedBox(height: AppSpacing.xxl),
                isDesktop
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: AppSpacing.lg,
                          crossAxisSpacing: AppSpacing.lg,
                          childAspectRatio: 1.3,
                        ),
                        itemCount: _engagements.length,
                        itemBuilder: (context, i) => FadeInWidget(
                          key: ValueKey('engagement_$i'),
                          delay: Duration(milliseconds: 150 * i),
                          child: _EngagementCard(
                            title: _engagements[i].$1,
                            duration: _engagements[i].$2,
                            description: _engagements[i].$3,
                            deliverables: _engagements[i].$4,
                          ),
                        ),
                      )
                    : Column(
                        children: List.generate(_engagements.length, (i) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.md),
                            child: FadeInWidget(
                              key: ValueKey('engagement_$i'),
                              delay: Duration(milliseconds: 150 * i),
                              child: _EngagementCard(
                                title: _engagements[i].$1,
                                duration: _engagements[i].$2,
                                description: _engagements[i].$3,
                                deliverables: _engagements[i].$4,
                              ),
                            ),
                          );
                        }),
                      ),
              ],
            ),
          ),
          SectionContainer(
            backgroundColor: colors.surface,
            child: FadeInWidget(
              key: const ValueKey('consulting_page_cta'),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      Text(
                        'Let\'s discuss your challenge.',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Every engagement starts with a conversation. Tell us about your system, your constraints, and where you want to go.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      GradientButton(
                        label: 'Get in Touch',
                        icon: Icons.arrow_forward,
                        onPressed: () => context.go('/contact'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}

class _EngagementCard extends StatelessWidget {
  const _EngagementCard({
    required this.title,
    required this.duration,
    required this.description,
    required this.deliverables,
  });

  final String title;
  final String duration;
  final String description;
  final List<String> deliverables;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: AppDecoration.surfacePanel(colors),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: textTheme.titleLarge)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: AppDecoration.accentBadge(colors),
                child: Text(
                  duration,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(description, style: textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.md),
          Text(
            'DELIVERABLES',
            style: textTheme.labelSmall?.copyWith(
              color: colors.textTertiary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...deliverables.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 14, color: colors.success),
                    const SizedBox(width: AppSpacing.sm),
                    Text(d, style: textTheme.bodySmall),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
