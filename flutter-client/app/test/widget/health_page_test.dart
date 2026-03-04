import 'package:flutter/material.dart';
import 'package:flutter_client/application/ports/health_repository.dart';
import 'package:flutter_client/application/usecases/health_check_usecase.dart';
import 'package:flutter_client/domain/health_status.dart';
import 'package:flutter_client/presentation/pages/health_page.dart';
import 'package:flutter_test/flutter_test.dart';

class _SuccessHealthRepository implements HealthRepository {
  @override
  Future<HealthStatus> checkHealth() async => const HealthStatus(status: 'ok');
}

class _FailingHealthRepository implements HealthRepository {
  @override
  Future<HealthStatus> checkHealth() {
    throw Exception('backend unavailable');
  }
}

void main() {
  testWidgets('shows health status after loading', (tester) async {
    final useCase = HealthCheckUseCase(_SuccessHealthRepository());

    await tester.pumpWidget(
      MaterialApp(home: HealthPage(useCase: useCase)),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Status: ok'), findsOneWidget);
  });

  testWidgets('shows error state and retry button on failure', (tester) async {
    final useCase = HealthCheckUseCase(_FailingHealthRepository());

    await tester.pumpWidget(
      MaterialApp(home: HealthPage(useCase: useCase)),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('backend unavailable'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}
