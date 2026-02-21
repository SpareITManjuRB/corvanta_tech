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
import '../../../home/domain/models/service_item.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

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
                  label: 'Our Capabilities',
                  title: 'Engineering Services',
                  subtitle:
                      'End-to-end product engineering across platforms, from initial system design through production operations.',
                ),
                const SizedBox(height: AppSpacing.xxl),
                ...List.generate(ServiceItem.all.length, (i) {
                  final service = ServiceItem.all[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                    child: FadeInWidget(
                      key: ValueKey('service_detail_$i'),
                      delay: Duration(milliseconds: 150 * i),
                      child: HoverScale(
                        child: _DetailedServiceCard(
                          service: service,
                          isDesktop: isDesktop,
                          index: i,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          SectionContainer(
            backgroundColor: colors.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  label: 'How We Work',
                  title: 'Our Process',
                ),
                const SizedBox(height: AppSpacing.xxl),
                ...List.generate(_processSteps.length, (i) {
                  return FadeInWidget(
                    key: ValueKey('process_$i'),
                    delay: Duration(milliseconds: 120 * i),
                    child: _ProcessStep(
                      step: i + 1,
                      title: _processSteps[i].$1,
                      description: _processSteps[i].$2,
                      isLast: i == _processSteps.length - 1,
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

  static const _processSteps = [
    ('Discovery & Analysis',
        'Deep-dive into your domain, existing systems, and business objectives to define scope and constraints.'),
    ('Architecture & Design',
        'System blueprinting with technology selection, data modeling, and interface contract definitions.'),
    ('Engineering & Iteration',
        'Sprint-based development with continuous integration, code review, and automated testing.'),
    ('Quality Assurance',
        'End-to-end testing including performance, security, and compliance validation.'),
    ('Deployment & Operations',
        'Production rollout with monitoring, alerting, and operational runbook handoff.'),
  ];
}

class _DetailedServiceCard extends StatelessWidget {
  const _DetailedServiceCard({
    required this.service,
    required this.isDesktop,
    required this.index,
  });

  final ServiceItem service;
  final bool isDesktop;
  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return Container(
      padding: EdgeInsets.all(isDesktop ? AppSpacing.xl : AppSpacing.lg),
      decoration: AppDecoration.surfacePanel(colors),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _iconBlock(colors),
                const SizedBox(width: AppSpacing.xl),
                Expanded(child: _body(textTheme, colors)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _iconBlock(colors),
                const SizedBox(height: AppSpacing.md),
                _body(textTheme, colors),
              ],
            ),
    );
  }

  Widget _iconBlock(AppColors colors) {
    return Container(
      width: 64,
      height: 64,
      decoration: AppDecoration.primaryButton(colors),
      child: Icon(service.icon, color: Colors.white, size: 28),
    );
  }

  Widget _body(TextTheme textTheme, AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(service.title, style: textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(service.description, style: textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: service.capabilities.map((cap) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: colors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                cap,
                style: textTheme.labelMedium?.copyWith(
                  color: colors.primaryLight,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ProcessStep extends StatelessWidget {
  const _ProcessStep({
    required this.step,
    required this.title,
    required this.description,
    required this.isLast,
  });

  final int step;
  final String title;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$step',
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.primary,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: colors.border,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text(description, style: textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
