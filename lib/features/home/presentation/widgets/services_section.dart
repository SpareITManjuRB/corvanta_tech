import 'package:flutter/material.dart';

import '../../../../core/animations/hover_scale.dart';
import '../../../../core/animations/scroll_reveal.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/models/service_item.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final colors = AppColors.of(context);

    return RepaintBoundary(
      child: SectionContainer(
        backgroundColor: colors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'What We Build',
              title: 'Engineering Services',
              subtitle:
                  'Full-spectrum product engineering — from architecture to deployment.',
            ),
            const SizedBox(height: AppSpacing.xxl),
            isDesktop ? _buildGrid(colors) : _buildList(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(AppColors colors) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
        childAspectRatio: 1.5,
      ),
      itemCount: ServiceItem.all.length,
      itemBuilder: (context, i) => ScrollReveal(
        key: ValueKey('service_$i'),
        delay: Duration(milliseconds: 120 * i),
        child: HoverScale(
          glowColor: colors.primary,
          child: _ServiceCard(service: ServiceItem.all[i]),
        ),
      ),
    );
  }

  Widget _buildList(AppColors colors) {
    return Column(
      children: List.generate(ServiceItem.all.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: ScrollReveal(
            key: ValueKey('service_$i'),
            delay: Duration(milliseconds: 120 * i),
            child: HoverScale(
              glowColor: colors.primary,
              child: _ServiceCard(service: ServiceItem.all[i]),
            ),
          ),
        );
      }),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final ServiceItem service;

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
            child: Icon(service.icon, color: colors.primary, size: 24),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(service.title,
              style: textTheme.titleLarge
                  ?.copyWith(color: colors.textPrimary)),
          const SizedBox(height: AppSpacing.sm),
          Text(service.description,
              style: textTheme.bodyMedium
                  ?.copyWith(color: colors.textSecondary)),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: service.capabilities.map((cap) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: colors.border.withValues(alpha: 0.6),
                  ),
                ),
                child: Text(cap, style: textTheme.labelMedium),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
