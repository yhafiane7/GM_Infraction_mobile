import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/api_client.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import '../../test_helpers/test_factory.dart';
import '../../test_helpers/mock_responses.dart';
import '../api_client/test_client.dart';

void main() {
  group('Agent Repository Unit Tests', () {
    late TestClient mockClient;

    setUp(() {
      mockClient = TestClient();
    });

    test('should fetch agents successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulAgentList();

      // Act
      final agents = await ApiClient.fetchDataWithClient<Agent>(
        client: mockClient,
        endpoint: 'agent',
        fromJson: (json) => Agent.fromJson(json),
      );

      // Assert
      expect(agents, isA<List<Agent>>());
      expect(agents.length, 2);
      expect(agents.first.nom, 'Doe');
      expect(agents.first.prenom, 'John');
      expect(agents.first.tel, '1234567890');
      expect(agents.first.cin, 'AB123456');
    });

    test('should handle fetch agents error', () async {
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

    test('should get single agent successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulSingleAgent();

      // Act
      final agent = await ApiClient.getDataWithClient<Agent>(
        client: mockClient,
        endpoint: 'agent',
        index: 1,
        fromJson: (json) => Agent.fromJson(json),
      );

      // Assert
      expect(agent, isA<Agent>());
      expect(agent.nom, 'Doe');
      expect(agent.prenom, 'John');
      expect(agent.tel, '1234567890');
      expect(agent.cin, 'AB123456');
    });

    test('should handle get single agent error', () async {
      // Arrange
      mockClient.getResponse = MockResponses.notFound();

      // Act & Assert
      expect(
        () => ApiClient.getDataWithClient<Agent>(
          client: mockClient,
          endpoint: 'agent',
          index: 1,
          fromJson: (json) => Agent.fromJson(json),
        ),
        throwsException,
      );
    });

    test('should create agent successfully', () async {
      // Arrange
      mockClient.postResponse = MockResponses.successfulAgentCreation();
      final testAgent = TestFactory.createAgent();

      // Act
      final result = await ApiClient.postDataWithClient<Agent>(
        client: mockClient,
        endpoint: 'agent',
        object: testAgent,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, contains('created successfully'));
    });

    test('should update agent successfully', () async {
      // Arrange
      mockClient.putResponse = MockResponses.successfulAgentUpdate();
      final testAgent = TestFactory.createAgent();

      // Act
      final result = await ApiClient.updateDataWithClient<Agent>(
        client: mockClient,
        endpoint: 'agent',
        index: 1,
        object: testAgent,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data updated successfully');
    });

    test('should delete agent successfully', () async {
      // Arrange
      mockClient.deleteResponse = MockResponses.successfulAgentDeletion();
      final testAgent = TestFactory.createAgent();

      // Act
      final result = await ApiClient.deleteDataWithClient<Agent>(
        client: mockClient,
        endpoint: 'agent',
        index: 1,
        object: testAgent,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data deleted successfully');
    });
  });
}
