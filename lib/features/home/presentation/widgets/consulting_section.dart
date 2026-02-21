import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/animations/scroll_reveal.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';

class ConsultingSection extends StatelessWidget {
  const ConsultingSection({super.key});

  static const _offerings = [
    (
      Icons.search,
      'Technical Discovery',
      'Deep-dive analysis of your existing systems, identifying bottlenecks, risks, and opportunities for improvement.',
    ),
    (
      Icons.account_tree,
      'Architecture Design',
      'Comprehensive system design with scalability blueprints, technology selection, and implementation roadmaps.',
    ),
    (
      Icons.speed,
      'Performance Engineering',
      'Systematic optimization of application performance, from database tuning to frontend rendering.',
    ),
    (
      Icons.groups,
      'Team Augmentation',
      'Senior engineers embedded in your team to accelerate delivery and elevate engineering practices.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final colors = AppColors.of(context);

    return SectionContainer(
      backgroundColor: colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Strategic Partnership',
            title: 'Consulting Services',
            subtitle:
                'Engage our senior architects for strategic guidance on your most critical technical challenges.',
          ),
          const SizedBox(height: AppSpacing.xxl),
          isDesktop ? _buildGrid(context) : _buildList(context),
          const SizedBox(height: AppSpacing.xxl),
          ScrollReveal(
            key: const ValueKey('consulting_cta'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: AppDecoration.cardElevated(colors),
              child: Column(
                children: [
                  Text(
                    'Ready to elevate your engineering?',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Schedule a complimentary technical consultation with our architects.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  GradientButton(
                    label: 'Book Consultation',
                    icon: Icons.calendar_today,
                    onPressed: () => context.go('/contact'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
        childAspectRatio: 2.0,
      ),
      itemCount: _offerings.length,
      itemBuilder: (context, i) {
        return ScrollReveal(
          key: ValueKey('consulting_$i'),
          delay: Duration(milliseconds: 120 * i),
          child: _OfferingCard(
            icon: _offerings[i].$1,
            title: _offerings[i].$2,
            description: _offerings[i].$3,
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return Column(
      children: List.generate(_offerings.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: ScrollReveal(
            key: ValueKey('consulting_$i'),
            delay: Duration(milliseconds: 120 * i),
            child: _OfferingCard(
              icon: _offerings[i].$1,
              title: _offerings[i].$2,
              description: _offerings[i].$3,
            ),
          ),
        );
      }),
    );
  }
}

class _OfferingCard extends StatelessWidget {
  const _OfferingCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: AppDecoration.card(colors),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: AppDecoration.iconContainer(colors),
            child: Icon(icon, color: colors.primary, size: 24),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(title,
              style: textTheme.titleLarge
                  ?.copyWith(color: colors.textPrimary)),
          const SizedBox(height: AppSpacing.sm),
          Text(description,
              style: textTheme.bodyMedium
                  ?.copyWith(color: colors.textSecondary)),
        ],
      ),
    );
  }
}
