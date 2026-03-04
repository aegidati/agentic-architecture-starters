import 'package:flutter/material.dart';
import 'package:flutter_client/application/usecases/health_check_usecase.dart';
import 'package:flutter_client/presentation/routing/app_router.dart';

class FlutterClientApp extends StatelessWidget {
  const FlutterClientApp({
    super.key,
    required this.healthCheckUseCase,
  });

  final HealthCheckUseCase healthCheckUseCase;

  @override
  Widget build(BuildContext context) {
    final router = buildAppRouter(healthCheckUseCase);

    return MaterialApp.router(
      title: 'Flutter Client Starter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
