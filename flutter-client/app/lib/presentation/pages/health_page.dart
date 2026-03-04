import 'package:flutter/material.dart';
import 'package:flutter_client/application/usecases/health_check_usecase.dart';
import 'package:flutter_client/presentation/state/health_controller.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key, required this.useCase});

  final HealthCheckUseCase useCase;

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  late final HealthController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HealthController(healthCheckUseCase: widget.useCase);
    _controller.loadHealth();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            if (_controller.isLoading) {
              return const CircularProgressIndicator();
            }

            if (_controller.errorMessage != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _controller.errorMessage!,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _controller.loadHealth,
                    child: const Text('Retry'),
                  ),
                ],
              );
            }

            final status = _controller.healthStatus?.status ?? 'unknown';
            return Text('Status: $status');
          },
        ),
      ),
    );
  }
}
