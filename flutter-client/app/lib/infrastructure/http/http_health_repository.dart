import 'dart:convert';

import 'package:flutter_client/application/ports/health_repository.dart';
import 'package:flutter_client/domain/health_status.dart';
import 'package:http/http.dart' as http;

class HttpHealthRepository implements HealthRepository {
  HttpHealthRepository({required this.baseUrl, required this.client});

  final String baseUrl;
  final http.Client client;

  @override
  Future<HealthStatus> checkHealth() async {
    final baseUri = Uri.parse(baseUrl);
    final uri = baseUri.replace(path: _composePath(baseUri.path, 'health'));

    final response = await client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Health endpoint returned HTTP ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid health payload');
    }

    final status = decoded['status'];
    if (status is! String) {
      throw Exception('Missing or invalid "status" field');
    }

    return HealthStatus(status: status);
  }

  String _composePath(String currentPath, String segment) {
    final normalized = currentPath.endsWith('/')
        ? currentPath.substring(0, currentPath.length - 1)
        : currentPath;

    if (normalized.isEmpty || normalized == '/') {
      return '/$segment';
    }

    return '$normalized/$segment';
  }
}
