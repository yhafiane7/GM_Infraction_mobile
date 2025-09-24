import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/api_client.dart';
import 'package:gmsoft_infractions_mobile/models/commune_model.dart';
import '../../test_helpers/test_factory.dart';
import '../../test_helpers/mock_responses.dart';
import '../api_client/test_client.dart';

void main() {
  group('Commune Repository Unit Tests', () {
    late TestClient mockClient;

    setUp(() {
      mockClient = TestClient();
    });

    test('should fetch communes successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulCommuneList();

      // Act
      final communes = await ApiClient.fetchDataWithClient<Commune>(
        client: mockClient,
        endpoint: 'commune',
        fromJson: (json) => Commune.fromJson(json),
      );

      // Assert
      expect(communes, isA<List<Commune>>());
      expect(communes.length, 2);
      expect(communes.first.nom, 'TestCommune');
      expect(communes.first.latitude, 33.5731);
      expect(communes.first.longitude, -7.5898);
    });

    test('should get single commune successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulSingleCommune();

      // Act
      final commune = await ApiClient.getDataWithClient<Commune>(
        client: mockClient,
        endpoint: 'commune',
        index: 1,
        fromJson: (json) => Commune.fromJson(json),
      );

      // Assert
      expect(commune, isA<Commune>());
      expect(commune.nom, 'TestCommune');
      expect(commune.pachalikcircon, 'TestPachalik');
      expect(commune.caidat, 'TestCaidat');
      expect(commune.latitude, 33.5731);
      expect(commune.longitude, -7.5898);
    });

    test('should create commune successfully', () async {
      // Arrange
      mockClient.postResponse = MockResponses.successfulCommuneCreation();
      final testCommune = TestFactory.createCommune();

      // Act
      final result = await ApiClient.postDataWithClient<Commune>(
        client: mockClient,
        endpoint: 'commune',
        object: testCommune,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, contains('created successfully'));
    });

    test('should update commune successfully', () async {
      // Arrange
      mockClient.putResponse = MockResponses.successfulCommuneUpdate();
      final testCommune = TestFactory.createCommune();

      // Act
      final result = await ApiClient.updateDataWithClient<Commune>(
        client: mockClient,
        endpoint: 'commune',
        index: 1,
        object: testCommune,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data updated successfully');
    });

    test('should delete commune successfully', () async {
      // Arrange
      mockClient.deleteResponse = MockResponses.successfulCommuneDeletion();
      final testCommune = TestFactory.createCommune();

      // Act
      final result = await ApiClient.deleteDataWithClient<Commune>(
        client: mockClient,
        endpoint: 'commune',
        index: 1,
        object: testCommune,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data deleted successfully');
    });
  });
}
