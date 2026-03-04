import 'package:flutter_client/application/usecases/health_check_usecase.dart';
import 'package:flutter_client/presentation/pages/health_page.dart';
import 'package:flutter_client/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

GoRouter buildAppRouter(HealthCheckUseCase healthCheckUseCase) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/health',
        builder: (context, state) => HealthPage(useCase: healthCheckUseCase),
      ),
    ],
  );
}
