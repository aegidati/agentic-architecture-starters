import 'package:flutter/foundation.dart';
import 'package:flutter_client/application/usecases/health_check_usecase.dart';
import 'package:flutter_client/domain/health_status.dart';

class HealthController extends ChangeNotifier {
  HealthController({required HealthCheckUseCase healthCheckUseCase})
      : _healthCheckUseCase = healthCheckUseCase;

  final HealthCheckUseCase _healthCheckUseCase;

  bool _isLoading = false;
  HealthStatus? _healthStatus;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  HealthStatus? get healthStatus => _healthStatus;
  String? get errorMessage => _errorMessage;

  Future<void> loadHealth() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _healthStatus = await _healthCheckUseCase();
    } catch (error) {
      _healthStatus = null;
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
