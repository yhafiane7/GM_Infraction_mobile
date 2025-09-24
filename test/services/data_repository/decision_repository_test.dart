import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/api_client.dart';
import 'package:gmsoft_infractions_mobile/models/decision_model.dart';
import '../../test_helpers/test_factory.dart';
import '../../test_helpers/mock_responses.dart';
import '../api_client/test_client.dart';

void main() {
  group('Decision Repository Unit Tests', () {
    late TestClient mockClient;

    setUp(() {
      mockClient = TestClient();
    });

    test('should fetch decisions successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulDecisionList();

      // Act
      final decisions = await ApiClient.fetchDataWithClient<Decision>(
        client: mockClient,
        endpoint: 'decision',
        fromJson: (json) => Decision.fromJson(json),
      );

      // Assert
      expect(decisions, isA<List<Decision>>());
      expect(decisions.length, 2);
      expect(decisions.first.decisionPrise, 'TestDecision');
      expect(decisions.first.infractionId, 1);
    });

    test('should get single decision successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulSingleDecision();

      // Act
      final decision = await ApiClient.getDataWithClient<Decision>(
        client: mockClient,
        endpoint: 'decision',
        index: 1,
        fromJson: (json) => Decision.fromJson(json),
      );

      // Assert
      expect(decision, isA<Decision>());
      expect(decision.date, '2025-01-01T00:00:00Z');
      expect(decision.decisionPrise, 'TestDecision');
      expect(decision.infractionId, 1);
    });

    test('should create decision successfully', () async {
      // Arrange
      mockClient.postResponse = MockResponses.successfulDecisionCreation();
      final testDecision = TestFactory.createDecision();

      // Act
      final result = await ApiClient.postDataWithClient<Decision>(
        client: mockClient,
        endpoint: 'decision',
        object: testDecision,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, contains('created successfully'));
    });

    test('should update decision successfully', () async {
      // Arrange
      mockClient.putResponse = MockResponses.successfulDecisionUpdate();
      final testDecision = TestFactory.createDecision();

      // Act
      final result = await ApiClient.updateDataWithClient<Decision>(
        client: mockClient,
        endpoint: 'decision',
        index: 1,
        object: testDecision,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data updated successfully');
    });

    test('should delete decision successfully', () async {
      // Arrange
      mockClient.deleteResponse = MockResponses.successfulDecisionDeletion();
      final testDecision = TestFactory.createDecision();

      // Act
      final result = await ApiClient.deleteDataWithClient<Decision>(
        client: mockClient,
        endpoint: 'decision',
        index: 1,
        object: testDecision,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data deleted successfully');
    });
  });
}
