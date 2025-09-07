import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/config/app_config.dart';

void main() {
  group('AppConfig Tests', () {
    test('currentBaseUrl should return correct URL', () {
      expect(AppConfig.currentBaseUrl, isA<String>());
      expect(AppConfig.currentBaseUrl, isNotEmpty);
      expect(AppConfig.currentBaseUrl, contains('http'));
    });

    test('currentBaseUrl should be consistent across calls', () {
      final url1 = AppConfig.currentBaseUrl;
      final url2 = AppConfig.currentBaseUrl;

      expect(url1, equals(url2));
    });

    test('currentBaseUrl should end with proper format', () {
      final url = AppConfig.currentBaseUrl;

      // Should not end with slash
      expect(url.endsWith('/'), isFalse);

      // Should contain domain
      expect(url.contains('.'), isTrue);
    });
  });
}
