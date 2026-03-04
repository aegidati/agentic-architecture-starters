import 'package:flutter/material.dart';
import 'package:flutter_client/application/usecases/health_check_usecase.dart';
import 'package:flutter_client/infrastructure/http/http_client_factory.dart';
import 'package:flutter_client/infrastructure/http/http_health_repository.dart';
import 'package:flutter_client/presentation/app.dart';

void main() {
  const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  final repository = HttpHealthRepository(
    baseUrl: apiBaseUrl,
    client: createHttpClient(),
  );
  final useCase = HealthCheckUseCase(repository);

  runApp(FlutterClientApp(healthCheckUseCase: useCase));
}
