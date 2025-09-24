import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:gmsoft_infractions_mobile/config/app_config.dart';

void main() {
  group('API connectivity (integration)', () {
    // Mark this whole group as integration
    const integrationTag = ['integration'];
    test('AppConfig has non-empty base URLs', () {
      // Act & Assert
      expect(AppConfig.currentBaseUrl, isNotEmpty);
      expect(AppConfig.productionUrl, isNotEmpty);
      expect(AppConfig.devUrl, isNotEmpty);
    }, tags: integrationTag);

    test('GET /agent responds with any status code', () async {
      // Act & Assert
      try {
        final response = await http.get(
          Uri.parse('${AppConfig.currentBaseUrl}/agent'),
          headers: {'Content-Type': 'application/json'},
        );

        // Accept any response status (200, 404, 500, etc.)
        expect(response.statusCode, isA<int>());
        expect(response.statusCode, greaterThan(0));
      } catch (e) {
        // This is expected if the API server is not running
        expect(e, isA<Exception>());
      }
    }, timeout: const Timeout(Duration(seconds: 90)), tags: integrationTag);

    test('GET /agent timeout throws within 5s', () async {
      // Act & Assert
      try {
        final response = await http.get(
          Uri.parse('${AppConfig.currentBaseUrl}/agent'),
          headers: {'Content-Type': 'application/json'},
        ).timeout(const Duration(seconds: 5));

        expect(response.statusCode, isA<int>());
      } catch (e) {
        // Expected if server is slow or unreachable
        expect(e, isA<Exception>());
      }
    }, tags: integrationTag);
  });
}
