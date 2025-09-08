import 'package:http/http.dart' as http;

/// Mock HTTP responses for testing
class MockResponses {
  /// Successful agent list response
  static http.Response successfulAgentList() {
    return http.Response('''[
      {"id":1,"nom":"Doe","prenom":"John","tel":"1234567890","cin":"AB123456","created_at":"2024-01-01T00:00:00Z","updated_at":"2024-01-01T00:00:00Z"},
      {"id":2,"nom":"Smith","prenom":"Jane","tel":"0987654321","cin":"CD789012","created_at":"2024-01-01T00:00:00Z","updated_at":"2024-01-01T00:00:00Z"}
    ]''', 200);
  }

  /// Successful agent creation response
  static http.Response successfulAgentCreation() {
    return http.Response('''{"message":"Agent created successfully","data":{"id":1,"nom":"Doe","prenom":"John","tel":"1234567890","cin":"AB123456","created_at":"2024-01-01T00:00:00Z","updated_at":"2024-01-01T00:00:00Z"}}''', 201);
  }

  /// Successful single agent response
  static http.Response successfulSingleAgent() {
    return http.Response(
        '{"id":1,"nom":"Doe","prenom":"John","tel":"1234567890","cin":"AB123456","created_at":"2024-01-01T00:00:00Z","updated_at":"2024-01-01T00:00:00Z"}',
        200);
  }

  /// Validation error response
  static http.Response validationError() {
    return http.Response('''{"message":"Validation failed","errors":{"nom":["The nom field is required."],"tel":["The tel field must be exactly 10 characters."]}}''', 400);
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
