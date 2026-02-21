import 'package:flutter/material.dart';

import '../../../../core/animations/fade_in_widget.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_footer.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/section_container.dart';
import '../../../../core/widgets/section_header.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SectionContainer(
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _contactInfo(context)),
                      const SizedBox(width: AppSpacing.xxl),
                      Expanded(flex: 6, child: _contactForm(context)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _contactInfo(context),
                      const SizedBox(height: AppSpacing.xxl),
                      _contactForm(context),
                    ],
                  ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _contactInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    return FadeInWidget(
      key: const ValueKey('contact_info'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'Contact',
            title: 'Start a Conversation',
            subtitle:
                'Tell us about your project. We respond within 24 hours.',
          ),
          const SizedBox(height: AppSpacing.xxl),
          _contactItem(context, Icons.email_outlined, 'Email',
              'hello@corvanta.tech'),
          const SizedBox(height: AppSpacing.lg),
          _contactItem(context, Icons.location_on_outlined, 'Location',
              'Remote-first, Global Delivery'),
          const SizedBox(height: AppSpacing.lg),
          _contactItem(context, Icons.schedule, 'Response Time',
              'Within 24 business hours'),
          const SizedBox(height: AppSpacing.xxl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: AppDecoration.surfacePanel(colors),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('What happens next?', style: textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                _stepItem(
                    textTheme, colors, '1', 'We review your requirements'),
                _stepItem(textTheme, colors, '2',
                    'Schedule a technical discovery call'),
                _stepItem(textTheme, colors, '3',
                    'Deliver a proposal within 5 days'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactItem(
      BuildContext context, IconData icon, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: AppDecoration.iconContainer(colors),
          child: Icon(icon, color: colors.primary, size: 20),
        ),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: textTheme.bodySmall),
            Text(value,
                style: textTheme.titleSmall
                    ?.copyWith(color: colors.textPrimary)),
          ],
        ),
      ],
    );
  }

  Widget _stepItem(
      TextTheme textTheme, AppColors colors, String num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(num,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(text, style: textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _contactForm(BuildContext context) {
    final colors = AppColors.of(context);
    return FadeInWidget(
      key: const ValueKey('contact_form'),
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: AppDecoration.surfacePanel(colors),
        child: const _ContactFormBody(),
      ),
    );
  }
}

class _ContactFormBody extends StatefulWidget {
  const _ContactFormBody();

  @override
  State<_ContactFormBody> createState() => _ContactFormBodyState();
}

class _ContactFormBodyState extends State<_ContactFormBody> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = AppColors.of(context);

    if (_submitted) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: colors.success, size: 48),
              const SizedBox(height: AppSpacing.md),
              Text('Message Sent', style: textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              Text('We\'ll be in touch within 24 hours.',
                  style: textTheme.bodyLarge),
            ],
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send us a message', style: textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.lg),
          TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Full Name', hintText: 'John Smith')),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Work Email', hintText: 'john@company.com')),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Company', hintText: 'Company name')),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Project Type'),
            dropdownColor: colors.surfaceVariant,
            items: const [
              DropdownMenuItem(value: 'web', child: Text('Web Platform')),
              DropdownMenuItem(value: 'mobile', child: Text('Mobile App')),
              DropdownMenuItem(
                  value: 'backend', child: Text('Backend / Cloud')),
              DropdownMenuItem(
                  value: 'consulting', child: Text('Consulting')),
              DropdownMenuItem(value: 'other', child: Text('Other')),
            ],
            onChanged: (_) {},
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Project Details',
              hintText: 'Tell us about your project...',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          GradientButton(
            label: 'Send Message',
            icon: Icons.send,
            onPressed: () => setState(() => _submitted = true),
          ),
        ],
      ),
    );
  }
}
