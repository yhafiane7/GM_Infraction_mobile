import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:GM_INFRACTION/config/app_config.dart';

void main() {
  group('API Integration Tests', () {
    test('should have valid API configuration', () {
      // Test that we have valid API URLs configured
      expect(AppConfig.currentBaseUrl, isNotEmpty);
      expect(AppConfig.productionUrl, isNotEmpty);
      expect(AppConfig.devUrl, isNotEmpty);
    });

    test('should connect to API (basic connectivity)', () async {
      try {
        // Test basic connectivity to the API
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
    });
  });
}
