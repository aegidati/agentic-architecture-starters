import 'package:flutter_client/domain/health_status.dart';

abstract class HealthRepository {
  Future<HealthStatus> checkHealth();
}
