import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/api_client.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import '../../test_helpers/test_factory.dart';
import '../../test_helpers/mock_responses.dart';
import '../api_client/test_client.dart';

void main() {
  group('Infraction Repository Unit Tests', () {
    late TestClient mockClient;

    setUp(() {
      mockClient = TestClient();
    });

    test('should fetch infractions successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulInfractionList();

      // Act
      final infractions = await ApiClient.fetchDataWithClient<Infraction>(
        client: mockClient,
        endpoint: 'infraction',
        fromJson: (json) => Infraction.fromJson(json),
      );

      // Assert
      expect(infractions, isA<List<Infraction>>());
      expect(infractions.length, 2);
      expect(infractions.first.nom, 'TestInfraction');
      expect(infractions.first.commune_id, 1);
      expect(infractions.first.latitude, 33.5731);
    });

    test('should get single infraction successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulSingleInfraction();

      // Act
      final infraction = await ApiClient.getDataWithClient<Infraction>(
        client: mockClient,
        endpoint: 'infraction',
        index: 1,
        fromJson: (json) => Infraction.fromJson(json),
      );

      // Assert
      expect(infraction, isA<Infraction>());
      expect(infraction.nom, 'TestInfraction');
      expect(infraction.date, '2025-01-01T00:00:00Z');
      expect(infraction.adresse, 'TestAdresse');
      expect(infraction.commune_id, 1);
      expect(infraction.violant_id, 1);
      expect(infraction.agent_id, 1);
      expect(infraction.categorie_id, 1);
      expect(infraction.latitude, 33.5731);
      expect(infraction.longitude, -7.5898);
    });

    test('should create infraction successfully', () async {
      // Arrange
      mockClient.postResponse = MockResponses.successfulInfractionCreation();
      final testInfraction = TestFactory.createInfraction();

      // Act
      final result = await ApiClient.postDataWithClient<Infraction>(
        client: mockClient,
        endpoint: 'infraction',
        object: testInfraction,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, contains('created successfully'));
    });

    test('should update infraction successfully', () async {
      // Arrange
      mockClient.putResponse = MockResponses.successfulInfractionUpdate();
      final testInfraction = TestFactory.createInfraction();

      // Act
      final result = await ApiClient.updateDataWithClient<Infraction>(
        client: mockClient,
        endpoint: 'infraction',
        index: 1,
        object: testInfraction,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data updated successfully');
    });

    test('should delete infraction successfully', () async {
      // Arrange
      mockClient.deleteResponse = MockResponses.successfulInfractionDeletion();
      final testInfraction = TestFactory.createInfraction();

      // Act
      final result = await ApiClient.deleteDataWithClient<Infraction>(
        client: mockClient,
        endpoint: 'infraction',
        index: 1,
        object: testInfraction,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data deleted successfully');
    });
  });
}
