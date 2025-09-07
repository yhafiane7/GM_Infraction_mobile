import 'package:http/http.dart' as http;
import 'test_data_generator.dart';

/// Mock HTTP responses for testing
class MockResponses {
  /// Successful agent list response
  static http.Response successfulAgentList() {
    return http.Response(TestData.validAgentListResponse, 200);
  }

  /// Successful agent creation response
  static http.Response successfulAgentCreation() {
    return http.Response(TestData.validAgentCreateResponse, 201);
  }

  /// Successful single agent response
  static http.Response successfulSingleAgent() {
    return http.Response(
        '{"id":1,"nom":"Doe","prenom":"John","tel":"1234567890","cin":"AB123456","created_at":"2024-01-01T00:00:00Z","updated_at":"2024-01-01T00:00:00Z"}',
        200);
  }

  /// Validation error response
  static http.Response validationError() {
    return http.Response(TestData.validationErrorResponse, 400);
  }

  /// Server error response
  static http.Response serverError() {
    return http.Response('{"message": "Internal server error"}', 500);
  }

  /// Network error response
  static http.Response networkError() {
    return http.Response('', 0); // Simulates network failure
  }

  /// Not found response
  static http.Response notFound() {
    return http.Response('{"message": "Agent not found"}', 404);
  }
}
