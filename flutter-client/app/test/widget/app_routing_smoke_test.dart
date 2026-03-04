import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_client/application/ports/health_repository.dart';
import 'package:flutter_client/application/usecases/health_check_usecase.dart';
import 'package:flutter_client/domain/health_status.dart';
import 'package:flutter_client/presentation/app.dart';

class _FakeHealthRepository implements HealthRepository {
  @override
  Future<HealthStatus> checkHealth() async => const HealthStatus(status: 'ok');
}

void main() {
  testWidgets('navigates from home to health route and renders status', (
    tester,
  ) async {
    final useCase = HealthCheckUseCase(_FakeHealthRepository());

    await tester.pumpWidget(FlutterClientApp(healthCheckUseCase: useCase));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Go to health'), findsOneWidget);

    await tester.tap(find.text('Go to health'));
    await tester.pumpAndSettle();

    expect(find.text('Health'), findsOneWidget);
    expect(find.text('Status: ok'), findsOneWidget);
  });
}
