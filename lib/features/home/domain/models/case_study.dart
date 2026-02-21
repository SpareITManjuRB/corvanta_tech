class CaseStudy {
  const CaseStudy({
    required this.client,
    required this.industry,
    required this.title,
    required this.description,
    required this.metrics,
    required this.technologies,
  });

  final String client;
  final String industry;
  final String title;
  final String description;
  final List<CaseMetric> metrics;
  final List<String> technologies;

  static const List<CaseStudy> featured = [
    CaseStudy(
      client: 'FinEdge Systems',
      industry: 'FinTech',
      title: 'Real-time Trading Platform',
      description:
          'Rebuilt legacy monolith into event-driven microservices handling 50K+ transactions per second with sub-10ms latency.',
      metrics: [
        CaseMetric(value: '99.99%', label: 'Uptime'),
        CaseMetric(value: '<10ms', label: 'Latency'),
        CaseMetric(value: '50K+', label: 'TPS'),
      ],
      technologies: ['Go', 'Kafka', 'Redis', 'Kubernetes'],
    ),
    CaseStudy(
      client: 'MedCore Health',
      industry: 'HealthTech',
      title: 'Patient Management Suite',
      description:
          'HIPAA-compliant cross-platform application serving 200+ clinics with offline-first sync and real-time collaboration.',
      metrics: [
        CaseMetric(value: '200+', label: 'Clinics'),
        CaseMetric(value: '40%', label: 'Time Saved'),
        CaseMetric(value: '4.8', label: 'App Rating'),
      ],
      technologies: ['Flutter', 'Node.js', 'PostgreSQL', 'AWS'],
    ),
    CaseStudy(
      client: 'LogiTrack Global',
      industry: 'Logistics',
      title: 'Fleet Intelligence Platform',
      description:
          'IoT-integrated fleet management system processing telemetry from 10K+ vehicles with predictive maintenance engine.',
      metrics: [
        CaseMetric(value: '10K+', label: 'Vehicles'),
        CaseMetric(value: '30%', label: 'Cost Reduced'),
        CaseMetric(value: '95%', label: 'Prediction Acc.'),
      ],
      technologies: ['Python', 'TensorFlow', 'Grafana', 'GCP'],
    ),
  ];
}

class CaseMetric {
  const CaseMetric({required this.value, required this.label});

  final String value;
  final String label;
}
