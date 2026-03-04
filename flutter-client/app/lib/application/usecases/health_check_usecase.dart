import 'package:flutter_client/application/ports/health_repository.dart';
import 'package:flutter_client/domain/health_status.dart';

class HealthCheckUseCase {
  HealthCheckUseCase(this._repository);

  final HealthRepository _repository;

  Future<HealthStatus> call() => _repository.checkHealth();
}
