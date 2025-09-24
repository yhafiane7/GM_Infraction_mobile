import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/api_client.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import '../../test_helpers/test_factory.dart';
import '../../test_helpers/mock_responses.dart';
import '../api_client/test_client.dart';

void main() {
  group('Categorie Repository Unit Tests', () {
    late TestClient mockClient;

    setUp(() {
      mockClient = TestClient();
    });

    test('should fetch categories successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulCategorieList();

      // Act
      final categories = await ApiClient.fetchDataWithClient<Categorie>(
        client: mockClient,
        endpoint: 'categorie',
        fromJson: (json) => Categorie.fromJson(json),
      );

      // Assert
      expect(categories, isA<List<Categorie>>());
      expect(categories.length, 2);
      expect(categories.first.nom, 'TestCategorie');
      expect(categories.first.degre, 1);
    });

    test('should get single categorie successfully', () async {
      // Arrange
      mockClient.getResponse = MockResponses.successfulSingleCategorie();

      // Act
      final categorie = await ApiClient.getDataWithClient<Categorie>(
        client: mockClient,
        endpoint: 'categorie',
        index: 1,
        fromJson: (json) => Categorie.fromJson(json),
      );

      // Assert
      expect(categorie, isA<Categorie>());
      expect(categorie.nom, 'TestCategorie');
      expect(categorie.degre, 1);
    });

    test('should create categorie successfully', () async {
      // Arrange
      mockClient.postResponse = MockResponses.successfulCategorieCreation();
      final testCategorie = TestFactory.createCategorie();

      // Act
      final result = await ApiClient.postDataWithClient<Categorie>(
        client: mockClient,
        endpoint: 'categorie',
        object: testCategorie,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, contains('created successfully'));
    });

    test('should update categorie successfully', () async {
      // Arrange
      mockClient.putResponse = MockResponses.successfulCategorieUpdate();
      final testCategorie = TestFactory.createCategorie();

      // Act
      final result = await ApiClient.updateDataWithClient<Categorie>(
        client: mockClient,
        endpoint: 'categorie',
        index: 1,
        object: testCategorie,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data updated successfully');
    });

    test('should delete categorie successfully', () async {
      // Arrange
      mockClient.deleteResponse = MockResponses.successfulCategorieDeletion();
      final testCategorie = TestFactory.createCategorie();

      // Act
      final result = await ApiClient.deleteDataWithClient<Categorie>(
        client: mockClient,
        endpoint: 'categorie',
        index: 1,
        object: testCategorie,
      );

      // Assert
      expect(result, isA<String>());
      expect(result, 'Data deleted successfully');
    });
  });
}
