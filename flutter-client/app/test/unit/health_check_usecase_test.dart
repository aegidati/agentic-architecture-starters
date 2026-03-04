import 'package:flutter_client/application/ports/health_repository.dart';
import 'package:flutter_client/application/usecases/health_check_usecase.dart';
import 'package:flutter_client/domain/health_status.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeHealthRepository implements HealthRepository {
  _FakeHealthRepository(this._result);

  final HealthStatus _result;

  @override
  Future<HealthStatus> checkHealth() async => _result;
}

void main() {
  test('returns health status from repository', () async {
    final repository = _FakeHealthRepository(const HealthStatus(status: 'ok'));
    final useCase = HealthCheckUseCase(repository);

    final result = await useCase();

    expect(result.status, 'ok');
    expect(result.isOk, true);
  });
}
