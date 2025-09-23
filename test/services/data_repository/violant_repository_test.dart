import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/api_client.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import '../../test_helpers/test_factory.dart';
import '../../test_helpers/mock_responses.dart';
import '../api_client/test_client.dart';

void main() {
  group('Violant Repository Unit Tests', () {
    late TestClient mockClient;

    setUp(() {
      mockClient = TestClient();
    });

    test('should fetch violants successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulViolantList();

      // Act
      final violants = await ApiClient.fetchDataWithClient<Violant>(
        client: mockClient,
        endpoint: 'violant',
        fromJson: (json) => Violant.fromJson(json),
      );

      // Assert
      expect(violants, isA<List<Violant>>());
      expect(violants.length, 2);
      expect(violants.first.nom, 'TestViolant');
      expect(violants.first.prenom, 'TestPrenom');
      expect(violants.first.cin, 'TEST123');
    });

    test('should get single violant successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulSingleViolant();

      // Act
      final violant = await ApiClient.getDataWithClient<Violant>(
        client: mockClient,
        endpoint: 'violant',
        index: 1,
        fromJson: (json) => Violant.fromJson(json),
      );

      // Assert
      expect(violant, isA<Violant>());
      expect(violant.nom, 'TestViolant');
      expect(violant.prenom, 'TestPrenom');
      expect(violant.cin, 'TEST123');
    });

    test('should create violant successfully', () async {
      // Arrange
      mockClient.postResponse = MockResponses.successfulViolantCreation();
      final testViolant = TestFactory.createViolant();

      // Act
      final result = await ApiClient.postDataWithClient<Violant>(
        client: mockClient,
        endpoint: 'violant',
        object: testViolant,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, contains('created successfully'));
    });

    test('should update violant successfully', () async {
      // Arrange
      mockClient.putResponse = MockResponses.successfulViolantUpdate();
      final testViolant = TestFactory.createViolant();

      // Act
      final result = await ApiClient.updateDataWithClient<Violant>(
        client: mockClient,
        endpoint: 'violant',
        index: 1,
        object: testViolant,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data updated successfully');
    });

    test('should delete violant successfully', () async {
      // Arrange
      mockClient.deleteResponse = MockResponses.successfulViolantDeletion();
      final testViolant = TestFactory.createViolant();

      // Act
      final result = await ApiClient.deleteDataWithClient<Violant>(
        client: mockClient,
        endpoint: 'violant',
        index: 1,
        object: testViolant,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data deleted successfully');
    });
  });
}
