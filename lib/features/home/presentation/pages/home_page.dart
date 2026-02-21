import 'package:flutter/material.dart';

import '../../../../core/widgets/app_footer.dart';
import '../widgets/case_studies_section.dart';
import '../widgets/consulting_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/services_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HeroSection(),
          ServicesSection(),
          CaseStudiesSection(),
          ConsultingSection(),
          AppFooter(),
        ],
      ),
    );
  }
}
