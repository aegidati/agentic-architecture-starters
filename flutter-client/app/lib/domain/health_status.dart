class HealthStatus {
  const HealthStatus({required this.status});

  final String status;

  bool get isOk => status.toLowerCase() == 'ok';
}
