import 'package:flutter/material.dart';

class ServiceItem {
  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.capabilities,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> capabilities;

  static const List<ServiceItem> all = [
    ServiceItem(
      icon: Icons.language,
      title: 'Web Platforms',
      description:
          'Enterprise-grade web applications built for scale, security, and performance.',
      capabilities: [
        'Progressive Web Apps',
        'SaaS Platforms',
        'Admin Dashboards',
        'Real-time Systems',
      ],
    ),
    ServiceItem(
      icon: Icons.phone_iphone,
      title: 'Mobile Engineering',
      description:
          'Native-quality cross-platform mobile applications with unified codebases.',
      capabilities: [
        'Flutter / React Native',
        'iOS & Android',
        'Offline-first Architecture',
        'Push Notification Systems',
      ],
    ),
    ServiceItem(
      icon: Icons.cloud_outlined,
      title: 'Backend & Cloud',
      description:
          'Scalable infrastructure and API systems designed for enterprise workloads.',
      capabilities: [
        'Microservices Architecture',
        'Cloud-native (AWS / GCP)',
        'API Design & Gateway',
        'CI/CD Pipelines',
      ],
    ),
    ServiceItem(
      icon: Icons.architecture,
      title: 'Architecture Consulting',
      description:
          'Strategic technical guidance for teams building complex software systems.',
      capabilities: [
        'System Design Reviews',
        'Tech Stack Selection',
        'Performance Audits',
        'Team Mentorship',
      ],
    ),
  ];
}
