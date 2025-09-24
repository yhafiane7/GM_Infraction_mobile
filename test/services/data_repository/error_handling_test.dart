import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/api_client.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import '../../test_helpers/test_factory.dart';
import '../../test_helpers/mock_responses.dart';
import '../api_client/test_client.dart';

void main() {
  group('Data Repository Error Handling Tests', () {
    late TestClient mockClient;

    setUp(() {
      mockClient = TestClient();
    });

    test('should handle network errors gracefully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.networkError();

      // Act & Assert
      expect(
        () => ApiClient.fetchDataWithClient<Agent>(
          client: mockClient,
          endpoint: 'agent',
          fromJson: (json) => Agent.fromJson(json),
        ),
        throwsException,
      );
    });

    test('should handle server errors gracefully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.serverError();

      // Act & Assert
      expect(
        () => ApiClient.fetchDataWithClient<Agent>(
          client: mockClient,
          endpoint: 'agent',
          fromJson: (json) => Agent.fromJson(json),
        ),
        throwsException,
      );
    });

    test('should handle validation errors in POST requests', () async {
      // Arrange
      mockClient.postResponse = MockResponses.validationError();
      final invalidAgent =
          TestFactory.agentBuilder().withName('').withTel('123').build();

      // Act
      final result = await ApiClient.postDataWithClient<Agent>(
        client: mockClient,
        endpoint: 'agent',
        object: invalidAgent,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, contains('nom: The nom field is required.'));
      expect(result,
          contains('tel: The tel field must be exactly 10 characters.'));
    });

    test('should handle not found errors in GET requests', () async {
      // Arrange
      mockClient.getResponse = MockResponses.notFound();

      // Act & Assert
      expect(
        () => ApiClient.getDataWithClient<Agent>(
          client: mockClient,
          endpoint: 'agent',
          index: 999,
          fromJson: (json) => Agent.fromJson(json),
        ),
        throwsException,
      );
    });
  });
}
